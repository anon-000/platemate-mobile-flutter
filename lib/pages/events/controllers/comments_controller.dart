import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/comment.dart';
import 'package:event_admin/pages/events/controllers/posts_controller.dart';
import 'package:event_admin/pages/posts/controllers/post_details_controller.dart';
import 'package:event_admin/pages/posts/posts_details_page.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 30/12/22 at 2:04 AM
///

class CommentsController extends GetxController
    with StateMixin<List<CommentDatum>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  String postId = '';

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

  saveId(String c) {
    postId = c;
  }

  addComment() async {
    if (textEditingController.text.isEmpty) return;
    String data = "${textEditingController.text}";

    List<CommentDatum> tempList = state ?? [];
    tempList.insert(
      0,
      CommentDatum(
        description: data,
        createdAt: DateTime.now(),
        user: SharedPreferenceHelper.user!.user,
      ),
    );
    change(tempList, status: RxStatus.success());
    textEditingController.clear();

    try {
      await ApiCall.post(
        ApiRoutes.comments,
        body: {
          "post": "$postId",
          'description': data,
        },
      );
      if (Get.isRegistered<PostsController>()) {
        final pController = Get.find<PostsController>();
        pController.getData();
      }
      if (Get.isRegistered<PostDetailsController>()) {
        final pController = Get.find<PostDetailsController>();
        pController.updateCommentCount();
      }
    } catch (err, s) {
      log("$err : $s");
      textEditingController.text = data;
      tempList.removeAt(0);
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
        ApiRoutes.comments,
        query: {
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': ['user'],
          'post': postId,
        },
      );

      final response = List<CommentDatum>.from(
          result.data["data"].map((e) => CommentDatum.fromJson(e)));
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
          ApiRoutes.comments,
          query: {
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
            '\$populate': ['user'],
            'post': postId,
          },
        );

        final response = List<CommentDatum>.from(
            result.data["data"].map((e) => CommentDatum.fromJson(e)));
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
