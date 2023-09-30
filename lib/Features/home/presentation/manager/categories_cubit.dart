import 'package:eraa_books_store/Features/home/data/models/categories_model.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/api.dart';
import '../../../../core/utils/endpoints.dart';

class CategoriesCubit extends Cubit<ListCubitState> {
  CategoriesCubit() : super(ListCubitInitial());

  static CategoriesCubit get(context)=>BlocProvider.of(context);

  late CategoriesModel model;
  Future getCategories() async {
    emit(ListCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.categoriesEndpoint,
        token: null,
      );

      model=CategoriesModel.fromJson(data);
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
