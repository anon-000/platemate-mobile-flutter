import 'dart:developer';

import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/order.dart';

///
/// Created by Auro on 30/04/23 at 9:15 AM
///

class OrderDetailsController extends GetxController with StateMixin<Order> {
  String? orderId;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initData(String c) {
    orderId = c;
  }

  getOrderDetails() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.order,
        id: '$orderId',
        query: {
          '\$populate': ["orderedItems.menuItem", "restaurantDetails"],
        },
      );

      final response = Order.fromJson(result.data);

      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e ::: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
