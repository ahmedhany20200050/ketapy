import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/all_books/presentation/views/widgets/book_item_for_vertical_lists.dart';
import 'package:eraa_books_store/Features/cart/presentation/manager/cubit/cart_states.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/governments_cubit.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/governments_states.dart';
import 'package:eraa_books_store/Features/checkout/presentation/manager/cubit/place_order_cubit.dart';
import 'package:eraa_books_store/Features/favourites/presentation/manager/cubit/favourites_states.dart';
import 'package:eraa_books_store/Features/home/data/models/newArrivalsModel.dart';
import 'package:eraa_books_store/Features/login/presentation/manger/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../manager/cubit/checkout_cubit.dart';
import '../manager/cubit/checkout_states.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const String id = "CheckoutScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Ink(
                          child: Icon(
                        Icons.arrow_back,
                        color: Colors.teal,
                        size: 32,
                      ))),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Name: ",
                style: AppStyles.normalGreenTextStyle,
              ),
              Text(
                "${loginDataModel.data?.user?.name}",
                style: AppStyles.normalGreenTextStyle,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "E-mail: ",
                style: AppStyles.normalGreenTextStyle,
              ),
              Text(
                "${loginDataModel.data?.user?.email}",
                style: AppStyles.normalGreenTextStyle,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Address: ",
                style: AppStyles.normalGreenTextStyle,
              ),
              Text(
                "${loginDataModel.data?.user?.address}",
                style: AppStyles.normalGreenTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: BlocProvider.value(
                  value: BlocProvider.of<GovCubit>(context)..getGovs(),
                  child: BlocBuilder<GovCubit, GovCubitState>(
                    builder: (context, state) {
                      final cubit = BlocProvider.of<GovCubit>(context);
                      return state is GovCubitSuccess
                          ? DropdownButton(
                              enableFeedback: true,
                              isExpanded: true,
                              value: cubit.currentDropDownValue,
                              items: cubit.govsModel.data?.map(
                                (e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      "${e.governorateNameEn}",
                                      style: AppStyles.normalGreenTextStyle,
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                cubit.updateDropDown(value ?? 0);
                              },
                            )
                          : const Center(
                              child:
                                  CircularProgressIndicator(color: Colors.teal),
                            );
                    },
                  ),
                ),
              ),
              BlocProvider.value(
                value: BlocProvider.of<CheckoutCubit>(context)..getCheckout(),
                child: BlocConsumer<CheckoutCubit, CheckoutCubitState>(
                  listener: (context, state) {
                    if (state is CheckoutCubitFailure) {
                      AnimatedSnackBar.material(
                        "${state.err['error']}",
                        type: AnimatedSnackBarType.error,
                        duration: const Duration(seconds: 5),
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    var cubit = BlocProvider.of<CheckoutCubit>(context);
                    return state is CheckoutCubitSuccess
                        ? Expanded(
                            child: Column(
                              children: [
                                Text(
                                  "Order Summary: ",
                                  style: AppStyles.normalGreenTextStyle
                                      .copyWith(fontSize: 22),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: cubit.cartItems.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${cubit.cartItems[index].itemProductName}",
                                                  style: AppStyles
                                                      .normalGreenTextStyle,
                                                ),
                                                Text(
                                                  "quantity: ${cubit.cartItems[index].itemQuantity}",
                                                  style: AppStyles
                                                      .normalGreenTextStyle,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${cubit.cartItems[index].itemTotal}",
                                              style: AppStyles
                                                  .normalGreenTextStyle,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "total price:${cubit.checkoutModel?.data?.total} EGP",
                                            style: AppStyles
                                                .descriptionTextStyle
                                                .copyWith(
                                              fontSize: 22,
                                            ),
                                          )
                                        ],
                                      ),
                                      CustomButton(
                                        buttonText: "place order",
                                        onPressed: (){
                                          PlaceOrderCubit.get(context).placeOrder(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
