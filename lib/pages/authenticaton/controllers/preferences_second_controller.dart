import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 04/03/23 at 1:13 AM
///

class PreferencesSecondController extends GetxController {
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  List<String> preferenceList = [
    'Punjabi',
    'Rajasthani',
    'North Indian',
    'Mughlai',
    'Kashmiri',
    'Indo-Chinese',
    'Turkish',
    'Japanese',
    'Italian',
  ];

  List<String> selectedFoodTypes = [];
  bool sweetTooth = false;
  double? oilLevel, spicyLevel;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  updateSweetTooth() {
    sweetTooth = !sweetTooth;
    update();
  }

  updateOilLevel(double v) {
    oilLevel = v;
    update();
  }

  updateSpicyLevel(double v) {
    spicyLevel = v;
    update();
  }

  selectFoodTypes(String value) {
    if (selectedFoodTypes.contains(value)) {
      selectedFoodTypes.remove(value);
    } else {
      selectedFoodTypes.add(value);
    }
    update();
  }

  void proceed() async {
    Get.offAllNamed(DashboardPage.routeName);
  }
}
