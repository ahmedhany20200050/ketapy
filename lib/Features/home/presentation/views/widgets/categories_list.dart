

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_colors.dart';
import '../../manager/categories_cubit.dart';
import '../../manager/lists_states.dart';
import 'categories_list_item.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = CategoriesCubit.get(context);
    return BlocProvider.value(
      value: CategoriesCubit.get(context)..getCategories(),
      child: BlocConsumer<CategoriesCubit, ListCubitState>(
        listener: (context, state) {
          if (state is ListCubitFailure) {
            if (state.err.containsKey('error')) {
              AnimatedSnackBar.material(
                '${state.err['error']}',
                type: AnimatedSnackBarType.error,
                duration: const Duration(seconds: 4),
              ).show(context);
            }
          }
        },
        builder: (context, state) {
          return state is ListCubitSuccess
              ? SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.model.data!.categories?.length,
              itemBuilder: (context, index) {
                return CategoriesListItem(
                  category: cubit.model.data!.categories![index],
                );
              },
            ),
          )
              : const Center(
            child: CircularProgressIndicator(
              color: AppColors.textColorYellow,
            ),
          );
        },
      ),
    );
  }
}
