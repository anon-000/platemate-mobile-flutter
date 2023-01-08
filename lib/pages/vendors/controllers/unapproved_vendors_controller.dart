///
/// Created by Auro on 05/01/23 at 9:42 PM
///

import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/event_vendor.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnApprovedVendorsController extends GetxController
    with StateMixin<List<VendorDatum>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
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

  /// 1-approve, 3-reject
  handleAcceptRejectOfRequest(VendorDatum v, {int status = 1}) async {
    final tempList = state ?? [];
    int index = tempList.indexWhere((element) => element.id == v.id);
    tempList.removeAt(index);
    change(tempList, status: RxStatus.success());

    try {
      await ApiCall.patch(
        ApiRoutes.vendors,
        id: v.id!,
        body: {
          'status': status,
        },
      );
      SnackBarHelper.show(
        status == 1 ? "Vendor is accepted" : "Vendor is rejected",
      );
      // tempList.removeAt(index);
      // change(tempList, status: RxStatus.success());
    } catch (err) {
      SnackBarHelper.show("$err");
      tempList.insert(index, v);
      change(tempList, status: RxStatus.success());
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.vendors,
        query: {
          '\$sort[createdAt]': -1,
          '\$populate': "user",
          'status': 2,
        },
      );

      final response = List<VendorDatum>.from(
          result.data["data"].map((e) => VendorDatum.fromJson(e)));
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
          ApiRoutes.vendors,
          query: {
            '\$sort[createdAt]': -1,
            '\$populate': "user",
            'status': 2,
          },
        );

        final response = List<VendorDatum>.from(
            result.data["data"].map((e) => VendorDatum.fromJson(e)));
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
