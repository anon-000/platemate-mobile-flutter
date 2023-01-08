import 'dart:developer';
import 'dart:io';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/gallery_datum.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 23/11/22 at 8:42 PM
///

class GalleryController extends GetxController
    with StateMixin<List<GalleryDatum>> {
  int skip = 0, limit = 10, total = 0;
  bool shouldLoadMore = true;
  String eventId = '';
  final ScrollController scrollController = ScrollController();
  bool buttonLoading = false;
  int maxImageCount = 10;

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

  void chooseImages() async {
    try {
      final imageList = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);

      if (imageList == null) {
        return;
      }

      buttonLoading = true;
      update();
      List<File> tempImages = [];
      if (imageList.paths.length > maxImageCount) {
        SnackBarHelper.show(
            'You can choose at most $maxImageCount images at a time.');
        tempImages = imageList.paths
            .sublist(0, maxImageCount)
            .map((e) => File(e!))
            .toList();
      } else {
        tempImages = imageList.paths.map((e) => File(e!)).toList();
      }

      final uploadResult = await ApiCall.multiFileUploadForGallery(tempImages);

      log("UPLOAD RESULT :: $uploadResult");

      Map<String, dynamic> body = {
        "event": eventId,
        "feeds": uploadResult!
            .map((e) => {
                  "image": e["link"],
                  "thumbnailImage": e["thumbnailLink"],
                })
            .toList(),
      };

      final galleryResult = await ApiCall.post(ApiRoutes.gallery, body: body);
      log("$galleryResult");
      SnackBarHelper.show("Photos uploaded successfully");

      final formattedList = List<GalleryDatum>.from(
          galleryResult.data.map((e) => GalleryDatum.fromJson(e)));

      change(state! + formattedList, status: RxStatus.success());

      buttonLoading = false;
      update();
    } catch (e, s) {
      buttonLoading = false;
      update();
      log("$e :: $s");
      SnackBarHelper.show("$e");
    }
  }

  void getData() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.gallery,
        query: {
          "event": eventId,
          "status": 1,
          '\$sort[createdAt]': -1,
        },
      );

      final response = List<GalleryDatum>.from(
          result.data["data"].map((e) => GalleryDatum.fromJson(e)));
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
          ApiRoutes.gallery,
          query: {
            "event": eventId,
            "status": 1,
            '\$sort[createdAt]': -1,
          },
        );

        final response = List<GalleryDatum>.from(
            result.data["data"].map((e) => GalleryDatum.fromJson(e)));
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
