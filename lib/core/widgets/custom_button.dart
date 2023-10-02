
import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonText, this.onPressed });

  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: AppColors.textFieldColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )),
      onPressed:onPressed,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: AppStyles.buttonTextStyle,
      ),
    );
  }
}
