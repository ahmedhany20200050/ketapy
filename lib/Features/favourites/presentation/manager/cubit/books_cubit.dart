
import 'package:eraa_books_store/Features/all_books/data/search_model.dart';
import 'package:eraa_books_store/Features/all_books/presentation/manager/cubit/books_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/api.dart';
import '../../../../../core/utils/endpoints.dart';
import '../../../../home/data/models/newArrivalsModel.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());
  SearchModel? searchModel;
  int pageNumber=0;
  bool isThereNextPage=true;
  List<Products>products=[];
  void resetCubit(){
    pageNumber=0;
    isThereNextPage=true;
    searchModel=null;
    products=[];
  }
  Future searchBooks(String searchWord) async {
    print("\n\nin search Books cubit\n\n");
    if(isThereNextPage){
      pageNumber++;
    }else{
      return;
    }
    emit(SearchCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.searchEndpoint(searchWord, pageNumber),
        token: null,
      );
      searchModel=SearchModel.fromJson(data);
      products..addAll(searchModel!.data!.products!);
      if(searchModel?.data?.links?.next==null){
        print("it is null");
        isThereNextPage=false;
      }
      print(data);
      emit(SearchCubitSuccess());
    } on Exception catch (e) {
      emit(
        SearchCubitFailure(
          err: {
            'error': e.toString(),
          },
        ),
      );
    }
  }

}