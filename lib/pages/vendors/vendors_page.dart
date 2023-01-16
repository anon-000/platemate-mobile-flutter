import 'package:event_admin/pages/vendors/controllers/approved_vendors_controller.dart';
import 'package:event_admin/pages/vendors/controllers/unapproved_vendors_controller.dart';
import 'package:event_admin/pages/vendors/widgets/vendor_tile.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/vendor_type.dart';

///
/// Created by Auro on 05/01/23 at 9:27 PM
///

class VendorsPage extends StatefulWidget {
  const VendorsPage({Key? key}) : super(key: key);

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  int vendorType = 1;
  late ApprovedVendorsController approvedController;
  late UnApprovedVendorsController unApprovedController;

  onVendorTypeChanged(int c) {
    vendorType = c;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    approvedController = Get.isRegistered<ApprovedVendorsController>()
        ? Get.find<ApprovedVendorsController>()
        : Get.put(ApprovedVendorsController());
    if (approvedController.state == null) approvedController.getData();
    unApprovedController = Get.isRegistered<UnApprovedVendorsController>()
        ? Get.find<UnApprovedVendorsController>()
        : Get.put(UnApprovedVendorsController());
    if (unApprovedController.state == null) unApprovedController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          VendorType(
            type: vendorType,
            onChanged: onVendorTypeChanged,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: vendorType == 1
                  ? RefreshIndicator(
                      onRefresh: () async {
                        unApprovedController.getData();
                      },
                      child: unApprovedController.obx(
                        (state) {
                          if (state != null) {
                            return ListView.separated(
                              controller: unApprovedController.scrollController,
                              physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              separatorBuilder: (c, i) => SizedBox(height: 16),
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 30),
                              itemBuilder: (c, i) {
                                if (i >= state.length)
                                  return Center(
                                      child: CircularProgressIndicator());
                                return VendorTile(
                                  state[i],
                                  onAccept: () {
                                    showEventDialog(
                                        title:
                                            "Are you sure you want to accept this request?",
                                        positiveCallback: () {
                                          Get.back();
                                          unApprovedController
                                              .handleAcceptRejectOfRequest(
                                                  state[i],
                                                  status: 1);
                                        });
                                  },
                                  onReject: () {
                                    showEventDialog(
                                        title:
                                            "Are you sure you want to reject this request?",
                                        positiveCallback: () {
                                          Get.back();
                                          unApprovedController
                                              .handleAcceptRejectOfRequest(
                                                  state[i],
                                                  status: 3);
                                        });
                                  },
                                );
                              },
                              itemCount:
                                  unApprovedController.status.isLoadingMore
                                      ? state.length + 1
                                      : state.length,
                            );
                          }
                          return SizedBox();
                        },
                        onError: (e) => AppEmptyWidget(
                          title: "$e",
                          onReload: () {
                            unApprovedController.getData();
                          },
                        ),
                        onEmpty: AppEmptyWidget(
                          title: "No vendor requests available",
                          onReload: () {
                            unApprovedController.getData();
                          },
                        ),
                        onLoading: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        approvedController.getData();
                      },
                      child: approvedController.obx(
                        (state) {
                          if (state != null) {
                            return ListView.separated(
                              controller: approvedController.scrollController,
                              physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              separatorBuilder: (c, i) => SizedBox(height: 16),
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 30),
                              itemBuilder: (c, i) {
                                if (i >= state.length)
                                  return Center(
                                      child: CircularProgressIndicator());
                                return VendorTile(
                                  state[i],
                                  onRemove: () {
                                    showEventDialog(
                                        title:
                                            "Are you sure you want to remove this vendor?",
                                        positiveCallback: () {
                                          Get.back();
                                          approvedController
                                              .handleVendorRemove(state[i]);
                                        });
                                  },
                                );
                              },
                              itemCount: approvedController.status.isLoadingMore
                                  ? state.length + 1
                                  : state.length,
                            );
                          }
                          return SizedBox();
                        },
                        onError: (e) => AppEmptyWidget(
                          title: "$e",
                          onReload: () {
                            approvedController.getData();
                          },
                        ),
                        onEmpty: AppEmptyWidget(
                          title: "No vendors available",
                          onReload: () {
                            approvedController.getData();
                          },
                        ),
                        onLoading: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
