import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 08/12/22 at 12:22 PM
///

class FeedbackController extends GetxController {
  int type = 1;
  String desc = '';
  double? rating;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  onDescSaved(String? v) {
    desc = v ?? '';
  }

  onTypeSaved(int? c) {
    type = c ?? 1;
    update();
    Get.focusScope!.unfocus();
  }

  onRatingSaved(double v) {
    rating = v;
  }

  proceed() async {
    try {
      if (desc.isEmpty) {
        SnackBarHelper.show("Description is required.");
        return;
      }
      buttonKey.currentState!.showLoader();
      await ApiCall.post(
        ApiRoutes.feedback,
        body: {
          "rating": rating,
          "type": type,
          "description": desc,
        },
      );
      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show(
        "Thanks for your valuable feedback. We'll work on it",
      );
      Get.back();
    } catch (err, s) {
      buttonKey.currentState!.hideLoader();
      log("$err :: $s");
      SnackBarHelper.show("$err");
    }
  }
}
