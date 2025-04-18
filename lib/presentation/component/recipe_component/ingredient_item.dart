// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recipe_app/core/ui/color_style.dart';
import 'package:recipe_app/core/ui/text_style.dart';
import 'package:recipe_app/presentation/component/image_component/app_image.dart';
import 'package:recipe_app/presentation/component/image_component/skelton_animtion_widget.dart';

class IngredientItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final String weight;

  const IngredientItem({
    required this.title,
    required this.imagePath,
    required this.weight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorStyle.gray4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: AppImage(
                  path: imagePath,
                  fit: BoxFit.cover,
                  skeletonBuilder:
                      (context, size) => SkeletonAnimationWidget(size: size),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.normalBold(color: ColorStyle.labelColour),
            ),
          ),
          const Spacer(),
          Text(
            weight,
            style: AppTextStyles.smallRegular(color: ColorStyle.gray3),
          ),
        ],
      ),
    );
  }
}
