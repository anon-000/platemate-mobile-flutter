import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/post_datum.dart';
import 'package:event_admin/pages/events/controllers/comments_controller.dart';
import 'package:event_admin/pages/events/controllers/posts_controller.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 30/12/22 at 9:06 AM
///

class PostDetailsController extends GetxController with StateMixin<PostDatum> {
  String postId = '';
  String eventId = '';
  late CommentsController commentController;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    postId = args['postId'] ?? "";
    eventId = args['eventId'] ?? "";
    commentController = Get.isRegistered<CommentsController>()
        ? Get.find<CommentsController>()
        : Get.put(CommentsController());
    commentController.saveId(postId);
    commentController.getData();
  }

  updateCommentCount([bool value = true]) {
    PostDatum tempDatum = state!;
    if (value) {
      tempDatum.commentCount = tempDatum.commentCount! + 1;
    } else {
      tempDatum.commentCount = tempDatum.commentCount! - 1;
    }
    change(tempDatum, status: RxStatus.success());
  }

  likeAPost({LikeDatum? likeDatum}) async {
    PostDatum tempDatum = state!;

    if (likeDatum == null) {
      /// like
      tempDatum.likeData = LikeDatum(
        id: "${DateTime.now().microsecondsSinceEpoch}",
      );
      tempDatum.likeCount = tempDatum.likeCount! + 1;
    } else {
      /// unlike
      tempDatum.likeData = null;
      tempDatum.likeCount = tempDatum.likeCount! - 1;
    }
    change(tempDatum, status: RxStatus.success());

    try {
      if (likeDatum == null) {
        final res = await ApiCall.post(
          ApiRoutes.like,
          body: {
            "entityType": "post",
            "entityId": "${tempDatum.id}",
          },
        );
        final resp = LikeDatum.fromJson(res.data);
        tempDatum.likeData = resp;
        change(tempDatum, status: RxStatus.success());
      } else {
        await ApiCall.delete(ApiRoutes.like, id: likeDatum.id!);
      }
      if (Get.isRegistered<PostsController>()) {
        final pController = Get.find<PostsController>();
        pController.getData();
      }
    } catch (err, s) {
      log("$err : $s");
      if (likeDatum == null) {
        tempDatum.likeData = null;
        tempDatum.likeCount = tempDatum.likeCount! - 1;
      } else {
        tempDatum.likeData = likeDatum;
        tempDatum.likeCount = tempDatum.likeCount! + 1;
      }
      change(tempDatum, status: RxStatus.success());
      SnackBarHelper.show("$err");
    }
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(
        ApiRoutes.posts,
        id: postId,
        query: {
          "event": eventId,
        },
      );
      final response = PostDatum.fromJson(result.data);

      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e :: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
