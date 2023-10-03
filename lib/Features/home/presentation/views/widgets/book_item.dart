import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraa_books_store/Features/product_details/views/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_styles.dart';
import '../../../data/models/newArrivalsModel.dart';

class BookItem extends StatelessWidget {
   const BookItem({super.key, required this.products, this.listType=""});

   final String listType;
   final Products products;

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
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(_customPageRoute());
        },
        child: SizedBox(
          width: (MediaQuery.of(context).size.height * 0.2)*(17.0/26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
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
                          child: CachedNetworkImage(
                            imageUrl: products.image??"",
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
                "\$${products.price}",
                style: AppStyles.normalGreenTextStyle.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.textColorGreen,
                  decorationThickness: 5,
                ),
              ),
              Text(
                "\$${products.priceAfterDiscount}",
                style: AppStyles.normalYellowTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
