import 'package:event_admin/pages/booking_history/controllers/event_history_controller.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/event_details_page.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 01/12/22 at 11:12 PM
///

class EventHistoryPage extends StatefulWidget {
  static const routeName = '/event-history-page';

  const EventHistoryPage({Key? key}) : super(key: key);

  @override
  State<EventHistoryPage> createState() => _EventHistoryPageState();
}

class _EventHistoryPageState extends State<EventHistoryPage> {
  late EventHistoryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<EventHistoryController>()
        ? Get.find<EventHistoryController>()
        : Get.put(EventHistoryController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event History"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getData();
        },
        child: controller.obx(
          (state) {
            if (state != null) {
              return ListView.separated(
                controller: controller.scrollController,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                separatorBuilder: (c, i) => SizedBox(height: 16),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 90),
                itemBuilder: (c, i) {
                  if (i >= state.length)
                    return Center(child: CircularProgressIndicator());
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        DashboardPage.routeName + EventDetailsPage.routeName,
                        arguments: {
                          "eventId": state[i].id,
                        },
                      );
                    },
                    child: EventCard(
                      state[i],
                    ),
                  );
                },
                itemCount: controller.status.isLoadingMore
                    ? state.length + 1
                    : state.length,
              );
            }
            return SizedBox();
          },
          onError: (e) => AppEmptyWidget(
            title: "$e",
          ),
          onEmpty: AppEmptyWidget(
            title: "No events available",
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
