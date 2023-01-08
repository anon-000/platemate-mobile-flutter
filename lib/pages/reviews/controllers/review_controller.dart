import 'dart:developer';
import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 23/11/22 at 1:11 AM
///

class ReviewController extends GetxController
    with StateMixin<List<ReviewDatum>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.feedback,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': 'createdBy',
        },
      );
      final response = List<ReviewDatum>.from(
          result.data["data"].map((e) => ReviewDatum.fromJson(e)));
      log("$response");
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
          ApiRoutes.feedback,
          query: {
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
            '\$populate': 'createdBy',
          },
        );

        final response = List<ReviewDatum>.from(
            result.data["data"].map((e) => ReviewDatum.fromJson(e)));
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
