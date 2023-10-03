
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:eraa_books_store/Features/login/presentation/views/login_screen.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/app_colors.dart';
import '../../../../Splash/presentation/views/splash_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "${loginDataModel.data?.user?.image}",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text("${loginDataModel.data?.user?.name}",style: AppStyles.normalGreenTextStyle,),
              Text("${loginDataModel.data?.user?.email}",style: AppStyles.normalGreenTextStyle,),
              SizedBox(
                height: 16,
              ),
              InkWell(
                  onTap: (){},
                  child:Ink(
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 22,
                          color: Colors.teal,
                        ),
                        Text("Order History",style: AppStyles.titleTextStyle.copyWith(
                          fontSize: 22
                        ),),
                      ],
                    ),
                  )
              ),
              Divider(color: Colors.teal,thickness: 2,),
              InkWell(
                  onTap: (){},
                  child:Ink(
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 22,
                          color: Colors.teal,
                        ),
                        Text("Edit Profile",style: AppStyles.titleTextStyle.copyWith(
                          fontSize: 22
                        ),),
                      ],
                    ),
                  )
              ),
              Divider(color: Colors.teal,thickness: 2,),
              InkWell(
                  onTap: (){},
                  child:Ink(
                    child: Row(
                      children: [
                        Icon(
                          Icons.change_circle_outlined,
                          size: 22,
                          color: Colors.teal,
                        ),
                        Text("Change Password",style: AppStyles.titleTextStyle.copyWith(
                          fontSize: 22
                        ),),
                      ],
                    ),
                  )
              ),
              Divider(color: Colors.teal,thickness: 2,),
              InkWell(
                onTap: ()async{
                  isLoggedIn=false;
                  var storage= const FlutterSecureStorage();
                  storage.delete(key: "loginData");
                  var storage2= await SharedPreferences.getInstance();
                  storage2.remove("keepMeLoggedIn");
                  Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                },
                child:Ink(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        size: 22,
                        color: Colors.teal,
                      ),
                      Text("Logout",style: AppStyles.titleTextStyle.copyWith(
                        fontSize: 22
                      ),),
                    ],
                  ),
                )
              ),
              Divider(color: Colors.teal,thickness: 2,),
            ],
          ),
        ),
      ),
    );
  }
}
