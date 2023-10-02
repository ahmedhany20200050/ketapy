import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:eraa_books_store/core/widgets/custom_button.dart';
import 'package:eraa_books_store/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25 + 90,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(600, 200)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: AppColors.primaryColor,
                        child: CircleAvatar(
                          radius: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                                "${loginDataModel.data?.user?.image}",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEnabled = true;
                                print("hello nigga");
                              });
                            },
                            child: Ink(
                              child: Icon(
                                Icons.edit,
                                color: AppColors.textColorYellow,
                                size: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 160,
                          ),
                          InkWell(
                            child: Ink(
                              child: Icon(
                                Icons.logout_outlined,
                                color: AppColors.textColorYellow,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(width: 2, color: AppColors.textColorYellow),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    initialValue: loginDataModel.data?.user?.name,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                    initialValue: loginDataModel.data?.user?.email,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    initialValue: loginDataModel.data?.user?.phone,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                    ),
                    initialValue: loginDataModel.data?.user?.city,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    prefixIcon: Icon(
                      Icons.location_on,
                    ),
                    initialValue: loginDataModel.data?.user?.address,
                    isEnabled: isEnabled,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  isEnabled
                      ? CustomButton(
                          buttonText: "Update",
                          onPressed: () {
                            setState(() {
                              isEnabled = false;
                            });
                          },
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
