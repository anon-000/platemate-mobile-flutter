import 'dart:developer';

import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/app_configs/app_validators.dart';
import 'package:event_admin/app_configs/environment.dart';
import 'package:event_admin/pages/authenticaton/controllers/city_selection_controller.dart';
import 'package:event_admin/utils/check_permissions.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/drop_plCEHOLDER.dart';
import 'package:event_admin/widgets/map_view.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

///
/// Created by Auro on 25/11/22 at 11:49 PM
///

class VenueSelectionPage extends StatefulWidget {
  final String? address;
  final String? city;
  final LatLng? coordinates;

  const VenueSelectionPage(
      {Key? key, this.address, this.coordinates, this.city})
      : super(key: key);

  @override
  State<VenueSelectionPage> createState() => _VenueSelectionPageState();
}

class _VenueSelectionPageState extends State<VenueSelectionPage> {
  String address = '';
  String? city;
  LatLng? latLangData;
  CitySelectionController? controller;
  bool _loading = false;

  onAddressSaved(String? v) {
    address = v ?? '';
  }

  onCitySaved(String? v) {
    city = v ?? '';
  }

  Future<void> _checkPermission() async {
    final serviceStatus = await ph.Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ph.ServiceStatus.enabled;
    if (!isGpsOn) {
      throw ('Turn on location services before requesting permission.');
      //return;
    }

    final status = await ph.Permission.locationWhenInUse.request();
    if (status == ph.PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == ph.PermissionStatus.denied) {
      throw ('Permission denied.');
      // showSmartDialog(
      //     title:
      //         "Location permissions are denied. Go to settings and permit us to get your location.",
      //     positiveText: "Open settings",
      //     negativeText: "Cancel",
      //     positiveCallback: () async {
      //       await ph.openAppSettings();
      //     });
    } else if (status == ph.PermissionStatus.permanentlyDenied) {
      //throw('Take the user to the settings page.');

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

  getCurrentLocation() async {
    try {
      setState(() {
        _loading = true;
      });
      await _checkPermission();

      final tempData = await CheckPermissions.getCurrentLocation();
      log("Current Location ::: $tempData");
      latLangData = LatLng(tempData.latitude, tempData.longitude);
      setState(() {
        _loading = false;
      });
    } catch (err) {
      setState(() {
        _loading = false;
      });
      log("CURRENT LOCATION GET ERROR ::: $err");
      //SnackBarHelper.show("$err");
    }
  }

  void updatePosition(LatLng _position) {
    latLangData = LatLng(_position.latitude, _position.longitude);
    log("-----${_position}");
    setState(() {});

    // LatLng newMarkerPosition =
    //     LatLng(_position.target.latitude, _position.target.longitude);
    // Marker marker = markers["1"];
    //
    // markers["1"] = marker.copyWith(
    //     positionParam:
    //         LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
  }

  saveData() {
    city = widget.city;
    log("saveDta ; ${widget.coordinates}");
    if (widget.coordinates != null) {
      latLangData = widget.coordinates;
    } else {
      getCurrentLocation();
    }
  }

  @override
  void initState() {
    super.initState();
    saveData();
    controller = Get.isRegistered<CitySelectionController>()
        ? Get.find<CitySelectionController>()
        : Get.put(CitySelectionController());
    if (controller!.state == null) {
      controller!.getCities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: Color(0xff0A061D),
              child: MyBackground(),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text("Select your venue"),
                ),
                Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      // const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: widget.address,
                          onChanged: onAddressSaved,
                          onSaved: onAddressSaved,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (data) =>
                              AppFormValidators.validateEmpty(data, context),
                          decoration:
                              AppDecorations.textFieldDecoration_2(context)
                                  .copyWith(
                                      hintText:
                                          "Enter the address of your event"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "City",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: controller!.obx(
                          (state) {
                            if (state != null) {
                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                decoration:
                                    AppDecorations.textFieldDecoration(context),
                                disabledHint: Text(
                                  "Select city",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                hint: Text("Select city"),
                                elevation: 2,
                                items: state
                                    .map((e) => DropdownMenuItem(
                                        value: e.id, child: Text(e.name!)))
                                    .toList(),
                                value: city,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: onCitySaved,
                                onChanged: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  onCitySaved(v);
                                },
                              );
                            }
                            return DropDownPlaceholder("Select city");
                          },
                          onEmpty: DropDownPlaceholder("Select city"),
                          onLoading: DropDownPlaceholder("Select city"),
                          onError: (e) => DropDownPlaceholder("Select city"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Pin your location",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 400,
                            child: _loading
                                ? Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : MyMapView(
                                    onPositionChanged: updatePosition,
                                    address: {
                                      "latitudes": latLangData == null
                                          ? Environment.defaultCoordinates[0]
                                          : latLangData!.latitude,
                                      "longitude": latLangData == null
                                          ? Environment.defaultCoordinates[1]
                                          : latLangData!.longitude,
                                    },
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: SizedBox(
                      //     width: double.infinity,
                      //     child: AppPrimaryButton(
                      //       child: Text(
                      //         "Save",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         Get.back(
                      //           result: {
                      //             "address": address,
                      //             "city": city,
                      //             "coordinates": latLangData,
                      //           },
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppPrimaryButton(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.back(
                          result: {
                            "address": address,
                            "city": city,
                            "coordinates": latLangData,
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
