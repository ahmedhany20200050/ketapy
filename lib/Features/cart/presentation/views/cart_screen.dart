import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:eraa_books_store/Features/all_books/presentation/views/widgets/book_item_for_vertical_lists.dart';
import 'package:eraa_books_store/Features/cart/presentation/manager/cubit/cart_states.dart';
import 'package:eraa_books_store/Features/favourites/presentation/manager/cubit/favourites_states.dart';
import 'package:eraa_books_store/Features/home/data/models/newArrivalsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../manager/cubit/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String id = "CartScreen";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

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
                  InkWell(onTap: (){Navigator.of(context).pop();},child: Ink(child: Icon(Icons.arrow_back,color: Colors.teal,size: 32,))),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              BlocProvider.value(
                value: BlocProvider.of<CartCubit>(context)..getCart(),
                child: BlocConsumer<CartCubit, CartCubitState>(
                  listener: (context, state) {
                    if(state is CartCubitFailure){
                      AnimatedSnackBar.material(
                          "${state.err['error']}",
                          type: AnimatedSnackBarType.error,
                          duration: Duration(seconds: 5),
                      ).show(context);
                    }
                  },
                  builder: (context, state) {
                    var cubit = BlocProvider.of<CartCubit>(context);
                    return state is CartCubitSuccess?Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: cubit.cartItems.length,
                              itemBuilder: (context, index) {
                                var fav = cubit.cartItems[index];
                                Products product = Products(
                                  name: fav.itemProductName,
                                  id: fav.itemId,
                                  description: "",
                                  image: fav.itemProductImage,
                                  bestSeller: 0,
                                  category: "",
                                  discount: fav.itemProductDiscount,
                                  price: fav.itemProductPrice,
                                  priceAfterDiscount:
                                      fav.itemProductPriceAfterDiscount?.toDouble(),
                                  stock: fav.itemProductStock,
                                );
                                return Row(
                                  children: [
                                    Expanded(
                                      child: BookItemForVerticalLists(
                                        products: product,
                                        listType: "cart list",
                                        showLastRow: false,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: InkWell(
                                            onTap: () {
                                              cubit.removeCart(product.id ?? 1);
                                            },
                                            child: Ink(
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.delete,
                                                size: 22,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                int? newQuantity=fav.itemQuantity!-1<1?1:fav.itemQuantity!-1;
                                                cubit.updateCart(fav.itemId??0, newQuantity, context);
                                              },
                                              icon: const Icon(
                                                color: Colors.teal,
                                                Icons.remove,
                                              ),
                                            ),
                                            Text(
                                              "${fav.itemQuantity}",
                                              style: AppStyles.normalYellowTextStyle,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                int? newQuantity=fav.itemQuantity!+1;
                                                cubit.updateCart(fav.itemId??0, newQuantity, context);
                                              },
                                              icon: const Icon(
                                                  color: Colors.teal,
                                              Icons.add),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Text("total price:${cubit.cartModel?.data?.total} EGP",
                                      style: AppStyles.descriptionTextStyle.copyWith(
                                      fontSize: 22,
                                    ),)
                                  ],
                                ),
                                 CustomButton(buttonText: "Checkout"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ):Center(child: CircularProgressIndicator(color: Colors.teal,),);
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
