import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/resusable_widgets/settings_row.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Settings',
          style: s16RegWhite87.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Settings',
                  style: s14MedWhite87.copyWith(
                    color: greyText,
                    fontFamily: 'latoRegular',
                  ),
                ),
              ],
            ),
            const SettingsRow(
              icon: Icon(
                Icons.brush_outlined,
                size: 24,
                color: appWhite,
              ),
              title: 'Change app color',
            ),
            const SettingsRow(
              icon: Icon(
                Icons.text_fields_outlined,
                size: 24,
                color: appWhite,
              ),
              title: 'Change app typography',
            ),
            const SettingsRow(
              icon: Icon(
                Icons.translate_outlined,
                size: 24,
                color: appWhite,
              ),
              title: 'Change app language',
            ),
            Row(
              children: [
                Text(
                  'Imports',
                  style: s14MedWhite87.copyWith(
                    color: greyText,
                    fontFamily: 'latoRegular',
                  ),
                ),
              ],
            ),
            const SettingsRow(
              icon: Icon(
                Icons.cloud_download_outlined,
                size: 24,
                color: appWhite,
              ),
              title: 'Import from Google calendar',
            ),
          ],
        ),
      ),
    );
  }
}
