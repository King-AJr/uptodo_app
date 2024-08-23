import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uptodo/utils/text_styles.dart';
import 'package:uptodo/views/intro.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off,
                  size: 100,
                  color: Color.fromARGB(255, 92, 90, 90),
                ),
                SizedBox(height: 20),
                Text("Network error", style: s20BoldWhite87),
                Text(
                  "A network error occured, please check your network connectivity and try again",
                  textAlign: TextAlign.center,
                  style: s16RegWhite40,
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(IntroScreen());
                    },
                    child: Text(
                      "Retry",
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
