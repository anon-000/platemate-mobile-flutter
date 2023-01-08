import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/data_models/event_datum.dart';
import 'package:event_admin/pages/events/controllers/gallery_controller.dart';
import 'package:event_admin/pages/events/controllers/posts_controller.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 24/10/22 at 12:01 AM
///

class EventDetailsController extends GetxController
    with StateMixin<EventDatum> {
  String eventId = '';
  late PostsController postsController;
  late GalleryController galleryController;
  int feedType = 1;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments ?? {};
    eventId = args['eventId'] ?? "";
    postsController = Get.isRegistered<PostsController>()
        ? Get.find<PostsController>()
        : Get.put(PostsController());
    galleryController = Get.isRegistered<GalleryController>()
        ? Get.find<GalleryController>()
        : Get.put(GalleryController());
    postsController.saveEventId(eventId);
    galleryController.saveEventId(eventId);
    postsController.getData();
    galleryController.getData();
  }

  onFeedTypeUpdate(int c) {
    feedType = c;
    update();
  }

  void getData() async {
    try {
      change(null, status: RxStatus.loading());

      final result = await ApiCall.get(ApiRoutes.events, id: eventId, query: {
        // '\$populate': [
        //   // 'subEvents.address.city',
        //   'address.city',
        //   {
        //     'path': 'subEvents',
        //     'populate': 'address.city',
        //   }
        // ]
      });
      final response = EventDatum.fromJson(result.data);

      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e :: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
