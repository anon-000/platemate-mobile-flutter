import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/booking_distribution.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 28/11/22 at 2:20 AM
///

class BookingDistributionController extends GetxController
    with StateMixin<List<BookingDistribution>> {
  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.post(
        ApiRoutes.booking_distribution,
      );
      final response = List<BookingDistribution>.from(
        result.data.map((e) => BookingDistribution.fromJson(e)),
      );
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
