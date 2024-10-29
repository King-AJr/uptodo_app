import 'dart:io';
import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/resusable_widgets/focus_app_card.dart';

class FocusAppUsage extends StatefulWidget {
  const FocusAppUsage({Key? key}) : super(key: key);

  @override
  _FocusAppUsageState createState() => _FocusAppUsageState();
}

class _FocusAppUsageState extends State<FocusAppUsage> {
  Map<String, Duration> appUsageData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAppUsage();
  }

  Future<void> fetchAppUsage() async {
    Map<String, Duration> usageData = {};

    if (Platform.isAndroid) {
      try {
        List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
          DateTime.now().subtract(const Duration(days: 7)),
          DateTime.now(),
        );

        usageData = {
          'Instagram': _getAppUsageDuration(infoList, 'Instagram'),
          'Twitter': _getAppUsageDuration(infoList, 'Twitter'),
          'Facebook': _getAppUsageDuration(infoList, 'Facebook'),
          'Telegram': _getAppUsageDuration(infoList, 'Telegram'),
          'Gmail': _getAppUsageDuration(infoList, 'Gmail'),
        };
      } catch (e) {
        print('Error fetching app usage: $e');
      }
    }
    setState(() {
      appUsageData = usageData;
      isLoading = false;
    });
  }

  Duration _getAppUsageDuration(List<AppUsageInfo> infoList, String appName) {
    DateTime startOfDay = DateTime.now().toLocal();
    startOfDay = DateTime(startOfDay.year, startOfDay.month, startOfDay.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    List<AppUsageInfo> filteredList = infoList.where((info) {
      return info.appName == appName &&
          (info.startDate.isBefore(endOfDay) &&
              info.endDate.isAfter(startOfDay));
    }).toList();

    Duration totalUsage = Duration.zero;
    for (var info in filteredList) {
      DateTime usageStart =
          info.startDate.isBefore(startOfDay) ? startOfDay : info.startDate;
      DateTime usageEnd =
          info.endDate.isAfter(endOfDay) ? endOfDay : info.endDate;
      totalUsage += usageEnd.difference(usageStart);
    }

    return totalUsage;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> appIcons = {
      'Instagram': 'ig_logo.png',
      'Twitter': 'twitter_logo.png',
      'Facebook': 'fb_logo.png',
      'Telegram': 'tg_logo.png',
      'Gmail': 'gmail.png',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: appUsageData.entries.map((entry) {
                  String appName = entry.key;
                  Duration duration = entry.value;
                  String hours = _formatDuration(duration);

                  return FocusAppCard(
                    appName: appName,
                    hours: hours,
                    imageUrl: appIcons[appName] ?? 'default_icon.png',
                  );
                }).toList(),
              ),
      ],
    );
  }

  // Helper function to format the duration as hours and minutes
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}
