import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/resusable_widgets/ios_dnd_dialog.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/focus_service.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/view-models/focus_vm.dart';
import 'package:uptodo/views/focus_overview.dart';

class FocusModeScreen extends StatefulWidget {
  const FocusModeScreen({super.key});

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<FocusModeVm>(context, listen: false);
      vm.fetchFocusData(context, 'thisWeek');
    });
  }

  bool isFocusing = false;
  Duration focusDuration = Duration.zero;
  Timer? timer;
  DateTime? startTime;

  // Getter for formatted time
  String get _formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(focusDuration.inHours);
    final minutes = twoDigits(focusDuration.inMinutes.remainder(60));
    final seconds = twoDigits(focusDuration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  // Start/stop focus mode logic
  void _startOrStopFocus() async {
    final focusModeVm = Provider.of<FocusModeVm>(context, listen: false);
    if (isFocusing) {
      // Stop focus mode
      setState(() {
        isFocusing = false;
        timer?.cancel();
        final endTime = DateTime.now();

        focusModeVm.sendFocusData(context, startTime!, endTime);
      });

      if (Platform.isAndroid) {
        await FlutterDnd.setInterruptionFilter(
            FlutterDnd.INTERRUPTION_FILTER_ALL);
      }
    } else {
      if (Platform.isAndroid) {
        bool? hasPermission =
            await FlutterDnd.isNotificationPolicyAccessGranted;
        if (hasPermission != null && !hasPermission) {
          FlutterDnd.gotoPolicySettings();
          return;
        }

        // Set Android to "Do Not Disturb" mode
        await FlutterDnd.setInterruptionFilter(
            FlutterDnd.INTERRUPTION_FILTER_NONE);
      }

      setState(() {
        isFocusing = true;
        startTime = DateTime.now();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            focusDuration += const Duration(seconds: 1);
          });
        });
      });

      if (Platform.isAndroid) {
        showFocusModeNotification(_formattedTime);
      } else if (Platform.isIOS) {
        showIOSDNDInstructions(context);
      }
    }
  }

  Widget buildFocusTimer() {
    return Column(
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
                  style: const TextStyle(fontSize: 42, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (Platform.isAndroid)
          const Text(
            'While your focus mode is on, all of your notifications will be off',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 20),
        SizedBox(
          width: 177,
          child: ElevatedButton(
            onPressed: _startOrStopFocus,
            child: Text(isFocusing ? 'Stop Focusing' : 'Start Focusing'),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<FocusModeVm>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Focus Mode',
          style: s20BoldWhite87.copyWith(
            fontFamily: 'latoRegular',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [buildFocusTimer(), buildFocusOverview(context, vm)],
            ),
          ),
        ),
      ),
    );
  }
}
