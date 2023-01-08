import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/event_vendor.dart';
import 'package:event_admin/pages/vendors/vendor_details/controllers/vendor_packages_controller.dart';
import 'package:event_admin/pages/vendors/vendor_details/controllers/vendor_ratings_controller.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 01/12/22 at 10:24 PM
///

class VendorDetailsController extends GetxController
    with StateMixin<VendorDatum> {
  String vendorId = "";
  late VendorPackagesController vendorPackagesController;
  late VendorRatingsController vendorRatingsController;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> map = Get.arguments ?? {};
    vendorId = map["vendorId"] ?? '';
    vendorPackagesController = Get.isRegistered<VendorPackagesController>()
        ? Get.find<VendorPackagesController>()
        : Get.put(VendorPackagesController());
    vendorRatingsController = Get.isRegistered<VendorRatingsController>()
        ? Get.find<VendorRatingsController>()
        : Get.put(VendorRatingsController());
  }

  void getDetails() async {
    try {
      change(null, status: RxStatus.loading());
      Map<String, dynamic> query = {
        "\$populate": [
          "address.city",
          "languages",
        ],
      };
      final result = await ApiCall.get(
        ApiRoutes.vendors,
        query: query,
        id: vendorId,
      );
      final response = VendorDatum.fromJson(result.data);
      change(response, status: RxStatus.success());
      getAllPackagesAndRatings();
    } catch (e, s) {
      log("$e :: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  getAllPackagesAndRatings() {
    vendorPackagesController.saveVendorId(state!.id!);
    vendorPackagesController.getData();
    vendorRatingsController.saveVendorId(state!.id!);
    vendorRatingsController.getData();
  }
}
