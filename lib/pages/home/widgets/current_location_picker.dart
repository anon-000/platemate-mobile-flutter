///
/// Created by Auro on 27/12/22 at 6:11 AM
///

import 'dart:developer';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:event_admin/app_configs/environment.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/utils/check_permissions.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:collection/collection.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

///
/// Created by Auro on 27/12/22 at 6:08 AM
///

class CurrentLocationPicker extends StatelessWidget {
  const CurrentLocationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentLocationNotifier,
      builder: (c, v, _) => GestureDetector(
        onTap: setCurrentLocation,
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentLocationNotifier.value.isEmpty
                  ? "Select your city"
                  : "${SharedPreferenceHelper.city}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _checkLocationPermission() async {
  final serviceStatus = await ph.Permission.locationWhenInUse.serviceStatus;
  final isGpsOn = serviceStatus == ph.ServiceStatus.enabled;
  if (!isGpsOn) {
    print('Turn on location services before requesting permission.');
    return;
  }

  final status = await ph.Permission.locationWhenInUse.request();
  if (status == ph.PermissionStatus.granted) {
    print('Permission granted');
  } else if (status == ph.PermissionStatus.denied) {
    print('Permission denied. Show a dialog and again ask for the permission');
  } else if (status == ph.PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');

    showEventDialog(
        title:
            "Location permissions are denied. Go to settings and permit us to get your location.",
        positiveText: "Open settings",
        negativeText: "Cancel",
        positiveCallback: () async {
          await ph.openAppSettings();
        });
  }
}

setCurrentLocation() async {
  try {
    final _geocoding = GoogleMapsGeocoding(apiKey: Environment.mapApiKey);

    await _checkLocationPermission();

    final Position data = await CheckPermissions.getCurrentLocation();
    log("Step 1 :====: ${data}");

    final geocodingResult = await _geocoding
        .searchByLocation(Location(lat: data.latitude, lng: data.longitude));

    log("${geocodingResult.results}");
    log("${geocodingResult.errorMessage}");

    final value = geocodingResult.results[0];

    if (value.addressComponents.isNotEmpty) {
      /// --------------------------------- House no
      String _houseNo = "";

      try {
        _houseNo = value.addressComponents
            .firstWhere((element) =>
                ListEquality().equals(element.types, ["street_number"]))
            .longName;
      } catch (err) {}
      //
      // /// --------------------------------- Land mark
      // String _landMark = "";
      // try {
      //   _landMark = value.addressComponents
      //       .firstWhere((element) =>
      //           ListEquality().equals(element.types, ["route"]))
      //       .longName;
      // } catch (err) {}

      /// --------------------------------- Area
      String _area = "";

      try {
        _area = value.addressComponents
            .firstWhere((element) => ListEquality().equals(element.types,
                ["political", "sublocality", "sublocality_level_1"]))
            .longName;
      } catch (err) {}

      /// --------------------------------- City
      String _city = "";

      try {
        _city = value.addressComponents
            .firstWhere((element) =>
                ListEquality().equals(element.types, ["locality", "political"]))
            .longName;
      } catch (err) {}

      /// --------------------------------- State
      String _state = "";

      try {
        _state = value.addressComponents
            .firstWhere((element) => ListEquality().equals(
                element.types, ["administrative_area_level_1", "political"]))
            .longName;
      } catch (err) {}

      String address =
          "${_houseNo.isEmpty ? "" : "$_houseNo, "}${_area.isEmpty ? "" : "$_area, "}${_city.isEmpty ? "" : "$_city, "}${_state.isEmpty ? "" : "$_state. "}";

      log(address);
      currentLocationNotifier.value = _city;
      SharedPreferenceHelper.storeCity(_city);
      SnackBarHelper.show("Current location updated");
    }
  } catch (err, s) {
    log("$err  $s");
    //SnackBarHelper.show("$err");
  }
}
