import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/event_details_page.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/pages/home/controllers/invited_event_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 01/12/22 at 11:12 PM
///

class AllInvitedEventsPage extends StatefulWidget {
  static const routeName = '/all-invited-event-page';

  const AllInvitedEventsPage({Key? key}) : super(key: key);

  @override
  State<AllInvitedEventsPage> createState() => _AllInvitedEventsPageState();
}

class _AllInvitedEventsPageState extends State<AllInvitedEventsPage> {
  late InvitedEventsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<InvitedEventsController>()
        ? Get.find<InvitedEventsController>()
        : Get.put(InvitedEventsController());
    controller.onInit();
    if (controller.state == null) controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Invited Events"),
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
                      invited: true,
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
            title: "No invited events available",
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
