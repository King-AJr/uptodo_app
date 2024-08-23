import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';

class DateTimePicker extends StatelessWidget {
  final Function(DateTime) onDateTimeSelected;
  final DateTime? initialDateTime;

  DateTimePicker({required this.onDateTimeSelected, this.initialDateTime});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.timer_outlined, size: 24),
      onPressed: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDateTime ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (selectedDate != null) {
          TimeOfDay? selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input);

          if (selectedTime != null) {
            DateTime finalDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            onDateTimeSelected(finalDateTime);
          }
        }
      },
    );
  }
}
