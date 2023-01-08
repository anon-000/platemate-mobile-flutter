import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/pages/event_types/controllers/event_type_controller.dart';
import 'package:event_admin/pages/event_types/widgets/event_type_add_sheet.dart';
import 'package:event_admin/pages/event_types/widgets/event_type_tile.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 07/01/23 at 8:56 AM
///

class EventTypesPage extends StatefulWidget {
  static const routeName = '/event-types-page';

  const EventTypesPage({Key? key}) : super(key: key);

  @override
  State<EventTypesPage> createState() => _EventTypesPageState();
}

class _EventTypesPageState extends State<EventTypesPage> {
  late EventTypeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<EventTypeController>()
        ? Get.find<EventTypeController>()
        : Get.put(EventTypeController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          backgroundColor: AppColors.brightSecondaryColor,
          child: Icon(Icons.add),
          onPressed: () async {
            await Get.bottomSheet(
              EventTypeAdditionSheet(),
              isDismissible: true,
              isScrollControlled: true,
            );
          },
        ),
      ),
      appBar: AppBar(
        title: Text("Event Types"),
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
                    onTap: () async {
                      await Get.bottomSheet(
                        EventTypeAdditionSheet(
                          datum: state[i],
                        ),
                        isDismissible: true,
                        isScrollControlled: true,
                      );
                    },
                    child: EventTypeTile(
                      state[i],
                      onRemove: () {
                        if (!state[i].loading) {
                          showEventDialog(
                            title:
                                "Are you sure you want to remove the event type?",
                            positiveCallback: () {
                              Get.back();
                              controller.removeEventType(state[i]);
                            },
                          );
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
            title: "No event types available",
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
