import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/vendor_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 02/12/22 at 12:01 AM
///

class VendorRatingsController extends GetxController
    with StateMixin<List<VendorRating>> {
  int skip = 0, limit = 10, total = 0;
  bool shouldLoadMore = true;
  String vendorId = '';
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreData();
      }
    });
  }

  saveVendorId(String v) {
    vendorId = v;
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.vendor_ratings,
        query: {
          "entityId": vendorId,
          "status": 1,
          '\$sort[createdAt]': -1,
          '\$populate': 'createdBy',
        },
      );

      final response = List<VendorRating>.from(
          result.data["data"].map((e) => VendorRating.fromJson(e)));
      if (response.length < limit) {
        shouldLoadMore = false;
      }
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("$e $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void getMoreData() async {
    if (shouldLoadMore && !status.isLoadingMore) {
      skip = state!.length;
      try {
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(
          ApiRoutes.vendor_ratings,
          query: {
            "entityId": vendorId,
            "status": 1,
            '\$sort[createdAt]': -1,
            '\$populate': 'createdBy',
          },
        );

        final response = List<VendorRating>.from(
            result.data["data"].map((e) => VendorRating.fromJson(e)));
        if (response.length < limit) {
          shouldLoadMore = false;
        }
        change((state ?? []) + response, status: RxStatus.success());
      } catch (e) {
        change(null, status: RxStatus.error(e.toString()));
      }
    }
  }
}
