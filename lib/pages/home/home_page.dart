import 'package:event_admin/pages/booking_distribution/booking_distribution_page.dart';
import 'package:event_admin/pages/booking_history/event_history_page.dart';
import 'package:event_admin/pages/booking_stats/booking_stats_page.dart';
import 'package:event_admin/pages/booking_stats/widgets/user_chart.dart';
import 'package:event_admin/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/home/widgets/home_top_bar.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/01/22 at 8:44 pm
///

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());
    controller.onInit();
    if (controller.state == null) controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeTopBar(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.getData();
            },
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(DashboardPage.routeName +
                              BookingStatsPage.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Text(
                            "Bookings statistics",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            DashboardPage.routeName +
                                BookingDistributionPage.routeName,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Text(
                            "Booking Distribution",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(DashboardPage.routeName +
                              EventHistoryPage.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Text(
                            "Booking History",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                controller.obx(
                  (state) {
                    if (state != null) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Total Users"),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.totalUsers}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Total Bookings"),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${state.totalBookings}",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "User analytics",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          UserCountChart(state.userReport),
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
                  onLoading: SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 200)
              ],
            ),
          ),
        )
      ],
    );
  }
}
