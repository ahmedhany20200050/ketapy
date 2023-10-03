import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/new_arrivals_cubit.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_item.dart';

class NewArrivalsList extends StatelessWidget {
  const NewArrivalsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<NewArrivalsCubit>(context)..getNewArrivals(),
      child: BlocConsumer<NewArrivalsCubit, ListCubitState>(
        listener: (context, state) {
          if(state is ListCubitFailure){
            if(state.err.containsKey('error')){
              AnimatedSnackBar.material(
                '${state.err['error']}',
                type: AnimatedSnackBarType.error,
                duration: const Duration(seconds: 4),
              ).show(context);
            }
          }
        },
        builder: (context, state) {
          return state is ListCubitSuccess?SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              itemCount:
                  NewArrivalsCubit.get(context).model.data?.products?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return BookItem(
                  listType: "new arrival list",
                  products: NewArrivalsCubit.get(context)
                      .model
                      .data!
                      .products![index],
                );
              },
            ),
          ):
          const Center(child: CircularProgressIndicator(color: AppColors.textColorYellow,),);
        },
      ),
    );
  }
}
