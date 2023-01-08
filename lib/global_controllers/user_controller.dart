import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/user.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class UserController extends GetxController with StateMixin<User> {
  @override
  void onInit() {
    super.onInit();

    final user = SharedPreferenceHelper.user?.user;
    change(user, status: user == null ? RxStatus.empty() : RxStatus.success());
  }

  updateUser(User? user) {
    final u = SharedPreferenceHelper.user;
    if (u != null) {
      u.user = user;
      SharedPreferenceHelper.storeUser(user: u);
    }
    change(null, status: RxStatus.loading());
    change(user, status: RxStatus.success());
  }

  refreshUser() async {
    if (SharedPreferenceHelper.user == null) return;
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(
        ApiRoutes.user,
        id: SharedPreferenceHelper.user!.user!.id,
      );
      final updatedData = User.fromJson(result.data);
      // updateUser(updatedData);
      change(updatedData, status: RxStatus.success());
    } catch (e, s) {
      SnackBarHelper.show(e.toString());
      log("refreshUser", error: e, stackTrace: s);
    }
  }
}
