import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uptodo/models/focus_model.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/helperFunctions.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/view-models/focus_vm.dart';
import 'package:uptodo/views/focus_app_usage.dart';

Widget buildFocusOverview(BuildContext context, FocusModeVm focusModeVm) {
  String selectedInterval = 'thisWeek';

  if (focusModeVm.focusResponse == null ||
      focusModeVm.focusResponse!.focus == null) {
    return Center(
      child: Text(
        'No data available',
        style: s16RegWhite87.copyWith(fontSize: 16),
      ),
    );
  }

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Overview',
            style: s16RegWhite87.copyWith(fontSize: 20),
          ),
          Container(
            height: 31,
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              color: white21,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: DropdownButton<String>(
              value: selectedInterval,
              dropdownColor: white21,
              icon: const Icon(Icons.arrow_drop_down_outlined,
                  color: white87, size: 16),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedInterval = newValue;
                  focusModeVm.fetchFocusData(context, selectedInterval);
                }
              },
              underline: Container(), 
              items: <String>['thisWeek', 'lastWeek']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value == 'thisWeek' ? 'This week' : 'Last week',
                    style: s16RegWhite87.copyWith(fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 250,
        child: SfCartesianChart(
          backgroundColor: bgColor,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              double timeInHours = details.value.toDouble();
              return ChartAxisLabel(
                  formatToHoursAndMinutes(timeInHours), const TextStyle());
            },
            majorGridLines: const MajorGridLines(width: 0),
          ),
          plotAreaBorderWidth: 0,
          series: <CartesianSeries>[
            ColumnSeries<FocusMode, String>(
              width: 0.7,
              dataSource: focusModeVm.focusResponse!.focus!,
              xValueMapper: (FocusMode data, _) => data.dow,
              yValueMapper: (FocusMode data, string) => data.hours,
              color: barColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
                builder: (data, point, series, pointIndex, seriesIndex) {
                  return Text(formatToHoursAndMinutes(data.hours),
                      style: s16RegWhite87.copyWith(fontSize: 10));
                },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      if (Platform.isAndroid)
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Applications',
                  style: s20BoldWhite87.copyWith(fontFamily: 'latoregular'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const FocusAppUsage()
          ],
        ),
    ],
  );
}
