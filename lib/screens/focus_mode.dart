import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/models/focus_model.dart';
import 'package:uptodo/utils/dummy_data.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Focus Mode',
          style: s20BoldWhite87.copyWith(
            fontFamily: 'latoRegular',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 213,
                    width: 213,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[800]!, // Border color
                        width: 10.0, // Border width
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '00:00',
                        style:
                            s32BoldWhite.copyWith(fontSize: 42, color: white87),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                'While your focus mode is on, all of your notifications will be off',
                style: s16RegWhite87.copyWith(
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 177,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Start Focusing',
                    style: s16RegWhite87.copyWith(color: appWhite),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
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
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "This week",
                            style: s16RegWhite87.copyWith(fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_drop_down_outlined,
                              color: white87, size: 16),
                        ],
                      ),
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
                  primaryYAxis: const NumericAxis(
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  plotAreaBorderWidth: 0,
                  series: <CartesianSeries>[
                    ColumnSeries<FocusMode, String>(
                      dataSource: DummyData.focusData,
                      xValueMapper: (FocusMode data, _) => data.day,
                      yValueMapper: (FocusMode data, _) => data.hours,
                      color: barColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
