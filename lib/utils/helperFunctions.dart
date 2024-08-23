import 'package:flutter/material.dart';
import 'package:get/get.dart';
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