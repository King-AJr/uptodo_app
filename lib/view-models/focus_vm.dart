import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uptodo/models/focus_model.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';
import 'package:uptodo/utils/server.dart';

class FocusModeVm extends ChangeNotifier {
  FocusResponse? focusResponse;
  Duration todayFocusDuration = Duration.zero;

  Future<void> sendFocusData(
      BuildContext context, DateTime startTime, DateTime endTime) async {
    final durationInSeconds = endTime.difference(startTime).inSeconds;

    try {
      final response = await Server().req(
        '/focus',
        type: 'post',
        data: {
          'duration_seconds': durationInSeconds,
        },
      );

      final Map<String, dynamic> body = json.decode(response.body);

      if (response.statusCode == 201) {
        successAlert(body['message']);
        await fetchFocusData(context, 'thisWeek');
      } else {
        errorAlert(body['message']);
      }
    } catch (error) {
      errorAlert('Network error: $error');
    }
  }

  Future<void> fetchFocusData(BuildContext context, String interval) async {
    try {
      final response = await Server().req(
        '/focus/data',
        type: 'post',
        data: {
          'interval': interval,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);
        print(body);
        focusResponse = FocusResponse.fromJson(body);

        notifyListeners();
      } else {
        errorAlert('Error fetching focus data: ${response.body.message}');
      }
    } catch (error) {
      // Handle network errors
      errorAlert('Network error: $error');
    }
  }

  Future<void> loadTodaysFocusTime() async {
    final response = await Server().req('/focus/today');
    final Map<String, dynamic> body = json.decode(response.body);
    if (body['success'] == true) {
      todayFocusDuration = Duration(seconds: body['data']['duration_seconds']);
      notifyListeners();
    } else {
      errorAlert(body['message']);
    }
  }
}
