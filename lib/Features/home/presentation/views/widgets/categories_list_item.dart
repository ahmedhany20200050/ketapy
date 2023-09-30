

import 'package:flutter/material.dart';

import '../../../../../core/app_colors.dart';
import '../../../../../core/app_styles.dart';
import '../../../data/models/categories_model.dart';

class CategoriesListItem extends StatelessWidget {
  const CategoriesListItem({super.key, required this.category});
  final Categories category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textColorGreen,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "${category.name}",
                style: AppStyles.descriptionTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )),
      ),
    );
  }
}
