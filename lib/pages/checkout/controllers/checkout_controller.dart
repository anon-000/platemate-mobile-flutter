import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/pages/cart/controllers/cart_controller.dart';

import '../../../widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 26/04/23 at 4:49 PM
///

class CheckOutController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  Restaurant? restaurant;
  String? tableId;
  String remarks = '';
  late CartController cartController;

  onRemarksSaved(String? v) {
    remarks = v ?? '';
  }

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    restaurant = args["restaurant"];
    tableId = args["tableId"];
    cartController = Get.isRegistered()
        ? Get.find<CartController>()
        : Get.put(CartController());
  }

  @override
  void dispose() {
    super.dispose();
  }




}
