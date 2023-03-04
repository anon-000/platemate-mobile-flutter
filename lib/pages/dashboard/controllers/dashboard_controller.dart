import 'dart:developer';

import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/data_models/stats_datum.dart';
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
      final response = StatsDatum.fromJson(result.data);
      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
