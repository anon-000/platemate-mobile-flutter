import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platemate_user/app_configs/app_assets.dart';
import 'package:platemate_user/app_configs/app_colors.dart';

///
/// Created by Auro on 26/04/23 at 4:23 PM
///

class ItemQuantityButton extends StatelessWidget {
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final int? quantity;

  const ItemQuantityButton({
    Key? key,
    this.onDecrement,
    this.onIncrement,
    this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.grey80,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onDecrement,
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: SvgPicture.asset(AppAssets.subtract),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "${quantity}",
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: SvgPicture.asset(AppAssets.add),
            ),
          ),
        ],
      ),
    );
  }
}
