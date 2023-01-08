import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/support_ticket.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 09/12/22 at 9:00 PM
///

class AllConversationController extends GetxController
    with StateMixin<List<SupportTicket>> {
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

  resolveTicket(SupportTicket v) async {
    final tempList = state ?? [];
    int prevStatus = v.status!;
    int index = tempList.indexWhere((element) => element.id == v.id);
    tempList[index].status = 3;
    change(tempList, status: RxStatus.success());

    try {
      await ApiCall.patch(
        ApiRoutes.support_ticket,
        id: v.id,
        body: {
          'status': 3,
        },
      );
      SnackBarHelper.show("Event is cancelled");
      // tempList.removeAt(index);
      // change(tempList, status: RxStatus.success());
    } catch (err) {
      SnackBarHelper.show("$err");
      tempList[index].status = prevStatus;
      change(tempList, status: RxStatus.success());
    }
  }

  magicApiCall() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      final result = await ApiCall.get(
        ApiRoutes.support_ticket,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': [
            'event',
            'user',
          ],
        },
      );

      final response = List<SupportTicket>.from(
          result.data["data"].map((e) => SupportTicket.fromJson(e)));
      if (response.length < limit) {
        shouldLoadMore = false;
      }
      change(response, status: RxStatus.success());
    } catch (e, s) {}
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.support_ticket,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': [
            'event',
            'user',
          ],
        },
      );

      final response = List<SupportTicket>.from(
          result.data["data"].map((e) => SupportTicket.fromJson(e)));
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
          ApiRoutes.support_ticket,
          query: {
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
            '\$populate': [
              'event',
              'user',
            ],
          },
        );

        final response = List<SupportTicket>.from(
            result.data["data"].map((e) => SupportTicket.fromJson(e)));
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
