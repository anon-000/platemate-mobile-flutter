import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/pages/home/widgets/food_tile.dart';
import 'package:platemate_user/pages/restaurant_details/restaurant_details_page.dart';
import 'package:platemate_user/widgets/user_circle_avatar.dart';

///
/// Created by Auro on 04/03/23 at 10:42 AM
///

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RestaurantDetailsPage.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                UserCircleAvatar(
                    "https://img4.nbstatic.in/tr:w-500/5e7df741d60180000c4fdf0b.jpg"),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bonfire Food Court",
                        style: TextStyle(
                          color: AppColors.grey20,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "North Indian, Chinese",
                        style: TextStyle(
                          color: AppColors.grey40,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.rating_yellow,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "3.8",
                            style: TextStyle(
                              color: AppColors.rating_yellow,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(999k ratings)",
                            style: TextStyle(
                              color: AppColors.grey40,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            height: 4,
                            width: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.grey40,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "45% off",
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.grey40,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: ListView.separated(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (c, i) => SizedBox(width: 16),
                itemBuilder: (c, i) => FoodTile(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
