import 'dart:developer';
import 'dart:io';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/app_configs/environment.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/pages/events/controllers/gallery_controller.dart';
import 'package:event_admin/pages/events/controllers/posts_controller.dart';
import 'package:event_admin/pages/events/venue_selection_page.dart';
import 'package:event_admin/pages/home/controllers/my_event_controller.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

///
/// Created by Auro on 24/10/22 at 12:01 AM
///

class CreateEventController extends GetxController with StateMixin<EventDatum> {
  String title = '';
  String desc = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final GlobalKey<AppPrimaryButtonState> buttonKeySave =
      GlobalKey<AppPrimaryButtonState>(debugLabel: "SAVE_BUTTON");

  final GlobalKey<AppPrimaryButtonState> buttonKeyPublish =
      GlobalKey<AppPrimaryButtonState>(debugLabel: "PUBLISH_BUTTON");

  late Rx<AutovalidateMode> autoValidateMode;
  List<dynamic> imageList = [];
  int maxImageCount = 10;
  EventType? selectedEventType;

  /// Date & time
  DateTime? startDate, endDate;
  TimeOfDay? startTime, endTime;
  int dateType = 1;

  /// Address
  String addressLine1 = "";
  String? city;
  LatLng? coordinates;

  late PostsController postsController;
  late GalleryController galleryController;
  int feedType = 1;

  /// tyoee
  String eventId = '';

  /// loading
  bool actionLoading = false;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    postsController = Get.isRegistered<PostsController>()
        ? Get.find<PostsController>()
        : Get.put(PostsController());
    galleryController = Get.isRegistered<GalleryController>()
        ? Get.find<GalleryController>()
        : Get.put(GalleryController());
  }

  @override
  void dispose() {
    autoValidateMode.close();
    postsController.dispose();
    galleryController.dispose();
    super.dispose();
  }

  /// initialize data when u go to details page of created event
  initializeData(EventDatum datum) {
    titleController.text = datum.name ?? "";
    descController.text = datum.description ?? '';
    startTime = datum.startTime == null
        ? null
        : TimeOfDay(
            hour: datum.startTime!.hour,
            minute: datum.startTime!.minute,
          );
    endTime = datum.endTime == null
        ? null
        : TimeOfDay(
            hour: datum.endTime!.hour,
            minute: datum.endTime!.minute,
          );
    startDate = datum.startTime == null
        ? null
        : DateTime(
            datum.startTime!.year,
            datum.startTime!.month,
            datum.startTime!.day,
          );
    endDate = datum.endTime == null || datum.endTime!.year == null
        ? null
        : DateTime(
            datum.endTime!.year,
            datum.endTime!.month,
            datum.endTime!.day,
          );
    log("INIT DATE : $startDate : $endDate : $startTime : $endTime");

    /// even type
    selectedEventType = datum.eventType;

    /// imagelist
    imageList.addAll(datum.attachments ?? []);

    /// address
    addressLine1 = datum.address!.addressLine1 ?? '';
    city = datum.address!.city == null || datum.address!.city!.isEmpty
        ? null
        : datum.address!.city;

    coordinates = datum.address!.coordinates == null ||
            datum.address!.coordinates!.isEmpty
        ? null
        : LatLng(
            datum.address!.coordinates == null ||
                    datum.address!.coordinates!.isEmpty
                ? Environment.defaultCoordinates[0]
                : datum.address!.coordinates![0],
            datum.address!.coordinates == null ||
                    datum.address!.coordinates!.isEmpty
                ? Environment.defaultCoordinates[1]
                : datum.address!.coordinates![1],
          );
  }

  onEventTypeSelected(EventType v) {
    if (selectedEventType == null) {
      selectedEventType = v;
    } else {
      if (selectedEventType!.id == v.id) {
        selectedEventType = null;
      } else {
        selectedEventType = v;
      }
    }

    update();
  }

  onFeedTypeUpdate(int c) {
    feedType = c;
    update();
  }

  onEventIdSaved(String v) {
    eventId = v;
  }

  void onTitleSaved(String? newValue) {
    title = newValue!.trim();
  }

  void onDescriptionSaved(String? newValue) {
    desc = newValue!.trim();
  }

  void chooseImages() {
    FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true)
        .then((value) {
      List<File> images = [];
      if (value!.paths.length > maxImageCount) {
        SnackBarHelper.show(
            'You can choose at most $maxImageCount prescriptions.');
        images =
            value.paths.sublist(0, maxImageCount).map((e) => File(e!)).toList();
      } else {
        images = value.paths.map((e) => File(e!)).toList();
      }
      images.forEach((element) async {
        if (!imageList.contains(element)) {
          imageList.add(element);
        }
      });
      update();
    }).catchError((err) {});
  }

  onRemoveImage(int r) {
    imageList.removeAt(r);
    update();
  }

  handleVenueClick() async {
    log("===>>>$city");
    final result = await Get.to(
      VenueSelectionPage(
        address: addressLine1,
        city: city,
        coordinates: coordinates,
      ),
      // isDismissible: true,
      // isScrollControlled: true,
    );
    if (result != null) {
      addressLine1 = result["address"];
      city = result["city"];
      coordinates = result["coordinates"];
      update();
    }
  }

  handleDateTime() async {

  }

  /// 1 - draft , 2 - publish
  saveData([int type = 1]) async {
    try {
      if (titleController.text.isEmpty && type == 2) {
        SnackBarHelper.show("Event title is required");
        return;
      }
      if (selectedEventType == null && type == 2) {
        SnackBarHelper.show("Event type is required");
        return;
      }

      /// handle date and time
      if ((startDate == null || startTime == null || endTime == null) &&
          type == 2) {
        SnackBarHelper.show("Date & time should be given properly");
        return;
      }

      bool dateTimeModified = startDate != null ||
          endDate != null ||
          startTime != null ||
          endTime != null;
      log(">>> $startDate : $endDate : $startTime : $endTime");

      /// final start
      DateTime finalStartTime = DateTime(
        startDate == null ? DateTime.now().year : startDate!.year,
        startDate == null ? DateTime.now().month : startDate!.month,
        startDate == null ? DateTime.now().day : startDate!.day,
        startTime == null ? DateTime.now().hour : startTime!.hour,
        startTime == null ? DateTime.now().minute : startTime!.minute,
      );

      /// final time
      DateTime finalEndTime = DateTime(
        endDate == null
            ? startDate == null
                ? DateTime.now().year
                : startDate!.year
            : endDate!.year,
        endDate == null
            ? startDate == null
                ? DateTime.now().month
                : startDate!.month
            : endDate!.month,
        endDate == null
            ? startDate == null
                ? DateTime.now().day
                : startDate!.day
            : endDate!.day,
        endTime == null ? DateTime.now().hour : endTime!.hour,
        endTime == null ? DateTime.now().minute : endTime!.minute,
      );

      log(">>> $finalStartTime :::: $finalEndTime");

      // if (type == 1) {
      //   buttonKeySave.currentState!.showLoader();
      // } else {
      //   buttonKeyPublish.currentState!.showLoader();
      // }

      // return;

      actionLoading = true;
      update();
      log("===> 2");

      /// handle images
      List<String>? urls = [];

      if (imageList.isNotEmpty) {
        /// if already exists
        final url_1 = imageList
            .where((element) => element is String)
            .cast<String>()
            .toList();

        final filesToBeUploaded = List<File>.from(
            imageList.where((element) => !(element is String)).toList());

        if (url_1.isEmpty && filesToBeUploaded.isEmpty && type == 2) {
          // image is required to publish
          // if (type == 1) {
          //   buttonKeySave.currentState!.hideLoader();
          // } else {
          //   buttonKeyPublish.currentState!.hideLoader();
          // }
          actionLoading = false;
          update();
          SnackBarHelper.show("Images are required");
          return;
        }

        /// selected images to be uploaded
        List<String> url_2 = [];
        if (filesToBeUploaded.isNotEmpty) {
          url_2 = await (ApiCall.multiFileUpload(filesToBeUploaded)) ?? [];
        }
        urls.addAll(url_1 + url_2);
        log("$urls");
      }

      log("===> 3");
      Map<String, dynamic> body = {
        if (titleController.text.isNotEmpty) "name": "${titleController.text}",
        if (descController.text.isNotEmpty)
          "description": "${descController.text}",
        if (urls.isNotEmpty) "attachments": urls,
        "address": {
          if (addressLine1 != null && addressLine1.isNotEmpty)
            "addressLine1": addressLine1,
          if (city != null) "city": city ?? "",
          if (coordinates != null)
            "coordinates": [
              coordinates == null ? 0 : coordinates!.latitude,
              coordinates == null ? 0 : coordinates!.longitude,
            ],
        },
        if (selectedEventType != null) "eventType": "${selectedEventType!.id}",
        if (dateTimeModified) "startTime": finalStartTime.toIso8601String(),
        if (dateTimeModified) "endTime": finalEndTime.toIso8601String(),
        if (type == 2) "status": 1,
      };
      log("===> $body");
      print("===> $body");

      await ApiCall.patch(
        ApiRoutes.event_management,
        body: body,
        id: state!.id!,
      );
      // if (type == 1) {
      //   buttonKeySave.currentState!.hideLoader();
      // } else {
      //   buttonKeyPublish.currentState!.hideLoader();
      // }
      actionLoading = false;
      update();

      SnackBarHelper.show(
        type == 1 ? "Event changes saved successfully" : "Event published",
      );
      Get.back();
      refreshHome();
    } catch (e, s) {
      // if (type == 1) {
      //   buttonKeySave.currentState!.hideLoader();
      // } else {
      //   buttonKeyPublish.currentState!.hideLoader();
      // }
      actionLoading = false;
      update();
      log("$e :: $s");
      SnackBarHelper.show("$e");
    }
  }

  void createNewEvent() async {
    try {
      change(null, status: RxStatus.loading());
      Map<String, dynamic> body = {};

      final result = await ApiCall.post(
        ApiRoutes.event_management,
        body: body,
      );
      final response = EventDatum.fromJson(result.data);
      change(response, status: RxStatus.success());

      /// after successful creation : get all posts and gallery items
      getAllPostsAndGalleryItems();
    } catch (e, s) {
      log("$e :: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  getDetails() async {
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(
        ApiRoutes.events,
        id: eventId,
        query: {
          "\$populate": ["eventType", "address"],
        },
      );
      final response = EventDatum.fromJson(result.data);
      print("$result");
      initializeData(response);

      change(response, status: RxStatus.success());
      getAllPostsAndGalleryItems();
    } catch (e, s) {
      log("$e :: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  getAllPostsAndGalleryItems() {
    postsController.saveEventId(state!.id!);
    postsController.getData();
    galleryController.saveEventId(state!.id!);
    galleryController.getData();
  }

  refreshHome() {
    if (Get.isRegistered<MyEventController>()) {
      final homeController = Get.find<MyEventController>();
      homeController.getData();
    }
  }

  void proceed() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
      update();
    } else {
      state.save();
    }
  }
}
