import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/pages/checkout/widgets/item_quantity_button.dart';
import 'package:platemate_user/pages/restaurant_menu/widgets/menu_item_customisation_sheet.dart';
import 'package:platemate_user/utils/my_extensions.dart';
import 'package:platemate_user/widgets/my_image.dart';

///
/// Created by Auro on 25/04/23 at 8:18 PM
///

class MenuItemCard extends StatelessWidget {
  final MenuItem datum;

  const MenuItemCard(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minPriceVariants = datum.variants.sortedBy((e) => e.price);

    return GestureDetector(
      onTap: () {},
      child: Container(
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
                    "${datum.name}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${datum.description}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey40,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    "Rs. ${minPriceVariants.first.price}",
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
            Stack(
              children: [
                MyImage(
                  "${datum.avatar}",
                  width: 130,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: ItemQuantityButton(
                    quantity: 3,
                    onIncrement: () {
                      Get.bottomSheet(
                        MenuItemCustomisationSheet(),
                        backgroundColor: Colors.white,
                      );
                    },
                    onDecrement: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
