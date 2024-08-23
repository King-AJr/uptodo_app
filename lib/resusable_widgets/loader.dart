
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uptodo/utils/colors.dart';
import 'package:uptodo/utils/text_styles.dart';

class AnimationLoaderWidget extends StatelessWidget {
  final String text;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const AnimationLoaderWidget({
    Key? key,
    required this.text,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color:  primaryColor, 
            size: MediaQuery.of(context).size.width *
                0.6, // Customize spinner size
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (showAction)
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor: greyBorder,
                ),
                child: Text(
                  actionText!,
                  style: s14MedWhite87
                ),
              ),
            ),
        ],
      ),
    );
  }
}
