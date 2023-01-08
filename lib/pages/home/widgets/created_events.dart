import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/all_created_events_page.dart';
import 'package:event_admin/pages/events/create_event_page.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/pages/home/controllers/my_event_controller.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 18/01/22 at 11:19 pm
///

class CreatedEvents extends StatelessWidget {
  final MyEventController controller;

  const CreatedEvents(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "My Events",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(
                    DashboardPage.routeName + AllCreatedEventsPage.routeName,
                  );
                },
                child: Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
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
                          if (state[i].status == 3) {
                            SnackBarHelper.show(
                                "Sorry, you cancelled the event.");
                            return;
                          }
                          if (!state[i].loading) {
                            Get.toNamed(
                              DashboardPage.routeName +
                                  CreateEventPage.routeName,
                              arguments: {
                                "eventId": state[i].id,
                              },
                            );
                          }
                        },
                        child: EventCard(
                          state[i],
                          onCancel: () {
                            if (!state[i].loading) {
                              showEventDialog(
                                  title:
                                      "Are you sure you want to cancel the published event?",
                                  positiveCallback: () {
                                    Get.back();
                                    controller.cancelEvent(state[i]);
                                  });
                            }
                          },
                          onRemove: () {
                            if (!state[i].loading) {
                              showEventDialog(
                                  title:
                                      "Are you sure you want to remove the draft?",
                                  positiveCallback: () {
                                    Get.back();
                                    controller.removeEvent(state[i]);
                                  });
                            }
                          },
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
        ),
      ],
    );
  }
}
