import 'package:eraa_books_store/Features/home/data/models/bestSellerDataModel.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/api.dart';
import '../../../../core/utils/endpoints.dart';

class BestSellerCubit extends Cubit<ListCubitState> {
  BestSellerCubit() : super(ListCubitInitial());

  static BestSellerCubit get(context)=>BlocProvider.of(context);
  Map<String,dynamic> finalData={};
  late BestSellerModel model;
  Future getSliders() async {
    emit(ListCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.bestSellerEndpoint,
        token: null,
      );
      finalData=data['data'];
      model=BestSellerModel.fromJson(data);
      emit(ListCubitSuccess());
    } on Exception catch (e) {
      emit(
        ListCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }
}
