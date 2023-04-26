import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/pages/checkout/widgets/item_quantity_button.dart';

import '../../../app_configs/app_assets.dart';
import '../../../app_configs/app_colors.dart';

///
/// Created by Auro on 26/04/23 at 3:45 PM
///

class CartItemTile extends StatelessWidget {
  const CartItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.veg,
                    height: 14,
                    color: Color(0xffF54D3D),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Chicken Biriyani',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Customization",
                      style: TextStyle(
                        color: AppColors.grey40,
                      ),
                    ),
                  ),
                  SvgPicture.asset(AppAssets.arrow),
                ],
              ),
              Text(
                'Rs. 160',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        ItemQuantityButton(
          quantity: 1,
          onDecrement: () {},
          onIncrement: () {},
        )
      ],
    );
  }
}
