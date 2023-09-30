// ignore_for_file: body_might_complete_normally_nullable
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_colors.dart';
import '../../../OnBoarding/presentation/views/first_on_boarding_screen.dart';
import '../../../login/presentation/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.of(context).pushReplacementNamed(FirstOnBoardingScreen.id);
      // var storage = const FlutterSecureStorage();
      // String? token = await storage.read(key: "token");
      // final per = await SharedPreferences.getInstance();
      //
      // bool? b = per.getBool("firstTime");
      // if (b == null) {
      //   Navigator.of(context).pushReplacementNamed(FirstOnBoardingScreen.id);
      //   await per.setBool("firstTime", true);
      // } else {
      //   if (token == null) {
      //     Navigator.of(context).pushReplacementNamed(LoginScreen.id);
      //   }
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.book,
                      size: 32,
                      color: AppColors.textColorGreen,
                    ),
                    Text(
                      "كتابي",
                      style: AppStyles.titleTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                const AnimatedLoadinText(),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AnimatedLoadinText extends StatelessWidget {
  const AnimatedLoadinText({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText('loading...',
            textStyle: AppStyles.titleTextStyle.copyWith(
              fontSize: 16,
            ),
        ),
      ],
      repeatForever: true,
      onTap: () {
        print("Tap Event");
      },
    );
  }
}

