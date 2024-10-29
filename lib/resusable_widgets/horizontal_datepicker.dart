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
  // ignore: library_private_types_in_public_api
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late DateTime selectedDate;
  late List<DateTime> days;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;

    _scrollController = ScrollController();

    _updateDays();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialDate();
    });
  }

  void _updateDays() {
    final lastDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);
    days = List.generate(
      lastDayOfMonth.day,
      (index) => DateTime(selectedDate.year, selectedDate.month, index + 1),
    );
  }

  void _scrollToInitialDate() {
    int initialIndex = days.indexWhere((date) =>
        date.day == selectedDate.day &&
        date.month == selectedDate.month &&
        date.year == selectedDate.year);

    if (initialIndex != -1) {
      double targetScrollOffset = initialIndex * 60.0;
      _scrollController.animateTo(
        targetScrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
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
  void dispose() {
    _scrollController.dispose(); // Always dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomNavBar,
      padding: const EdgeInsets.symmetric(vertical: 10),
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
              controller: _scrollController, // Assign ScrollController here
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
