import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_image.dart';
import '../../../app_configs/app_assets.dart';

///
/// Created by Auro on 26/04/23 at 3:17 PM
///

class CheckOutRestaurantDetails extends StatelessWidget {
  const CheckOutRestaurantDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          MyImage(
            "https://d4t7t8y8xqo0t.cloudfront.net/resized/750X436/eazytrendz%2F2953%2Ftrend20201009113426.jpg",
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ordering at",
                  style: TextStyle(
                    color: AppColors.grey40,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Bonfire Food Court",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: SvgPicture.asset(AppAssets.arrow),
          )
        ],
      ),
    );
  }
}
