import 'package:bloc/bloc.dart';
import 'package:eraa_books_store/Features/OnBoarding/presentation/views/first_on_boarding_screen.dart';
import 'package:eraa_books_store/Features/Splash/presentation/views/splash_screen.dart';
import 'package:eraa_books_store/Features/all_books/presentation/manager/cubit/books_cubit.dart';
import 'package:eraa_books_store/Features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:eraa_books_store/Features/cart/presentation/views/cart_screen.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/checkout_cubit.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/governments_cubit.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/place_order_cubit.dart';
import 'package:eraa_books_store/Features/checkout/presentation/views/checkout_screen.dart';
import 'package:eraa_books_store/Features/favourites/presentation/manager/cubit/favourites_cubit.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/best_seller_cubit.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/categories_cubit.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/new_arrivals_cubit.dart';
import 'package:eraa_books_store/Features/home/presentation/views/home_screen.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:eraa_books_store/Features/profile/presentation/manager/cubit/update_profile_cubit.dart';
import 'package:eraa_books_store/Features/register/presentation/manger/cubit/register_cubit_state.dart';
import 'package:eraa_books_store/Features/register/presentation/views/register_screen.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/OnBoarding/presentation/views/second_on_boarding_screen.dart';
import 'Features/home/presentation/manager/slider_cubit.dart';
import 'Features/login/presentation/views/login_screen.dart';
import 'Features/register/presentation/manger/cubit/register_cubit.dart';
import 'core/helpers/observer.dart';

void main() {
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (context) =>  LoginCubit(),),
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit(),),
        BlocProvider<SliderCubit>(create: (context) => SliderCubit(),),
        BlocProvider<BestSellerCubit>(create: (context) => BestSellerCubit(),),
        BlocProvider<NewArrivalsCubit>(create: (context) => NewArrivalsCubit(),),
        BlocProvider<CategoriesCubit>(create: (context) => CategoriesCubit(),),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit(),),
        BlocProvider<FavouritesCubit>(create: (context) => FavouritesCubit(),),
        BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit(),),
        BlocProvider<CartCubit>(create: (context) => CartCubit(),),
        BlocProvider<CheckoutCubit>(create: (context) => CheckoutCubit(),),
        BlocProvider<GovCubit>(create: (context) => GovCubit(),),
        BlocProvider<PlaceOrderCubit>(create: (context) => PlaceOrderCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.primaryColor,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.textColorGreen,),
          useMaterial3: true,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          SplashScreen.id:(context) => const SplashScreen(),
          FirstOnBoardingScreen.id:(context) => const FirstOnBoardingScreen(),
          SecondOnBoardingScreen.id:(context) => const SecondOnBoardingScreen(),
          HomeScreen.id:(context) =>  const HomeScreen(),
          CartScreen.id:(context) => const CartScreen(),
          CheckoutScreen.id:(context) => const CheckoutScreen(),
        },
      ),
    );
  }
}
