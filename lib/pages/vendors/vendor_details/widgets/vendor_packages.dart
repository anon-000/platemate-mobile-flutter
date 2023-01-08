import 'package:event_admin/data_models/vendor_package.dart';
import 'package:event_admin/pages/vendors/vendor_details/controllers/vendor_packages_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 08/11/22 at 4:18 PM
///

class VendorPackages extends StatelessWidget {
  final VendorPackagesController controller;

  const VendorPackages(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state != null) {
          return ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (c, i) => VendorPackage(state[i]),
            separatorBuilder: (c, i) => SizedBox(height: 10),
            itemCount: state.length,
          );
        }
        return SizedBox();
      },
      onError: (e) => AppEmptyWidget(
        title: "$e",
      ),
      onEmpty: SizedBox(
        height: 100,
        child: AppEmptyWidget(
          title: "No packages yet",
        ),
      ),
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return ListView.separated(
    //   padding: const EdgeInsets.only(top: 10),
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   separatorBuilder: (c, i) => SizedBox(height: 10),
    //   itemBuilder: (c, i) => VendorPackage(),
    //   itemCount: 3,
    // );
  }
}

class VendorPackage extends StatelessWidget {
  final VendorPackageDatum datum;

  const VendorPackage(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${datum.name}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${datum.description}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.18),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            "Know more",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
