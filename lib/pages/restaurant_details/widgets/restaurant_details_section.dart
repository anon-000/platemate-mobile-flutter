import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 25/04/23 at 7:29 PM
///

class RestaurantDetailsSection extends StatelessWidget {
  const RestaurantDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded),
              const SizedBox(width: 4),
              Text(
                '18 kms away ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text("  |  Open now"),
              Spacer(),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppAssets.share),
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Plot no 99, Chandrashekharpur, Near Hanuman temple, Bhubaneswar, 751012",
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          MyDivider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(AppAssets.star),
              ),
              const SizedBox(width: 10),
              Text(
                "3.8",
                style: TextStyle(
                  color: AppColors.rating_yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "( 999k ratings )",
                style: TextStyle(
                  color: AppColors.grey40,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "Rs. 200",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                " for two",
                style: TextStyle(
                  color: AppColors.grey40,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey40,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "45% off",
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
