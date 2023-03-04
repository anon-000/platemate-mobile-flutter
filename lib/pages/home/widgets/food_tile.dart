import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_image.dart';

///
/// Created by Auro on 04/03/23 at 10:51 AM
///

class FoodTile extends StatelessWidget {
  const FoodTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      clipBehavior: Clip.antiAlias,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.grey80,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.veg),
                  const SizedBox(height: 6),
                  Text(
                    "Chicken Biriryani",
                    style: TextStyle(
                      color: AppColors.grey20,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Rs. 160",
                    style: TextStyle(
                      color: AppColors.grey20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyImage(
            "https://img.onmanorama.com/content/dam/mm/en/food/in-season/Ramzan/Images/hyderabadi-dum-biryani.jpg",
            width: 80,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
