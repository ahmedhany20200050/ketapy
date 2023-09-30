import 'package:eraa_books_store/Features/home/data/models/newArrivalsModel.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/api.dart';
import '../../../../core/utils/endpoints.dart';

class NewArrivalsCubit extends Cubit<ListCubitState> {
  NewArrivalsCubit() : super(ListCubitInitial());

  static NewArrivalsCubit get(context)=>BlocProvider.of(context);
  Map<String,dynamic> finalData={};
  late NewArrivalsModel model;
  Future getNewArrivals() async {
    emit(ListCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.newArrivalsEndpoint,
        token: null,
      );
      finalData=data['data'];
      model=NewArrivalsModel.fromJson(data);
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
