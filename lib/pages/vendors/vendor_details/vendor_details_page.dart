import 'package:event_admin/pages/vendors/vendor_details/controllers/vendor_details_controller.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_image_silder.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_info_card.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_info_type.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_overview.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_packages.dart';
import 'package:event_admin/pages/vendors/vendor_details/widgets/vendor_reviews.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 03/11/22 at 8:52 PM
///

class VendorDetailsPage extends StatefulWidget {
  static const routeName = '/vendor-details-page';

  const VendorDetailsPage({Key? key}) : super(key: key);

  @override
  State<VendorDetailsPage> createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  int _detailsType = 1;

  late VendorDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<VendorDetailsController>()
        ? Get.find<VendorDetailsController>()
        : Get.put(VendorDetailsController());
    controller.onInit();
    controller.getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx(
        (state) {
          if (state != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      VendorInfoCard(state),
                      const SizedBox(height: 10),
                      VendorImageSlider(state.attachments ?? []),
                      const SizedBox(height: 14),
                      Center(
                          child: Text(
                        "About us",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            "${state.description}",
                            style: TextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      VendorDetailsType(
                        type: _detailsType,
                        onChanged: (c) {
                          setState(() {
                            _detailsType = c;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _detailsType == 1
                              ? VendorOverview(state)
                              : _detailsType == 2
                                  ? VendorPackages(
                                      controller.vendorPackagesController,
                                    )
                                  : VendorReviews(
                                      controller.vendorRatingsController,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                //   child: SizedBox(
                //     width: double.infinity,
                //     child: AppPrimaryButton(
                //       child: Text("Have a chat!"),
                //       onPressed: () {},
                //     ),
                //   ),
                // ),
              ],
            );
          }
          return SizedBox();
        },
        onError: (e) => AppEmptyWidget(
          title: "$e",
        ),
        onEmpty: AppEmptyWidget(
          title: "No details available",
        ),
        onLoading: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
