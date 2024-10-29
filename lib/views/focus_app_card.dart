import 'package:flutter/material.dart';
import 'package:uptodo/resusable_widgets/focus_app_card.dart';

Widget buildAppUsageSection(BuildContext context) {
  return const Column(
    children:  [
      FocusAppCard(appName: 'Instagram', hours: '4h', imageUrl: 'ig_logo.png'),
      FocusAppCard(appName: 'Twitter', hours: '3h', imageUrl: 'twitter_logo.png'),
      FocusAppCard(appName: 'Facebook', hours: '1h', imageUrl: 'fb_logo.png'),
      FocusAppCard(appName: 'Telegram', hours: '30m', imageUrl: 'tg_logo.png'),
      FocusAppCard(appName: 'Gmail', hours: '45m', imageUrl: 'gmail.png'),
    ],
  );
}
