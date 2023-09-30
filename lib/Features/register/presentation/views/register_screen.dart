// ignore_for_file: body_might_complete_normally_nullable
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../login/presentation/views/login_screen.dart';
import '../manger/cubit/register_cubit.dart';
import '../manger/cubit/register_cubit_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isMale = true;


  String errors(state,String error){
    if(state is RegisterCubitFailure){
      print(state.errmsg.toString());
      print("hello nigga"+error);
      if(state.errmsg.containsKey('errors')){
        if(state.errmsg['errors'].containsKey(error)){
          // print(state.err['email'][0].toString());
          return state.errmsg['errors'][error][0].toString();
        }
      }

    }
    return'';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterCubitState>(
      listener: (context, state) {
        if (state is RegisterCubitSuccess) {
          //todo: navigate
          // Navigator.of(context).pushReplacementNamed(HomeScreen.id);
          AnimatedSnackBar.material(
            'Register Success',
            type: AnimatedSnackBarType.success,
            duration: const Duration(seconds: 4),
          ).show(context);
        }

        if(state is RegisterCubitFailure){
          if(state.errmsg.containsKey('error')){
            // print(state.err['error'].toString());
            AnimatedSnackBar.material(
              state.errmsg['error'].toString().replaceAll("Exception:", " "),
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 4),
            ).show(context);
          }

        }
      },
      builder: (context, state) {
        var registerCubit = BlocProvider.of<RegisterCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
            body: state is RegisterCubitLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                    : SafeArea(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24 ,
                                vertical: 55 ),
                            child: Form(
                              key: formkey,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      "Let’s get started!",
                                      textAlign: TextAlign.center,
                                      style: AppStyles.titleTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "create an account and start booking now.",
                                            style: AppStyles.descriptionTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextFormField(
                                      controller: name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'name must not be empty.';
                                        }
                                      },
                                      style: AppStyles.descriptionTextStyle,
                                      decoration: InputDecoration(
                                        hintStyle: AppStyles.descriptionTextStyle,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        hintText: "Name",
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.textFieldColor)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: const BorderSide(),
                                        ),
                                      ),
                                    ),
                                    state is RegisterCubitFailure?
                                    Text(errors(state,"name"),style: AppStyles.textFieldErrorStyle,):Container(),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextFormField(
                                      style: AppStyles.descriptionTextStyle,
                                      controller: email,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Email must not be empty.';
                                        } else if (!value.contains('@')) {
                                          return 'Email must contain @ .';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: AppStyles.descriptionTextStyle,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        hintText: "Email",
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.textFieldColor
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    state is RegisterCubitFailure?
                                    Text(errors(state,"email"),style: AppStyles.textFieldErrorStyle,):Container(),

                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextFormField(

                                      style: AppStyles.descriptionTextStyle,
                                      obscureText: true,
                                      controller: password,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password must not be empty.';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: AppStyles.descriptionTextStyle,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        hintText: "Password",
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.textFieldColor
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    TextFormField(
                                      style: AppStyles.descriptionTextStyle,
                                      obscureText: true,
                                      controller: confirmPassword,
                                      validator: (value) {
                                        if (value != password.text) {
                                          return "password mismatch";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: AppStyles.descriptionTextStyle,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16),
                                        hintText: "Confirm Password",
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 2,
                                                color: AppColors.textFieldColor
                                            )
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: AppColors.textFieldColor,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [

                                        Text("Already have an account?",style: AppStyles.descriptionTextStyle.copyWith(
                                          color: AppColors.textColorGreen
                                        ),),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushReplacementNamed(LoginScreen.id);
                                          },
                                          child: Text("Login here",style: AppStyles.biggerDiscriptionStyle.copyWith(
                                            fontSize: 12,
                                            color: AppColors.textColorGreen,
                                          ),),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 48,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColors.textFieldColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            )),
                                        onPressed: () async {
                                          if (formkey.currentState!.validate()) {
                                            await registerCubit.register(
                                              name: name.text,
                                              email: email.text,
                                              password: password.text,
                                              confirmPassword: confirmPassword.text,
                                            );
                                          }
                                        },
                                        child: Text(
                                          "تسجيل",
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
