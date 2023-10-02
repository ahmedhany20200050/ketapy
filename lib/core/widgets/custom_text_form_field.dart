import 'package:flutter/material.dart';

import '../app_colors.dart';
import '../app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.style = AppStyles.descriptionTextStyle,
    this.borderSidecolor = AppColors.textFieldColor,
    this.hintText = "",
    this.isObsecureText = false,
    this.prefixIcon,
    this.initialValue,
    this.prefixIconColor = AppColors.textColorGreen, this.isEnabled=true, this.onChanged,
  });
  final TextEditingController? controller;
  final TextStyle style;
  final Color borderSidecolor;
  final String hintText;
  final bool isObsecureText;
  final Icon? prefixIcon;
  final Color? prefixIconColor;
  final String? initialValue;
  final bool isEnabled;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      enabled: isEnabled,
      initialValue: initialValue,
      obscureText: isObsecureText,
      controller: controller,
      style: style,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: prefixIconColor,
        contentPadding: const EdgeInsets.all(16),
        hintText: hintText,
        hintStyle: AppStyles.descriptionTextStyle,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: borderSidecolor)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderSidecolor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: borderSidecolor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
