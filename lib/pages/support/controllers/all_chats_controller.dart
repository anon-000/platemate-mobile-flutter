import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/support_chat.dart';
import 'package:event_admin/data_models/support_ticket.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/photo_chooser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 09/12/22 at 9:00 PM
///

class AllChatsController extends GetxController
    with StateMixin<List<SupportChat>> {
  int skip = 0, limit = 20, total = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();
  SupportTicket? datum;
  TextEditingController textController = TextEditingController();
  bool attachmentLoading = false;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    datum = args["datum"] ?? SupportTicket(id: 'id');
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreData();
      }
    });
  }

  addDatum(SupportChat d) {
    List<SupportChat> tempList = state ?? [];
    tempList.insert(0, d);
    change(tempList, status: RxStatus.success());
  }

  ///attachment type-1 : image link : url

  sendMessage() async {
    if (textController.text.isEmpty) return;

    List<SupportChat> tempList = state ?? [];

    SupportChat tempDatum = SupportChat(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      message: "${textController.text}",
      createdBy: SharedPreferenceHelper.user!.user,
    );

    tempList.insert(0, tempDatum);
    change(tempList, status: RxStatus.success());

    try {
      final result = await ApiCall.post(
        ApiRoutes.support_chat,
        body: {
          "supportTicket": datum!.id,
          "message": textController.text,
        },
        query: {
          '\$populate': 'createdBy',
        },
      );
      textController.clear();
      final temp = SupportChat.fromJson(result.data);
      tempList[0] = temp;
      change(tempList, status: RxStatus.success());
    } catch (err, s) {
      log("$err : $s");
      tempList.removeAt(0);
      change(tempList, status: RxStatus.success());
      SnackBarHelper.show("$err");
    }
  }

  sendAttachmentMessage(int type, String link) async {
    List<SupportChat> tempList = state ?? [];

    SupportChat tempDatum = SupportChat(
      id: "${DateTime.now().microsecondsSinceEpoch}",
      attachment: Attachment(type: type, link: link),
      createdBy: SharedPreferenceHelper.user!.user,
    );

    tempList.insert(0, tempDatum);
    change(tempList, status: RxStatus.success());

    /// hide loader
    attachmentLoading = false;
    update();

    try {
      final result = await ApiCall.post(
        ApiRoutes.support_chat,
        body: {
          "supportTicket": datum!.id,
          "attachment": {
            "type": type,
            "link": link,
          },
        },
        query: {
          '\$populate': 'createdBy',
        },
      );
      textController.clear();
      final temp = SupportChat.fromJson(result.data);
      tempList[0] = temp;
      change(tempList, status: RxStatus.success());
    } catch (err, s) {
      /// hide loader
      attachmentLoading = false;
      log("$err : $s");
      tempList.removeAt(0);
      change(tempList, status: RxStatus.success());
      SnackBarHelper.show("$err");
    }
  }

  handleChooseAndSendImage() async {
    try {
      Get.focusScope!.unfocus();
      final result = await Get.bottomSheet(
        PhotoChooser(),
        backgroundColor: Color(0xff0A061D),
      );

      if (result != null) {
        /// hide loader
        attachmentLoading = true;
        update();
        final res = await ApiCall.singleFileUpload(result) ?? "";
        sendAttachmentMessage(1, res);
      }
    } catch (err) {
      /// hide loader
      attachmentLoading = false;
      update();
      log("$err");
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.support_chat,
        query: {
          "supportTicket": datum!.id,
          '\$sort[createdAt]': -1,
          '\$skip': skip,
          '\$limit': limit,
          '\$populate': ['createdBy']
        },
      );

      final response = List<SupportChat>.from(
          result.data["data"].map((e) => SupportChat.fromJson(e)));
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
          ApiRoutes.support_chat,
          query: {
            "supportTicket": datum!.id,
            '\$sort[createdAt]': -1,
            '\$skip': skip,
            '\$limit': limit,
            '\$populate': ['createdBy']
          },
        );

        final response = List<SupportChat>.from(
            result.data["data"].map((e) => SupportChat.fromJson(e)));
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
