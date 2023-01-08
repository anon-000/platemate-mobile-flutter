import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/event_vendor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 28/11/22 at 1:47 AM
///

class EventVendorsController extends GetxController
    with StateMixin<List<EventVendor>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  String eventId = '';
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    eventId = args["eventId"] ?? '';
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreData();
      }
    });
  }

  saveEventId(String v) {
    eventId = v;
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.event_vendor,
        query: {
          '\$sort[createdAt]': -1,
          "event": eventId,
        },
      );

      final response = List<EventVendor>.from(
          result.data["data"].map((e) => EventVendor.fromJson(e)));
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
          ApiRoutes.event_vendor,
          query: {
            '\$sort[createdAt]': -1,
            "event": eventId,
          },
        );

        final response = List<EventVendor>.from(
            result.data["data"].map((e) => EventVendor.fromJson(e)));
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
