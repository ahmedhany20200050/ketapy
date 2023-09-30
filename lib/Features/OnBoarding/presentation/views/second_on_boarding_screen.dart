// ignore_for_file: body_might_complete_normally_nullable
import 'package:eraa_books_store/Features/OnBoarding/presentation/views/second_on_boarding_screen.dart';
import 'package:eraa_books_store/Features/login/presentation/views/login_screen.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';


class SecondOnBoardingScreen extends StatelessWidget {
  static const id = 'SecondOnBoardingScreen';

  const SecondOnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(LoginScreen.id);
        },
        child: Ink(
          child: const Icon(
            Icons.arrow_circle_right_outlined,
            color: AppColors.textColorGreen,
            size: 44,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding:const EdgeInsets.all(20),
                child: Image.asset("assets/images/Frame.png")),
            Text("أفضل الكتب في السوق",
              style: AppStyles.titleTextStyle,),
          ],
        ),
      ),
    );
  }
}
