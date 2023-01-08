import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/all_invited_events_page.dart';
import 'package:event_admin/pages/events/event_details_page.dart';
import 'package:event_admin/pages/events/widgets/event_card.dart';
import 'package:event_admin/pages/home/controllers/invited_event_controller.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 13/10/22 at 9:44 PM
///

class InvitedEvents extends StatelessWidget {
  final InvitedEventsController controller;

  const InvitedEvents(this.controller, {Key? key}) : super(key: key);

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
                  "Invited Events",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(
                    DashboardPage.routeName + AllInvitedEventsPage.routeName,
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
                                    EventDetailsPage.routeName,
                                arguments: {
                                  "eventId": state[i].id,
                                });
                          }
                        },
                        child: EventCard(
                          state[i],
                          invited: true,
                          onLeave: () {
                            if (!state[i].loading) {
                              showEventDialog(
                                  title: "Are you sure you want to leave?",
                                  positiveCallback: () {
                                    Get.back();
                                    controller.leaveEvent(state[i]);
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
        ),
      ],
    );
  }
}
