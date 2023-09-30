// ignore_for_file: missing_required_param
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import 'register_cubit_state.dart';
import 'package:http/http.dart' as http;


class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit() : super(RegisterCubitInitial());
  late String token;
  Future register({required String name,required String email,required String password, required String confirmPassword}) async {
    emit(RegisterCubitLoading());
    try {
      var response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.registerEndpoint),
        body: {
          'name':name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );
      var data =jsonDecode(response.body);
      if(response.statusCode>=200&&response.statusCode<300){
        emit(RegisterCubitSuccess());
        token = data['data']['token'];
        var storage = const FlutterSecureStorage();
        await storage.write(key: "token", value: token);
         print(token);
      }else if(response.statusCode==422){
        emit(RegisterCubitFailure(errmsg: data));
      }else{
        throw Exception(response.reasonPhrase.toString());
      }
      
    } on Exception catch (e) {
      emit(RegisterCubitFailure(errmsg: {
        'error': e.toString(),
      }));
    }
  }
}
