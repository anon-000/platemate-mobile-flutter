import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 26/04/23 at 4:49 PM
///

class CheckOutController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  String remarks = '';

  onRemarksSaved(String? v) {
    remarks = v ?? '';
  }



}
