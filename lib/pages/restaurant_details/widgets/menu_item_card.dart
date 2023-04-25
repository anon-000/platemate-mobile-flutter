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
      height: 134,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey90),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.veg, height: 14),
                    const SizedBox(width: 6),
                    Text(
                      'North Indian, Mughlai',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Chicken Biriyani",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Lorem ipsum dolor sit amet, consec tetur adip more...',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey40,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Text(
                  "Rs. 160",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(width: 16),
          MyImage(
            "https://assets.cntraveller.in/photos/6218cfdf6774879c067d3ece/1:1/w_1079,h_1079,c_limit/best%20biryani%20in%20pune%20lead.jpg",
            width: 130,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
