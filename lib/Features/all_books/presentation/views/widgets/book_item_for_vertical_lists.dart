import 'package:eraa_books_store/Features/Splash/presentation/views/splash_screen.dart';
import 'package:eraa_books_store/Features/cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:eraa_books_store/Features/favourites/presentation/manager/cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_styles.dart';
import '../../../../home/data/models/newArrivalsModel.dart';
import '../../../../product_details/views/product_details_screen.dart';

class BookItemForVerticalLists extends StatelessWidget {
  const BookItemForVerticalLists({super.key, required this.products, this.listType="", this.showLastRow=true});
  final Products products;
  final String listType;
  final bool showLastRow;

  Route _customPageRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ProductDetailsScreen(product: products,heroTagForBookImage: "$listType book${products.id}"),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500), // Change the duration here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(_customPageRoute());
            },
            child: Ink(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: AppColors.textColorGreen,
                      child: AspectRatio(
                        aspectRatio: 17 / 26,
                        child: Hero(
                          tag: "$listType book${products.id}",
                          child: Image.network(
                            products.image ?? "",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.textColorGreen,
                      ),
                      width: 40,
                      height: 25,
                      child: Center(
                          child: Text(
                        "${products.discount}%",
                        style: AppStyles.descriptionTextStyle,
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(_customPageRoute());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${products.name}",
                        style: AppStyles.normalYellowTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        "${products.category}",
                        style: AppStyles.normalGreenTextStyle,
                        maxLines: 1,
                      ),
                      Text(
                        "EGP ${products.price}",
                        style: AppStyles.normalGreenTextStyle.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.textColorGreen,
                          decorationThickness: 5,
                        ),
                      ),
                      Text(
                        "EGP ${products.priceAfterDiscount}",
                        style: AppStyles.normalYellowTextStyle,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                showLastRow?Row(
                  children: [
                    InkWell(
                      onTap: () {
                        CartCubit.get(context).addCart(products.id??0, context);
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.teal,
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        FavouritesCubit.get(context).addFavourites(products.id??0,context);
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.teal,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ):Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
