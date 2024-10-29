import 'dart:async';
import 'dart:io';
import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/view-models/focus_vm.dart';
import 'notifications_helper.dart';

bool isFocusing = false;
Timer? _timer;
int _seconds = 0;
Map<String, Duration> appUsageData = {};

Future<void> loadFocusData(BuildContext context) async {
  try {
    final taskVm = Provider.of<FocusModeVm>(context, listen: false);
    await taskVm.fetchFocusData(context, 'thisWeek');
  } catch (e) {
    print('Error loading focus data: $e');
  }
}

Future<void> fetchAppUsage(BuildContext context) async {
  if (Platform.isAndroid) {
    try {
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
      appUsageData = {
        'Instagram': _getAppUsageDuration(infoList, 'Instagram'),
        'Twitter': _getAppUsageDuration(infoList, 'Twitter'),
        'Facebook': _getAppUsageDuration(infoList, 'Facebook'),
        'Telegram': _getAppUsageDuration(infoList, 'Telegram'),
        'Gmail': _getAppUsageDuration(infoList, 'Gmail'),
      };
    } catch (e) {
      print('Error fetching app usage: $e');
    }
  }
}

Duration _getAppUsageDuration(List<AppUsageInfo> infoList, String appName) {
  DateTime startOfDay = DateTime.now().toLocal();
  startOfDay = DateTime(startOfDay.year, startOfDay.month, startOfDay.day);
  DateTime endOfDay = startOfDay.add(const Duration(days: 1));

  List<AppUsageInfo> filteredList = infoList.where((info) {
    return info.appName == appName &&
        (info.startDate.isBefore(endOfDay) && info.endDate.isAfter(startOfDay));
  }).toList();

  Duration totalUsage = Duration.zero;
  for (var info in filteredList) {
    DateTime usageStart = info.startDate.isBefore(startOfDay) ? startOfDay : info.startDate;
    DateTime usageEnd = info.endDate.isAfter(endOfDay) ? endOfDay : info.endDate;
    totalUsage += usageEnd.difference(usageStart);
  }

  return totalUsage;
}

void _startFocus(BuildContext context) async {
  if (Platform.isAndroid) {
    bool? hasPermission = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (hasPermission != null && !hasPermission) {
      await FlutterDnd.gotoPolicySettings;
      return;
    }
    await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
    isFocusing = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds++;
    });
    showFocusModeNotification();
  }
}

void stopFocus() {
  isFocusing = false;
  _timer?.cancel();
}

String get formattedTime {
  int minutes = _seconds ~/ 60;
  int seconds = _seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
