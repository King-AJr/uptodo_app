import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:uptodo/resusable_widgets/alerts.dart';


void showIOSDNDInstructions(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Enable Do Not Disturb'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              'To minimize distractions, please enable Do Not Disturb manually.'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              try {
                AppSettings.openAppSettings(type: AppSettingsType.notification);
                Navigator.pop(context);
              } catch (e) {
                print('Error opening settings: $e');
                errorAlert(
                    'Could not open settings. Please navigate manually.');
              }
            },
            child: const Text('Open Settings'),
          ),
          const SizedBox(height: 16),
          const Text(
              'If the settings page does not open, please navigate manually to Settings > Do Not Disturb.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
