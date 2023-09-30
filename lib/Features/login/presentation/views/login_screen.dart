// ignore_for_file: body_might_complete_normally_nullable
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../register/presentation/views/register_screen.dart';
import '../manger/cubit/login_cubit.dart';
import '../manger/cubit/login_cubit_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool keepMeLoggedIn = true;

  String errors(state, String error) {
    if (state is LoginCubitFailure) {
      if(state.err.containsKey('errors')){
        if (state.err['errors'].containsKey(error)) {
          return state.err['errors'][error][0].toString();
        }
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginCubitState>(
      listener: (context, state) {
        if (state is LoginCubitSuccess) {
          //todo: navigate
          AnimatedSnackBar.material(
            'Login Success',
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 4),
          ).show(context);
        }
        if (state is LoginCubitFailure) {
          if (state.err.containsKey('message')) {
            // print(state.err['error'].toString());
            AnimatedSnackBar.material(
              state.err['message'].toString().replaceAll("Exception:", " "),
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 4),
            ).show(context);
          }
        }
      },
      builder: (context, state) {
        var loginCubit = BlocProvider.of<LoginCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
            body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 55),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "مرحبا",
                        textAlign: TextAlign.center,
                        style: AppStyles.titleTextStyle,
                      ),
                      const SizedBox(
                        height: 24,
                      ),

                      TextFormField(
                        controller: email,
                        style: AppStyles.descriptionTextStyle,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          hintText: "Email",
                          hintStyle: AppStyles.descriptionTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.textFieldColor)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: AppColors.textFieldColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      state is LoginCubitFailure?
                      Text(errors(state,"email"),style: AppStyles.textFieldErrorStyle,):Container(),
                      const SizedBox(
                        height: 24,
                      ),

                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          hintText: "Password",
                          hintStyle: AppStyles.descriptionTextStyle,
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: AppColors.textFieldColor)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: AppColors.textFieldColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      state is LoginCubitFailure?
                          Text(errors(state,'password'),style: AppStyles.textFieldErrorStyle,):Container(),
                      SizedBox(
                        height: 24,
                      ),

                      Row(
                        children: [
                          Checkbox(
                              activeColor: AppColors.textColorGreen,
                              value: keepMeLoggedIn,
                              onChanged: (value) {
                                setState(() {
                                  keepMeLoggedIn = !keepMeLoggedIn;
                                });
                              }),
                           Text("Keep Me Logged In",style: AppStyles.descriptionTextStyle,),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(RegisterScreen.id);
                            },
                             child: Text(" سجل هنا",style: AppStyles.titleTextStyle.copyWith(
                               fontSize: 16
                             ),),
                          ),
                          Text("ليس لديك حساب؟",style: AppStyles.titleTextStyle.copyWith(
                              fontSize: 12
                          ),),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      state is LoginCubitLoading
                          ? const Center(
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.textColorGreen,
                                  )),
                            )
                          : SizedBox(
                              height: 48,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: AppColors.textFieldColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    )),
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    await loginCubit.login(
                                      email: email.text,
                                      password: password.text,
                                      keepMeLoggedIn: keepMeLoggedIn,
                                    );
                                  }
                                },
                                child: Text(
                                  "تسجيل دخول",
                                  textAlign: TextAlign.center,
                                   style: AppStyles.buttonTextStyle,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
