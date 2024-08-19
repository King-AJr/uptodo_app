import 'package:flutter/material.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

void showAddImageModal(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: bottomNavBar,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        return SizedBox(
          height: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Change account Image',
                      style: s16RegWhite87.copyWith(fontFamily: "latoBold"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(height: 0.5, color: greyBorder),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Take Picture', style: s16RegWhite87),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Import from gallery', style: s16RegWhite87),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Import from Google Drive', style: s16RegWhite87),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      });
}
