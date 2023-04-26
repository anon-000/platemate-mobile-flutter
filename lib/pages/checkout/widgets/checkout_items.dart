import 'package:flutter/material.dart';
import 'package:platemate_user/pages/checkout/widgets/cart_item_tile.dart';
import 'package:platemate_user/widgets/app_title.dart';
import 'package:platemate_user/widgets/my_divider.dart';

///
/// Created by Auro on 26/04/23 at 3:41 PM
///

class CheckOutItemsSection extends StatelessWidget {
  const CheckOutItemsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          MediumTitleText("Cart items"),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => CartItemTile(),
            separatorBuilder: (c, i) => MyDivider(),
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}
