import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/pages/checkout/checkout_page.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 26/04/23 at 9:22 PM
///

class CartDetailsBar extends StatelessWidget {
  const CartDetailsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, -4),
            blurRadius: 24,
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2 items added worth",
                  style: TextStyle(
                    color: AppColors.grey40,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rs. 160",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AppPrimaryButton(
            color: AppColors.green_2_0,
            child: Text("Order items"),
            onPressed: () {
              Get.toNamed(CheckOutPage.routeName);
            },
          )
        ],
      ),
    );
  }
}
