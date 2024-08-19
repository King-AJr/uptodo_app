import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

class HorizontalDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const HorizontalDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late DateTime selectedDate;
  late List<DateTime> days;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    _updateDays();
  }

  void _updateDays() {
    final firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);
    days = List.generate(
      lastDayOfMonth.day,
      (index) => DateTime(selectedDate.year, selectedDate.month, index + 1),
    );
  }

  void _previousMonth() {
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
      _updateDays();
    });
  }

  void _nextMonth() {
    setState(() {
      selectedDate =
          DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
      _updateDays();
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateSelected(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomNavBar,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon:
                    const Icon(Icons.arrow_back_ios, size: 16, color: white87),
                onPressed: _previousMonth,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMMM').format(selectedDate).toUpperCase(),
                        style: s14MedWhite87.copyWith(
                          fontFamily: 'latoRegular',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DateFormat('yyy').format(selectedDate).toUpperCase(),
                        style: s16RegWhite87.copyWith(
                            fontSize: 10, color: greyText),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_outlined,
                    size: 16, color: white87),
                onPressed: _nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                DateTime date = days[index];
                bool isSelected = date.day == selectedDate.day &&
                    date.month == selectedDate.month &&
                    date.year == selectedDate.year;

                bool weekStartandEnd = date.weekday == DateTime.sunday ||
                    date.weekday == DateTime.saturday;

                Color textColor = weekStartandEnd ? appRed : appWhite;
                return GestureDetector(
                  onTap: () => _onDateSelected(date),
                  child: Container(
                    width: 50,
                    height: 30,
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? primaryColor : dayColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('EEE').format(date).toUpperCase(),
                          style: s20BoldWhite87.copyWith(
                              fontSize: 14, color: textColor),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: s20BoldWhite87.copyWith(
                              fontSize: 14, color: textColor),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
