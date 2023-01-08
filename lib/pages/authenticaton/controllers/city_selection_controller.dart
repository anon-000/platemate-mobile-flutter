import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/city.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';

///
/// Created by Auro on 18/01/22 at 7:01 pm
///

class CitySelectionController extends GetxController
    with StateMixin<List<City>> {
  Rx<City>? selectedCity;
  bool isChange = false;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    isChange = args["change"] ?? false;
  }

  onCitySelect(City c) {
    if (selectedCity != null && selectedCity!.value == c) {
      selectedCity = null;
    } else {
      selectedCity = Rx(c);
    }
    update();
  }

  void getCities() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(ApiRoutes.city, query: {
        '\$sort[createdAt]': -1,
        "\$limit": 40,
        "status": 1,
      });
      final response =
          List<City>.from(result.data['data'].map((e) => City.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      print("$e  : $s");
    }
  }

  initCity() {
    String city = SharedPreferenceHelper.city;
    if (city.isNotEmpty) {
      selectedCity = Rx(City(name: "$city"));
    }
  }

  onCitySaved() {
    if (selectedCity == null) {
      SnackBarHelper.show("Select a city to proceed");
      return;
    }

    SharedPreferenceHelper.storeCity(selectedCity!.value.name!);
    currentLocationNotifier.value = selectedCity!.value.name!;
    SnackBarHelper.show("Location updated successfully");
    Get.back();
  }
}
