
import 'package:eraa_books_store/Features/login/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';

import '../app_styles.dart';

abstract class NotLoggedInDialog{
  static showNotLoggedDialog(context){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.teal.shade900,
          title: Text("You are not Logged!",style: AppStyles.normalYellowTextStyle,),
          content: const Text("do you want to login?",style: AppStyles.descriptionTextStyle,),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("no",style: AppStyles.descriptionTextStyle,)),
            TextButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            }, child: const Text("yes",style: AppStyles.descriptionTextStyle,)),
          ],
        );
      },
    );
  }
}