import 'package:event_admin/pages/booking_stats/widgets/booking_count_chart.dart';
import 'package:event_admin/pages/booking_stats/widgets/distribution_chart.dart';
import 'package:event_admin/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 07/01/23 at 8:56 AM
///

class BookingStatsPage extends StatefulWidget {
  static const routeName = '/booking-stats-page';

  const BookingStatsPage({Key? key}) : super(key: key);

  @override
  State<BookingStatsPage> createState() => _BookingStatsPageState();
}

class _BookingStatsPageState extends State<BookingStatsPage> {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking statistics"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: controller.obx(
          (state) {
            if (state != null) {
              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  Text(
                    "Event history analytics",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  BookingCountChart(
                    state.bookingReport!,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Booking Distribution analytics",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  BookingDistributionChart(
                    state.bookingReport!,
                  ),
                ],
              );
            }
            return SizedBox();
          },
          onError: (e) => AppEmptyWidget(
            title: "$e",
          ),
          onEmpty: AppEmptyWidget(
            title: "No stats available",
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
