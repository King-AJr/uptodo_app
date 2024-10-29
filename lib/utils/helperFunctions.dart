import 'dart:convert';
import 'dart:io';
import 'package:ars_dialog/ars_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart'; 
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uptodo/resusable_widgets/loader.dart';
import 'package:uptodo/utils/colors.dart';

Color getDarkerShade(Color color, [double factor = 0.5]) {
  // Ensure the factor is between 0 and 1
  factor = factor.clamp(0.0, 1.0);

  return Color.fromRGBO(
    (color.red * factor).toInt(),
    (color.green * factor).toInt(),
    (color.blue * factor).toInt(),
    1.0,
  );
}

Future<DateTime?> pickDateTime(BuildContext context) async {
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (selectedDate != null) {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    }
  }
  return null;
}

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(50.0),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class FullScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: primaryColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              AnimationLoaderWidget(text: text)
            ],
          ),
        ),
      ),
    );
  }

  static stopLoader() {
    Navigator.of(Get.overlayContext!).pop();
  }
}

Future<void> writeToFile(Map<String, dynamic> jsonData) async {
  try {
    // Get the application's documents directory
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/currencies_output.json';

    final file = File(path);

    final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
    await file.writeAsString(jsonString);

    print('JSON data written to file: $path');
  } catch (e) {
    print('Error writing JSON to file: $e');
  }
}

String formatTaskTime(String? taskTimeStr, {bool? dateOnly}) {
  if (taskTimeStr == null) {
    return 'No time provided';
  }

  try {
    // Parse the string to DateTime
    final taskTime = DateTime.parse(taskTimeStr);
    final today = DateTime.now();
    final dateFormatter = DateFormat('MMM-dd');
    final fullDateFormatter = DateFormat('MM-dd');
    final timeFormatter = DateFormat('HH:mm');

    if (dateOnly != null && dateOnly == true) {
      if (taskTime.year == today.year &&
          taskTime.month == today.month &&
          taskTime.day == today.day) {
        // Task is today
        return 'Today';
      } else {
        // Task is not today
        return dateFormatter.format(taskTime);
      }
    } else {
      // Return date and time
      if (taskTime.year == today.year &&
          taskTime.month == today.month &&
          taskTime.day == today.day) {
        return 'Today at ${timeFormatter.format(taskTime)}';
      } else {
        return '${fullDateFormatter.format(taskTime)} at ${timeFormatter.format(taskTime)}';
      }
    }
  } catch (e) {
    // Handle parsing error
    return 'Invalid date format';
  }
}

progressLoader(context) => CustomProgressDialog(
      context,
      blur: 5,
      dismissable: false,
      backgroundColor: primaryColor,
    );

String formatToHoursAndMinutes(double timeInHours) {
  // Get the integer part of the hours
  int hours = timeInHours.floor();

  // Get the fractional part of the hours, multiply by 60 to get minutes
  int minutes = ((timeInHours - hours) * 60).round();

  // Format and return the result as '4hr 30m' or '0m' if no hours
  String formattedTime = '';

  if (hours > 0) {
    formattedTime = '${hours}h';
  }
  if (minutes > 0) {
    formattedTime += formattedTime.isNotEmpty ? ' ${minutes}m' : '${minutes}m';
  }

  return formattedTime.isNotEmpty ? formattedTime : '0m';
}

Future<calendar.CalendarApi?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn(
    scopes: [calendar.CalendarApi.calendarScope],
  ).signIn();

  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final calendar.CalendarApi calendarApi = calendar.CalendarApi(
      clientViaApiKey(googleAuth.accessToken!),
    );
    return calendarApi;
  }
  return null;
}
