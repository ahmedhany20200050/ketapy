

import 'package:eraa_books_store/Features/favourites/data/favourite_model.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import 'favourites_states.dart';

class FavouritesCubit extends Cubit<FavouritesCubitState> {
  FavouritesCubit() : super(FavouritesCubitInitial());
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
    emit(FavouritesCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.favouritesEndpoint,
        token: loginDataModel.data?.token,
      );
      if (kDebugMode) {
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

}