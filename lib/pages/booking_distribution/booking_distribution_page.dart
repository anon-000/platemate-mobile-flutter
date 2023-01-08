import 'package:event_admin/pages/booking_distribution/controllers/booking_distribution_controller.dart';
import 'package:event_admin/pages/booking_distribution/widgets/distribution_card.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 07/01/23 at 8:56 AM
///

class BookingDistributionPage extends StatefulWidget {
  static const routeName = '/booking-distribution-page';

  const BookingDistributionPage({Key? key}) : super(key: key);

  @override
  State<BookingDistributionPage> createState() =>
      _BookingDistributionPageState();
}

class _BookingDistributionPageState extends State<BookingDistributionPage> {
  late BookingDistributionController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<BookingDistributionController>()
        ? Get.find<BookingDistributionController>()
        : Get.put(BookingDistributionController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Distribution"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: controller.obx(
          (state) {
            if (state != null) {
              return ListView.separated(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                separatorBuilder: (c, i) => SizedBox(height: 16),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                itemBuilder: (c, i) {
                  if (i >= state.length)
                    return Center(child: CircularProgressIndicator());
                  return GestureDetector(
                    onTap: () {},
                    child: DistributionTile(
                      state[i],
                    ),
                  );
                },
                itemCount: state.length,
              );
            }
            return SizedBox();
          },
          onError: (e) => AppEmptyWidget(
            title: "$e",
          ),
          onEmpty: AppEmptyWidget(
            title: "No distributions available",
            onReload: () {
              controller.getData();
            },
          ),
          onLoading: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
