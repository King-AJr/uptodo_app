import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uptodo/resusable_widgets/loader.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/getit.dart';
import 'package:uptodo/view-models/auth_vm.dart';

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

String formatTaskTime(String? taskTimeStr) {
  if (taskTimeStr == null) {
    return 'No time provided';
  }

  try {
    // Parse the string to DateTime
    final taskTime = DateTime.parse(taskTimeStr);
    final today = DateTime.now();
    final formatter = DateFormat('HH:mm');

    if (taskTime.year == today.year &&
        taskTime.month == today.month &&
        taskTime.day == today.day) {
      // Task is today
      return 'Today at ${formatter.format(taskTime)}';
    } else {
      // Task is not today
      final dateFormatter = DateFormat('MM-dd');
      return '${dateFormatter.format(taskTime)} at ${formatter.format(taskTime)}';
    }
  } catch (e) {
    // Handle parsing error
    return 'Invalid date format';
  }
}
