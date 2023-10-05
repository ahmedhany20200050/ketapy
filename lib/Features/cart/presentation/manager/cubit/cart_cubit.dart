

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/cart/data/cart_model.dart';
import 'package:eraa_books_store/Features/favourites/data/favourite_model.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartCubitState> {
  CartCubit() : super(CartCubitInitial());

  static CartCubit get(context)=>BlocProvider.of(context);

  CartModel? cartModel;
  List<CartItems>cartItems=[];

  Future getCart() async {
    if (kDebugMode) {
      print("\n\nin cart cubit\n\n");
    }

    emit(CartCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.cartEndpoint,
        token: loginDataModel.data?.token,
      );
      if (kDebugMode) {
        print("cart data:");
        print(data);
      }
      cartModel=CartModel.fromJson(data);
      if(!((cartModel!.status??0)>=200&&(cartModel!.status??0)<300)){
        throw Exception(cartModel?.message);
      }
      cartItems= cartModel?.data?.cartItems??[];
      emit(CartCubitSuccess());
    } on Exception catch (e) {
      emit(
        CartCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
      print(e.toString());
    }
  }

  Future removeCart(int id) async {
    if (kDebugMode) {
      print("\n\nin remove cart items cubit\n\n");
    }
    // emit(CartCubitLoading());
    try {
      var data = await Api().post(
        url: EndPoints.baseUrl + EndPoints.removeCartEndpoint,
        token: loginDataModel.data?.token,
        body: {
          "cart_item_id":id.toString(),
      },
      );
      if (kDebugMode) {
        print("after remove cart item: ");
        print(data);
      }
      var removeModel=CartModel.fromJson(data);
      if(!((removeModel.status??0)>=200&&(removeModel.status??0)<300)){
        throw Exception(removeModel.message);
      }
      cartItems.removeWhere((element) => element.itemId==id);
      emit(CartCubitSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(
        CartCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

  Future addCart(int id,context) async {
    if (kDebugMode) {
      print("\n\nin add cart items cubit\n\n");
    }
    emit(CartCubitLoading());
    try {
      var data = await Api().post(
        url: EndPoints.baseUrl + EndPoints.addCartEndpoint,
        token: loginDataModel.data?.token,
        body: {
          "product_id":id.toString(),
        },
      );

      var addModel=CartModel.fromJson(data);
      if (kDebugMode) {
        print("after adding favourites: ");
        print(addModel.data?.cartItems?.map((e) => e.itemProductName).toList());
      }
      if(!((addModel.status??0)>=200&&(addModel.status??0)<300)){
        throw Exception(addModel.message);
      }
      cartItems=addModel.data?.cartItems??[];
      emit(CartCubitSuccess());
      AnimatedSnackBar.material(
          "Added to cart",
          type: AnimatedSnackBarType.success,
          borderRadius: BorderRadius.circular(5),
          duration: const Duration(seconds: 4),
      ).show(context);
    } on Exception catch (e) {
      print(e.toString());
      emit(
        CartCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

  Future updateCart(int id,int quantity,context) async {
    if (kDebugMode) {
      print("\n\nin add cart items cubit\n\n");
    }
    // emit(CartCubitLoading());
    try {
      var data = await Api().post(
        url: EndPoints.baseUrl + EndPoints.updateCartEndpoint,
        token: loginDataModel.data?.token,
        body: {
          "cart_item_id":id.toString(),
          "quantity":quantity.toString(),
        },
      );

      var updateModel=CartModel.fromJson(data);
      if (kDebugMode) {
        print("after updating cart: ");
        print(updateModel.data?.cartItems?.map((e) => e.itemProductName).toList());
      }
      if(!((updateModel.status??0)>=200&&(updateModel.status??0)<300)){
        throw Exception(updateModel.message);
      }
      for(int i=0;i<cartItems.length;i++){
        if(cartItems[i].itemId==id){
          cartItems[i].itemQuantity=quantity;
        }
      }
      emit(CartCubitSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(
        CartCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

}