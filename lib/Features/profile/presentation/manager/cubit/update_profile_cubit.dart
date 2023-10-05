
import 'dart:convert';

import 'package:eraa_books_store/Features/login/data/login_data_model.dart';
import 'package:eraa_books_store/Features/profile/presentation/manager/cubit/update_profile_states.dart';
import 'package:eraa_books_store/core/utils/endpoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';

import '../../../../login/presentation/manger/cubit/login_cubit.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState>{
  UpdateProfileCubit():super(UpdateProfileCubitInitial());

  static UpdateProfileCubit get(context)=>BlocProvider.of(context);

  Future<void> updateProfile(
      XFile? pickedFile,
      String name,
      String phone,
      String address,
      ) async {
      emit(UpdateProfileCubitLoading());
      try{
        final url = Uri.parse(EndPoints.baseUrl+EndPoints.updateProfileEndpoint); // Replace with your server's URL
        final request = http.MultipartRequest('POST', url);
        if(pickedFile!=null){
          // Attach the image as a MultipartFile
          request.files.add(
            await http.MultipartFile.fromPath(
              'image', // Field name for the image on the server
              pickedFile.path, // Path to the selected image file
            ),
          );
        }

        // Add other parameters using the fields property
        request.fields['name'] = name; // Replace with your parameter names and values
        request.fields['address'] = address;
        request.fields['phone'] = phone;
        request.headers['Authorization'] = 'Bearer ${loginDataModel.data?.token}';

        // Send the request
        final response = await request.send();
        final parsedResponse=jsonDecode(await response.stream.bytesToString());
        User user=User.fromJson(parsedResponse['data']);
        loginDataModel.data?.user=user;
        if (response.statusCode >= 200&&response.statusCode<300) {
          print('Profile Data uploaded successfully');
          emit(UpdateProfileCubitSuccess());
        } else {
          print('Failed to update profile');
          throw Exception("${response.reasonPhrase} + ${parsedResponse['errors'].toString()}");
        }
      }catch(e){
        emit(UpdateProfileCubitFailure(errmsg: {
          'error':e.toString(),
        }));
      }


  }

}