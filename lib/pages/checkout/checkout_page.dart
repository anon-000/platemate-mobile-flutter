import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/cart/widgets/cart_details_bar.dart';
import 'package:platemate_user/pages/checkout/widgets/checkout_items.dart';
import 'package:platemate_user/pages/checkout/widgets/checkout_restaurant_details.dart';
import 'package:platemate_user/widgets/app_price_widget.dart';

import '../../app_configs/app_assets.dart';
import '../../app_configs/app_decorations.dart';
import '../../widgets/app_title.dart';
import 'controllers/checkout_controller.dart';

///
/// Created by Auro on 26/04/23 at 2:23 PM
///

class CheckOutPage extends StatefulWidget {
  static const routeName = '/check-out-page';

  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late CheckOutController controller;

  @override
  void initState() {
    super.initState();
    controller = CheckOutController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(AppAssets.back_button),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CheckOutRestaurantDetails(),
                CheckOutItemsSection(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumTitleText("Order Summary"),
                      AppPriceWidget(160, 0),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumTitleText("Notes for the order"),
                      TextFormField(
                        minLines: 6,
                        maxLines: 9,
                        initialValue: controller.remarks,
                        onSaved: controller.onRemarksSaved,
                        decoration: AppDecorations.textFieldDecoration(context,
                                radius: 12)
                            .copyWith(
                          prefixIconConstraints:
                              BoxConstraints.tightFor(width: 54),
                          hintText: "Give your remarks",
                        ),
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          CartDetailsBar(),
        ],
      ),
    );
  }
}
