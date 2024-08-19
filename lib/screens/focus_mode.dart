import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:uptodo/constants/colors.dart';
import 'package:uptodo/constants/text_styles.dart';
import 'package:uptodo/models/focus_model.dart';
import 'package:uptodo/resusable_widgets/focus_app_card.dart';
import 'package:uptodo/utils/dummy_data.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  int selectedIndex = -1;
  bool isFocusing = false;
  Timer? _timer;
  int _seconds = 0;

  String get _formattedTime {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startOrStopFocus() {
    if (isFocusing) {
      _stopFocus();
    } else {
      _startFocus();
    }
  }

  void _startFocus() {
    setState(() {
      isFocusing = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _seconds++;
        });
      });
    });
  }

  void _stopFocus() {
    setState(() {
      isFocusing = false;
      _timer?.cancel();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
                        color: const Color(0xff555555),
                        width: 10.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _formattedTime,
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
                  onPressed: _startOrStopFocus,
                  child: Text(
                    isFocusing ? 'Stop Focusing' : 'Start Focusing',
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Applications',
                      style:
                          s20BoldWhite87.copyWith(fontFamily: 'latoregular')),
                ],
              ),
              const SizedBox(height: 20),
              const FocusAppCard(
                appName: 'Instagram',
                hours: '4h',
                imageUrl: 'ig_logo.png',
              ),
              const FocusAppCard(
                appName: 'Twitter',
                hours: '3h',
                imageUrl: 'twitter_logo.png',
              ),
              const FocusAppCard(
                appName: 'Facebook',
                hours: '1h',
                imageUrl: 'fb_logo.png',
              ),
              const FocusAppCard(
                appName: 'Telegram',
                hours: '30m',
                imageUrl: 'tg_logo.png',
              ),
              const FocusAppCard(
                appName: 'Gmail',
                hours: '45m',
                imageUrl: 'gmail.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
