import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/post_datum.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 23/11/22 at 8:42 PM
///

class PostsController extends GetxController with StateMixin<List<PostDatum>> {
  int skip = 0, limit = 10, total = 0;
  bool shouldLoadMore = true;

  String eventId = '';
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

  saveEventId(String v) {
    eventId = v;
  }

  likeAPost(PostDatum d, {LikeDatum? likeDatum}) async {
    List<PostDatum> tempList = state ?? [];

    int index = tempList.indexWhere((element) => element.id == d.id);

    if (index != -1) {
      if (likeDatum == null) {
        /// like
        tempList[index].likeData = LikeDatum(
          id: "${DateTime.now().microsecondsSinceEpoch}",
        );
        tempList[index].likeCount = tempList[index].likeCount! + 1;
      } else {
        /// unlike
        tempList[index].likeData = null;
        tempList[index].likeCount = tempList[index].likeCount! - 1;
      }
      change(tempList, status: RxStatus.success());
    }

    try {
      if (likeDatum == null) {
        final res = await ApiCall.post(
          ApiRoutes.like,
          body: {
            "entityType": "post",
            "entityId": "${d.id}",
          },
        );
        final resp = LikeDatum.fromJson(res.data);
        tempList[index].likeData = resp;
        change(tempList, status: RxStatus.success());
      } else {
        await ApiCall.delete(ApiRoutes.like, id: likeDatum.id!);
      }
    } catch (err, s) {
      log("$err : $s");
      if (likeDatum == null) {
        tempList[index].likeData = null;
        tempList[index].likeCount = tempList[index].likeCount! - 1;
      } else {
        tempList[index].likeData = likeDatum;
        tempList[index].likeCount = tempList[index].likeCount! + 1;
      }
      change(tempList, status: RxStatus.success());
      SnackBarHelper.show("$err");
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.posts,
        query: {
          "event": eventId,
          "status": 1,
          '\$sort[createdAt]': -1,
        },
      );

      final response = List<PostDatum>.from(
          result.data["data"].map((e) => PostDatum.fromJson(e)));
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
          ApiRoutes.posts,
          query: {
            "event": eventId,
            "status": 1,
            '\$sort[createdAt]': -1,
          },
        );

        final response = List<PostDatum>.from(
            result.data["data"].map((e) => PostDatum.fromJson(e)));
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
