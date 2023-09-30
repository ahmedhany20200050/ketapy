// ignore_for_file: missing_required_param
import 'dart:convert';
import 'package:eraa_books_store/Features/login/data/login_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../../Splash/presentation/views/splash_screen.dart';
import 'login_cubit_state.dart';
import 'package:http/http.dart'as http;

late LoginDataModel loginDataModel;
class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitInitial());
  late String token;
  var loginData;

  Future login({required String email, required String password,required bool keepMeLoggedIn}) async {
    emit(LoginCubitLoading());
    try {
      http.Response response;
      response= await http.post(
        Uri.parse(EndPoints.baseUrl+EndPoints.loginEndpoint),
        body: {
          'email':email,
          'password':password,
        },
      );
      var data = jsonDecode(response.body);
      loginData=data['data'];
      // print(response.statusCode);
      // print(response.body);
      if(response.statusCode>=200&&response.statusCode<300){
        emit(LoginCubitSuccess());
        isLoggedIn=true;
        loginDataModel=LoginDataModel.fromJson(data);
        token = data['data']['token'];
        var storage = const FlutterSecureStorage();
        await storage.write(key: "loginData", value: response.body);
        if(keepMeLoggedIn){
          var storage2= await SharedPreferences.getInstance();
          await storage2.setBool("keepMeLoggedIn",keepMeLoggedIn);
        }
        if (kDebugMode) {
          print(token);
        }
      }else if(response.statusCode==422){
        print(data);
        emit(LoginCubitFailure( err: data));
      }else{
        throw Exception(response.reasonPhrase.toString());
      }

    } on Exception catch (e) {
      emit(LoginCubitFailure(err: {
        'error':e.toString(),
      }));
    }
  }

  Future goDirectlyToNextScreen()async{
    var storage=await SharedPreferences.getInstance();
    bool go= storage.getBool("keepMeLoggedIn")??false;
    if(go){
      emit(LoginCubitSuccess());
    }else{
      emit(LoginCubitInitial());
    }
  }
}
