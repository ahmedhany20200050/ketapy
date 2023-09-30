

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_colors.dart';
import '../../manager/slider_cubit.dart';
import '../../manager/lists_states.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: SliderCubit.get(context)..getSliders(),
      child: BlocConsumer<SliderCubit, ListCubitState>(
        listener: (context, state) {
          if (state is ListCubitFailure) {
            if (state.err.containsKey('error')) {
              AnimatedSnackBar.material(
                state.err['error'].toString().replaceAll("Exception:", " "),
                type: AnimatedSnackBarType.error,
                duration: const Duration(seconds: 4),
              ).show(context);
            }
          }
        },
        builder: (context, state) {
          var cubit = SliderCubit.get(context);
          return state is ListCubitSuccess
              ? CarouselSlider(
              items: cubit.sliderFinalWidgets,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.2,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: 0.7,
                enlargeCenterPage: true,
              ))
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
