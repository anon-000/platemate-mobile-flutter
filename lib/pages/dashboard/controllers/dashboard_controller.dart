import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/stats_datum.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardController extends GetxController with StateMixin<StatsDatum> {
  void getData() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.post(
        ApiRoutes.statistics,
      );
      log("$result");
      final response = StatsDatum.fromJson(result.data);
      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
