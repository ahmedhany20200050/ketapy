

import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/checkout_states.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../data/checkout_model.dart';

class CheckoutCubit extends Cubit<CheckoutCubitState> {
  CheckoutCubit() : super(CheckoutCubitInitial());

  static CheckoutCubit get(context)=>BlocProvider.of(context);

  CheckoutModel? checkoutModel;
  List<CartItems>cartItems=[];

  Future getCheckout() async {
    if (kDebugMode) {
      print("\n\nin cart cubit\n\n");
    }

    emit(CheckoutCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.cartEndpoint,
        token: loginDataModel.data?.token,
      );
      if (kDebugMode) {
        print("cart data:");
        print(data);
      }
      checkoutModel=CheckoutModel.fromJson(data);
      if(!((checkoutModel!.status??0)>=200&&(checkoutModel!.status??0)<300)){
        throw Exception(checkoutModel?.message);
      }
      cartItems= checkoutModel?.data?.cartItems??[];
      emit(CheckoutCubitSuccess());
    } on Exception catch (e) {
      emit(
        CheckoutCubitFailure(
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


}