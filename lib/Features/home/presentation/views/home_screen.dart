import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/all_books/presentation/views/books_screen.dart';
import 'package:eraa_books_store/Features/favourites/presentation/views/favourites_screen.dart';
import 'package:eraa_books_store/Features/home/presentation/views/widgets/custom_drawer.dart';
import 'package:eraa_books_store/Features/home/presentation/views/widgets/home_body.dart';
import 'package:eraa_books_store/Features/profile/presentation/views/profile_screen.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:eraa_books_store/core/utils/not_logged_dialog.dart';
import 'package:flutter/material.dart';

import '../../../Splash/presentation/views/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeBody(scaffoldKey: _scaffoldKey),
      const BooksScreen(),
      const FavouoritesScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryColor,
      drawer: const CustomDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          if(value>=2){
            if(isLoggedIn) {
              index = value;
            }else{
              NotLoggedInDialog.showNotLoggedDialog(context);
            }
          }else{
            index = value;
          }
        }),
        enableFeedback: true,
        currentIndex: index,
        type: BottomNavigationBarType.shifting,
        backgroundColor: AppColors.textColorYellow,
        unselectedItemColor: AppColors.textColorGreen,
        selectedItemColor: AppColors.textColorYellow,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: AppColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "All Books",
              backgroundColor: AppColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
              backgroundColor: AppColors.primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "Profile",
              backgroundColor: AppColors.primaryColor),
        ],
      ),
      body: screens[index],

    );
  }
}




