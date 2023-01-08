import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/events/controllers/event_vendors_controller.dart';
import 'package:event_admin/pages/vendors/widgets/vendor_tile.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 13/11/22 at 4:50 PM
///

class EventVendorsPage extends StatefulWidget {
  static const routeName = '/event-vendors-page';

  const EventVendorsPage({Key? key}) : super(key: key);

  @override
  State<EventVendorsPage> createState() => _EventVendorsPageState();
}

class _EventVendorsPageState extends State<EventVendorsPage> {
  late EventVendorsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EventVendorsController());
    controller.onInit();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Event vendors")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RefreshIndicator(
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
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemBuilder: (c, i) {
                        if (i >= state.length)
                          return Center(child: CircularProgressIndicator());
                        return GestureDetector(
                          onTap: () {
                          },
                          // child: VendorTile(state[i]),
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
                  title: "No vendors added",
                ),
                onLoading: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                child: Text("Add Vendor"),
                onPressed: () {
                  // Get.toNamed(
                  //   DashboardPage.routeName + CreateSubEventPage.routeName,
                  // );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
