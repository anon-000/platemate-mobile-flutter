import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_image.dart';

///
/// Created by Auro on 25/04/23 at 8:18 PM
///

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.veg),
                    const SizedBox(width: 9),
                    Text(
                      'North Indian, Mughlai',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  "Chicken Biriyani",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consec tetur adip more...',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey40,
                  ),
                ),
                Spacer(),
                Text(
                  "Rs. 160",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
          MyImage(
            "https://img.onmanorama.com/content/dam/mm/en/food/in-season/Ramzan/Images/hyderabadi-dum-biryani.jpg",
            width: 134,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
