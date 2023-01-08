import 'dart:developer';
import 'dart:io';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/pages/events/controllers/create_event_controller.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/photo_chooser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/10/22 at 8:04 PM
///

class AddPostController extends GetxController {
  String title = '';
  String desc = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  FocusNode descNode = FocusNode(debugLabel: 'desc');
  List<dynamic> imageList = [];
  int maxImageCount = 10;
  String? titleErr, imageErr;
  String eventId = '';
  bool actionLoading = false;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  saveEventId(String v) {
    eventId = v;
  }

  void onTitleSaved(String? newValue) {
    title = newValue!.trim();
  }

  void onDescriptionSaved(String? newValue) {
    desc = newValue!.trim();
  }

  void chooseImages() async {
    final result = await Get.bottomSheet(
      PhotoChooser(),
      backgroundColor: Color(0xff0A061D),
    );

    if (result != null) {
      imageList.add(result);
      update();
    }

    // FilePicker.platform
    //     .pickFiles(type: FileType.image, allowMultiple: true)
    //     .then((value) {
    //   List<File> images = [];
    //   if (value!.paths.length > maxImageCount) {
    //     SnackBarHelper.show(
    //         'You can choose at most $maxImageCount prescriptions.');
    //     images =
    //         value.paths.sublist(0, maxImageCount).map((e) => File(e!)).toList();
    //   } else {
    //     images = value.paths.map((e) => File(e!)).toList();
    //   }
    //   images.forEach((element) async {
    //     if (!imageList.contains(element)) {
    //       imageList.add(element);
    //     }
    //   });
    //   update();
    // }).catchError((err) {});
  }

  onRemoveImage(int r) {
    imageList.removeAt(r);
    update();
  }

  void proceed() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
      update();
    } else {
      state.save();

      try {
        /// name error
        if (title.isEmpty) {
          titleErr = "Name is required";
          update();
          throw titleErr!;
        }
        titleErr = null;
        update();

        // /// image error
        // if (imageList.isEmpty) {
        //   imageErr = "Images are required";
        //   update();
        //   throw imageErr!;
        // }
        // imageErr = null;
        // update();

        List<String> urls = [];

        // buttonKey.currentState!.showLoader();
        actionLoading = true;
        update();

        if (imageList.isNotEmpty) {
          ///
          urls = await ApiCall.multiFileUpload(
                  List<File>.from(imageList.map((e) => e).toList())) ??
              [];
        }

        Map<String, dynamic> body = {
          "title": title,
          "description": desc ?? "",
          "image": urls,
          "event": eventId,
        };

        await ApiCall.post(ApiRoutes.posts, body: body);
        // buttonKey.currentState!.hideLoader();
        actionLoading = false;
        update();
        SnackBarHelper.show("Post uploaded successfully");

        /// to clear the form
        formKey.currentState!.reset();
        imageList.clear();
        Get.focusScope!.unfocus();
        update();

        if (Get.isRegistered<CreateEventController>()) {
          final createController = Get.find<CreateEventController>();
          createController.postsController.getData();
          // createController.onFeedTypeUpdate(1);
        }
      } catch (err, s) {
        log("$err :: $s");
        // buttonKey.currentState?.hideLoader();
        actionLoading = false;
        update();
        SnackBarHelper.show("$err");
      }
    }
  }
}
