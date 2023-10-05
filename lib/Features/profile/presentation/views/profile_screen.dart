import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:eraa_books_store/Features/profile/presentation/manager/cubit/update_profile_cubit.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:eraa_books_store/core/widgets/custom_button.dart';
import 'package:eraa_books_store/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Splash/presentation/views/splash_screen.dart';
import '../../../login/presentation/views/login_screen.dart';
import '../manager/cubit/update_profile_states.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEnabled = false;
  XFile? image;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if(state is UpdateProfileCubitSuccess){
            setState(() {
              isEnabled = false;
              loginDataModel;
            });
            AnimatedSnackBar.material(
              'Update Success',
              type: AnimatedSnackBarType.success,
              duration: const Duration(seconds: 4),
            ).show(context);
          }else if(state is UpdateProfileCubitFailure){
            AnimatedSnackBar.material(
              '${state.errmsg['error']}',
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 4),
            ).show(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height * 0.25) + 130,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(600, 200),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                              final picker = ImagePicker();
                              image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if(image!=null) {
                                await UpdateProfileCubit.get(context).updateProfile(
                                  image, loginDataModel.data?.user?.name??"", loginDataModel.data?.user?.phone??"", loginDataModel.data?.user?.address??"");
                              }
                          },
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                "${loginDataModel.data?.user?.image}",
                              ),
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
                                });
                              },
                              child: Ink(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.edit,
                                  color: AppColors.textColorYellow,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 160,
                            ),
                            InkWell(
                              onTap: () async{
                                isLoggedIn=false;
                                var storage= const FlutterSecureStorage();
                                storage.delete(key: "loginData");
                                var storage2= await SharedPreferences.getInstance();
                                storage2.remove("keepMeLoggedIn");
                                Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                              },
                              child: Ink(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
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
                  border:
                      Border.all(width: 2, color: AppColors.textColorYellow),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: name
                        ..text = (loginDataModel.data?.user?.name ?? ""),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      isEnabled: isEnabled,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // CustomTextFormField(
                    //   prefixIcon: Icon(
                    //     Icons.email,
                    //   ),
                    //   initialValue: loginDataModel.data?.user?.email,
                    //   isEnabled: isEnabled,
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    CustomTextFormField(
                      controller: phone
                        ..text = loginDataModel.data?.user?.phone ?? "",
                      prefixIcon: const Icon(
                        Icons.phone,
                      ),
                      isEnabled: isEnabled,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: address
                        ..text = loginDataModel.data?.user?.address ?? "",
                      prefixIcon: const Icon(
                        Icons.location_on,
                      ),
                      isEnabled: isEnabled,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    isEnabled
                        ? CustomButton(
                            buttonText: "Update",
                            onPressed: () async {
                              await UpdateProfileCubit.get(context)
                                  .updateProfile(image, name.text, phone.text,
                                      address.text);
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
