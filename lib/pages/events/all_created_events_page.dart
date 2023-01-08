import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/create_event_page.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/pages/home/controllers/my_event_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 01/12/22 at 11:12 PM
///

class AllCreatedEventsPage extends StatefulWidget {
  static const routeName = '/all-created-event-page';

  const AllCreatedEventsPage({Key? key}) : super(key: key);

  @override
  State<AllCreatedEventsPage> createState() => _AllCreatedEventsPageState();
}

class _AllCreatedEventsPageState extends State<AllCreatedEventsPage> {
  late MyEventController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<MyEventController>()
        ? Get.find<MyEventController>()
        : Get.put(MyEventController());
    controller.onInit();
    if (controller.state == null) controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Created Events"),
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
                        DashboardPage.routeName + CreateEventPage.routeName,
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
            title: "No created events available",
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
