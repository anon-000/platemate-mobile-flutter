import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/pages/checkout/widgets/checkout_items.dart';
import 'package:platemate_user/pages/checkout/widgets/checkout_restaurant_details.dart';
import 'package:platemate_user/pages/orders/controllers/order_details_controller.dart';
import 'package:platemate_user/widgets/app_error_widget.dart';
import 'package:platemate_user/widgets/app_price_widget.dart';
import 'package:platemate_user/widgets/app_title.dart';

///
/// Created by Auro on 30/04/23 at 9:29 AM
///

class OrderDetailsPage extends StatefulWidget {
  static const routeName = '/order-details';

  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderDetailsController controller;

  Order get orderDetails => controller.state!;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments ?? {};
    String orderId = args["order"] ?? "";
    controller = OrderDetailsController();
    controller.onInit();
    controller.initData(orderId);
    controller.getOrderDetails();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (controller.status.isSuccess && state != null) {
          double actualPriceSum = orderDetails.price.totalSellingPrice;
          double discountedPriceSum = orderDetails.price.finalPrice;
          double deliveryCharges = 0;
          //double gstPercentage = Environment.gstPercentage;
          double gstAmount = 0;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Order : ${orderDetails.bookingId}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.getOrderDetails();
                    },
                    child: ListView(
                      children: [
                        CheckOutRestaurantDetails(
                            orderDetails.restaurantDetails!),
                        CheckOutItemsSection(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MediumTitleText("Order Summary"),
                              AppPriceWidget(orderDetails.price.finalPrice, 0),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MediumTitleText("Notes for the order"),
                              const SizedBox(height: 12),
                              Text("${orderDetails.notes}"),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // RateOrderTile(),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: AppPrimaryButton(
                //     radius: 0,
                //     child: Text("Reorder"),
                //     onPressed: () {},
                //   ),
                // )
              ],
            ),
          );
        }
        return SizedBox();
      },
      onError: (e) => Scaffold(
        appBar: AppBar(),
        body: AppErrorWidget(title: e ?? 'Some error occurred'),
      ),
      onEmpty: Scaffold(
        appBar: AppBar(),
        body: AppEmptyWidget(title: 'No details found'),
      ),
      onLoading: Scaffold(
        appBar: AppBar(),
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
