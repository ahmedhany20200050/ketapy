import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/home/presentation/manager/lists_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_colors.dart';
import '../../manager/best_seller_cubit.dart';
import 'book_item.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<BestSellerCubit>(context)..getSliders(),
      child: BlocConsumer<BestSellerCubit, ListCubitState>(
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
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount:
                  BestSellerCubit.get(context).model.data?.products?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return BookItem(
                  products:
                      BestSellerCubit.get(context).model.data!.products![index],
                );
              },
            ),
          ):
          const Center(
            child: CircularProgressIndicator(color: AppColors.textColorYellow,),
          );
        },
      ),
    );
  }
}
