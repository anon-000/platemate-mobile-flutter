import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/pages/checkout/widgets/item_quantity_button.dart';

import '../../../app_configs/app_assets.dart';
import '../../../app_configs/app_colors.dart';

///
/// Created by Auro on 26/04/23 at 3:45 PM
///

class CartItemTile extends StatelessWidget {
  final OrderedItem datum;

  const CartItemTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${datum.menuItem.name}',
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
                  const SizedBox(width: 8),
                  SvgPicture.asset(AppAssets.arrow, height: 6),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Rs. ${(datum.variant.price * datum.quantity).toStringAsFixed(1)}',
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
