import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/api.dart';
import '../../../../core/utils/endpoints.dart';

class SliderCubit extends Cubit<ListCubitState> {
  SliderCubit() : super(ListCubitInitial());

  static SliderCubit get(context)=>BlocProvider.of(context);

  List<Widget> sliderFinalWidgets=[];
  Future getSliders() async {
    emit(ListCubitLoading());
    try {
      var data = await Api().get(
        url: EndPoints.baseUrl + EndPoints.sliderEndpoint,
        token: null,
      );
      data['data']['sliders'].forEach(
              (v) {
            sliderFinalWidgets.add(
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: AppColors.textColorGreen,
                  child: Image.network(v['image'],fit: BoxFit.fill),
                ),
              )

            );
          }
      );
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
