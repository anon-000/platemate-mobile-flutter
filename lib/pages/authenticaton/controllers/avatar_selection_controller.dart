import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/authenticaton/preference_first/preferences_first_page.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';

import '../../../widgets/app_buttons/app_primary_button.dart';
import '../../../widgets/photo_chooser.dart';

///
/// Created by Auro on 04/03/23 at 12:26 AM
///

class AvatarSelectionController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  File? image;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void chooseImages() async {
    final result = await Get.bottomSheet(
      PhotoChooser(),
      backgroundColor: Color(0xffffffff),
    );

    if (result != null) {
      image = result;
      update();
    }
  }

  removeImage() {
    image = null;
    update();
  }

  void proceed() async {
    if (image == null) {
      SnackBarHelper.show("Please select an avatar to proceed");
      return;
    }
    Get.toNamed(PreferencesFirstPage.routeName);
  }
}
