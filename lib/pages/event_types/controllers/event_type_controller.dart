import 'dart:developer';
import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 23/11/22 at 1:11 AM
///

class EventTypeController extends GetxController
    with StateMixin<List<EventType>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  updateEventType(EventType v) async {
    final tempList = state ?? [];
    int index = tempList.indexWhere((element) => element.id == v.id);

    if (index != -1) {
      tempList[index] = v;
      change(tempList, status: RxStatus.success());
    }
  }

  removeEventType(EventType v) async {
    final tempList = state ?? [];
    int index = tempList.indexWhere((element) => element.id == v.id);
    tempList[index].loading = true;
    change(tempList, status: RxStatus.success());

    try {
      await ApiCall.delete(ApiRoutes.me_events, id: v.id!);
      SnackBarHelper.show("Draft removed successfully");
      tempList.removeAt(index);
      change(tempList, status: RxStatus.success());
    } catch (err) {
      SnackBarHelper.show("$err");
      tempList[index].loading = false;
      change(tempList, status: RxStatus.success());
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.event_type,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
        },
      );
      final response = List<EventType>.from(
          result.data["data"].map((e) => EventType.fromJson(e)));
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
          ApiRoutes.event_type,
          query: {
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
          },
        );

        final response = List<EventType>.from(
            result.data["data"].map((e) => EventType.fromJson(e)));
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
