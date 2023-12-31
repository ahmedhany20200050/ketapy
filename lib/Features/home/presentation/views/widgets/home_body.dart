

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/cart/presentation/views/cart_screen.dart';
import 'package:eraa_books_store/core/utils/not_logged_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_styles.dart';
import '../../../../Splash/presentation/views/splash_screen.dart';
import 'best_seller_list.dart';
import 'categories_list.dart';
import 'custom_slider.dart';
import 'new_arrivals_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if(isLoggedIn) {
                        _scaffoldKey.currentState?.openDrawer();
                      }else{
                        NotLoggedInDialog.showNotLoggedDialog(context);
                      }
                    } ,
                    child: Ink(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.menu,
                        color: AppColors.textColorGreen,
                        size: 32,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(isLoggedIn) {
                        Navigator.pushNamed(context, CartScreen.id);
                      }else{
                        NotLoggedInDialog.showNotLoggedDialog(context);
                      }

                    },
                    child: Ink(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.shopping_cart,
                        color: AppColors.textColorGreen,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomSlider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Categories",
                  style: AppStyles.normalYellowTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CategoriesList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Best Seller",
                  style: AppStyles.normalYellowTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const BestSellerList(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "New Arrivals",
                  style: AppStyles.normalYellowTextStyle.copyWith(fontSize: 18),
                ),
              ),
              const NewArrivalsList(),
            ],
          ),
        ),
      ),
    );
  }
}
