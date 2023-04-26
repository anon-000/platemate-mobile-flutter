import 'package:flutter/material.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/widgets/my_image.dart';

///
/// Created by Auro on 26/04/23 at 9:42 PM
///

class MenuRestaurantDetails extends StatelessWidget {
  const MenuRestaurantDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: MyImage(
              "https://img4.nbstatic.in/tr:w-500/5e7df741d60180000c4fdf0b.jpg",
              fit: BoxFit.cover,
            ),
          ),
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
        ],
      ),
    );
  }
}
