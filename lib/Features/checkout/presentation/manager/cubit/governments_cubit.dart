

import 'package:eraa_books_store/Features/checkout/data/GovsModel.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/governments_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';

class GovCubit extends Cubit<GovCubitState>{
  GovCubit() : super(GovCubitInitial());

  static GovCubit get(context)=>BlocProvider.of(context);

  late GovsModel govsModel;
  int currentDropDownValue=0;

  Future<void> getGovs()async {

    emit(GovCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.governmentsEndpoint,
      );
      if (kDebugMode) {
        print("cart data:");
        print(data);
      }
      govsModel=GovsModel.fromJson(data);
      currentDropDownValue=govsModel.data?.first.id??0;
      emit(GovCubitSuccess());
    } on Exception catch (e) {
      emit(
        GovCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
  void updateDropDown(int value){
    currentDropDownValue=value;
    emit(GovCubitSuccess());
  }

}