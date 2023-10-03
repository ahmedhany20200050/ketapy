import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraa_books_store/Features/home/data/models/newArrivalsModel.dart';
import 'package:eraa_books_store/core/app_colors.dart';
import 'package:eraa_books_store/core/app_styles.dart';
import 'package:eraa_books_store/core/widgets/custom_button.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product, this.heroTagForBookImage=""});
  final Products product;
  final String heroTagForBookImage;


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(onTap: (){Navigator.of(context).pop();},child: Ink(child: Icon(Icons.arrow_back,color: Colors.teal,size: 32,))),
                          InkWell(onTap: (){},child: Ink(child: Icon(Icons.favorite_border_outlined,color: Colors.teal,size: 32,),)),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.5,
                        child: Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.4,
                            child: AspectRatio(
                              aspectRatio: 17/26,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Hero(
                                  tag: heroTagForBookImage,
                                  child: CachedNetworkImage(
                                    imageUrl:"${product.image}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text("${product.name}",style: AppStyles.biggerDiscriptionStyle.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),),
                      Text("${product.category}",style: AppStyles.normalGreenTextStyle,),
                      SizedBox(
                        height: 16,
                      ),
                      ExpandableText(
                        expandText: "show more",
                        collapseText: "show less",
                        "${product.description}",
                        style: AppStyles.descriptionTextStyle,
                        linkColor: Colors.teal,
                        maxLines: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text("${product.price}\$",style: AppStyles.normalGreenTextStyle.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 4,
                        decorationColor: AppColors.textColorGreen,
                      ),),
                      const SizedBox(width: 8,),
                      Text("${product.priceAfterDiscount}\$",style: AppStyles.descriptionTextStyle.copyWith(
                        fontSize: 22,
                      ),)
                    ],
                  ),
                  CustomButton(buttonText: "Add To Cart"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
