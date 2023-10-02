import 'package:flutter/material.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/app_styles.dart';
import '../../../../home/data/models/newArrivalsModel.dart';

class BookItemForVerticalLists extends StatelessWidget {
  const BookItemForVerticalLists({super.key, required this.products});
  final Products products;

  @override
  Widget build(BuildContext context) {
    // print(products.image!+ "  "+products.name!);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
                    child: Image.network(
                      products.image ?? "",
                      fit: BoxFit.fill,
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
          const SizedBox(
            width: 16,
          ),
          Expanded(
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
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {

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
                      onTap: () {},
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
