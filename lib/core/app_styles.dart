// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppStyles {
  static TextStyle titleTextStyle =GoogleFonts.openSans()
      .copyWith(
  color: AppColors.textColorGreen,
  fontSize: 32,
  fontWeight: FontWeight.w900,
  );
  static TextStyle normalGreenTextStyle =GoogleFonts.openSans()
      .copyWith(
    color: AppColors.textColorGreen,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle normalYellowTextStyle =GoogleFonts.openSans()
      .copyWith(
    color: AppColors.textColorYellow,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle buttonTextStyle =GoogleFonts.openSans()
      .copyWith(
    color: AppColors.primaryColor,
    fontSize: 22,
    fontWeight: FontWeight.w900,
  );
  static const  TextStyle descriptionTextStyle=TextStyle(
    color: Color(0xFFFFEEC1),
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );
  static TextStyle textFieldErrorStyle=TextStyle(
    color: Colors.red,
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
  );

  static TextStyle biggerDiscriptionStyle=descriptionTextStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

}
