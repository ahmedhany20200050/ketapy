

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/checkout_cubit.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/checkout_states.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/governments_cubit.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../data/checkout_model.dart';

class PlaceOrderCubit extends Cubit<CheckoutCubitState> {
  PlaceOrderCubit() : super(CheckoutCubitInitial());

  static PlaceOrderCubit get(context)=>BlocProvider.of(context);

  Future placeOrder(BuildContext context) async {
    try {
      var data = await Api().post(
        body: {
          'name':loginDataModel.data?.user?.name.toString(),
          'governorate_id':GovCubit.get(context).currentDropDownValue.toString(),
          'phone':loginDataModel.data?.user?.phone.toString(),
          'address':loginDataModel.data?.user?.address.toString(),
          'email':loginDataModel.data?.user?.email.toString(),
        },
        url: EndPoints.baseUrl + EndPoints.placeOrderEndpoint,
        token: loginDataModel.data?.token,
      );

      int statusCode=int.parse(data['status'].toString());

      if(!(statusCode>=200&&statusCode<300)){
        throw Exception("error");
      }
      Navigator.pop(context);
      Navigator.pop(context);
      AnimatedSnackBar.material(
          "order success",
        duration: const Duration(seconds: 5),
        type: AnimatedSnackBarType.success,).show(context);
    } on Exception catch (e) {
      AnimatedSnackBar.material(
        "something went wrong",
        duration: const Duration(seconds: 5),
        type: AnimatedSnackBarType.error,).show(context);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


}