import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

Future<void> requestCameraPermission() async {
  PermissionStatus status = await Permission.camera.status;

  if (status.isGranted) {
    await pickImageFromCamera();
  } else if (status.isDenied || status.isRestricted) {
    PermissionStatus newStatus = await Permission.camera.request();

    if (newStatus.isGranted) {
      await pickImageFromCamera();
    } else if (newStatus.isPermanentlyDenied) {
      await openAppSettings();
      // Wait for the user to return from settings, then recheck
      Future.delayed(Duration(seconds: 2), () async {
        PermissionStatus updatedStatus = await Permission.camera.status;
        if (updatedStatus.isGranted) {
          await pickImageFromCamera();
        } else {
          print('Permission still denied.');
        }
      });
    }
  }
}


Future<void> pickImageFromCamera() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    print('Image path: ${image.path}');
  } else {
    print('No image selected.');
  }
}

Future<void> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    print('Image path: ${image.path}');
  } else {
    print('No image selected.');
  }
}

void showAddImageModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: bottomNavBar,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.35,
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
              child: TextButton(
                onPressed: () async {
                  await requestCameraPermission();
                },
                child: Text('Take Picture', style: s16RegWhite87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  await pickImageFromGallery();
                },
                child: Text('Import from gallery', style: s16RegWhite87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Import from Google Drive', style: s16RegWhite87),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}
