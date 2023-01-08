import 'package:event_admin/pages/events/controllers/event_details_controller.dart';
import 'package:event_admin/pages/events/widgets/event_info.dart';
import 'package:event_admin/pages/events/widgets/feed_widget.dart';
import 'package:event_admin/pages/events/widgets/sub_events.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 16/10/22 at 1:16 AM
///

class EventDetailsPage extends StatefulWidget {
  static const routeName = '/event-details-page';

  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late EventDetailsController controller;

  bool get me => false;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<EventDetailsController>()
        ? Get.find<EventDetailsController>()
        : Get.put(EventDetailsController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MyBackground(),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                  Expanded(
                    child: controller.obx(
                      (state) {
                        if (state != null) {
                          return ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            children: [
                              if (me) ...[
                                // const SizedBox(height: 12),
                                // MyEventInfo(state),
                                // const SizedBox(height: 30),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Co-host details",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Guests",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Budget",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(height: 16),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Date & Time",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Vendors",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //     const SizedBox(width: 16),
                                //     Expanded(
                                //       child: EventPropertyCard(
                                //         asset: AppAssets.co_host,
                                //         title: "Sub Events",
                                //         onTap: () {},
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ] else ...[
                                EventInfo(state),
                                if (state.subEvents!.isNotEmpty)
                                  const SizedBox(height: 20),
                                SubEvents(state.subEvents ?? []),
                              ],
                              const SizedBox(height: 20),
                              GetBuilder(
                                init: controller,
                                builder: (c) => EventFeed(
                                  me: me,
                                  type: controller.feedType,
                                  onChanged: controller.onFeedTypeUpdate,
                                ),
                              ),
                              const SizedBox(height: 25),
                            ],
                          );
                        }
                        return SizedBox();
                      },
                      onError: (e) => AppEmptyWidget(
                        title: "$e",
                      ),
                      onEmpty: AppEmptyWidget(
                        title: "No data found",
                        onReload: () {
                          controller.getData();
                        },
                      ),
                      onLoading: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
