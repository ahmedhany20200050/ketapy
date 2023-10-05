

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/favourites/data/favourite_model.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import 'favourites_states.dart';

class FavouritesCubit extends Cubit<FavouritesCubitState> {
  FavouritesCubit() : super(FavouritesCubitInitial());

  static FavouritesCubit get(context)=>BlocProvider.of(context);
  FavouriteModel? favouriteModel;
  int pageNumber=0;
  bool isThereNextPage=true;
  List<Favourites>favourites=[];
  void resetCubit(){
    pageNumber=0;
    isThereNextPage=true;
    favouriteModel=null;
    favourites=[];
  }
  Future getFavourites() async {
    if (kDebugMode) {
      print("\n\nin favourites cubit\n\n");
    }
    if(isThereNextPage){
      pageNumber++;
    }else{
      return;
    }
    // emit(FavouritesCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.favouritesEndpoint(pageNumber),
        token: loginDataModel.data?.token,
      );
      if (kDebugMode) {
        print("page number: $pageNumber");
        print("favourites");
        print(data);
      }
      favouriteModel=FavouriteModel.fromJson(data);
      if(!((favouriteModel!.status??0)>=200&&(favouriteModel!.status??0)<300)){
        throw Exception(favouriteModel?.message);
      }
      if(favouriteModel?.data?.nextPageUrl==null){
        if (kDebugMode) {
          print("it is null");
        }
        isThereNextPage=false;
      }
      if(favouriteModel!.data!.favourites!=null){
        favourites.addAll(favouriteModel!.data!.favourites!);
      }
      emit(FavouritesCubitSuccess());
    } on Exception catch (e) {
      emit(
        FavouritesCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

  Future removeFavourites(int id) async {
    if (kDebugMode) {
      print("\n\nin remove favourites cubit\n\n");
    }
    // emit(FavouritesCubitLoading());
    try {
      var data = await Api().post(
        url: EndPoints.baseUrl + EndPoints.removeFavouritesEndpoint,
        token: loginDataModel.data?.token,
        body: {
          "product_id":id.toString(),
      },
      );
      if (kDebugMode) {
        print("after remove favourites: ");
        print(data);
      }
      var removeModel=FavouriteModel.fromJson(data);
      if(!((removeModel.status??0)>=200&&(removeModel.status??0)<300)){
        throw Exception(removeModel.message);
      }
      favourites.removeWhere((element) => element.id==id);
      emit(FavouritesCubitSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(
        FavouritesCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

  Future addFavourites(int id,context) async {
    if (kDebugMode) {
      print("\n\nin add favourites cubit\n\n");
    }
    // emit(FavouritesCubitLoading());
    try {
      var data = await Api().post(
        url: EndPoints.baseUrl + EndPoints.addFavouritesEndpoint,
        token: loginDataModel.data?.token,
        body: {
          "product_id":id.toString(),
        },
      );

      var addModel=FavouriteModel.fromJson(data);
      if (kDebugMode) {
        print("after adding favourites: ");
        print(addModel.data?.favourites?.map((e) => e.name).toList());
      }
      if(!((addModel.status??0)>=200&&(addModel.status??0)<300)){
        throw Exception(addModel.message);
      }
      favourites.removeWhere((element) => element.id==id);
      emit(FavouritesCubitSuccess());
      AnimatedSnackBar.material(
          "Added to Favourites",
          type: AnimatedSnackBarType.success,
          borderRadius: BorderRadius.circular(5),
          duration: const Duration(seconds: 4),
      ).show(context);
    } on Exception catch (e) {
      print(e.toString());
      emit(
        FavouritesCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

}