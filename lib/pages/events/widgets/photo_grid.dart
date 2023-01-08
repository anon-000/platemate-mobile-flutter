import 'package:event_admin/pages/events/controllers/gallery_controller.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/app_loader.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 17/10/22 at 1:48 AM
///

class PhotoGrid extends StatefulWidget {
  final bool me;

  const PhotoGrid({this.me = false, Key? key}) : super(key: key);

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  late GalleryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<GalleryController>()
        ? Get.find<GalleryController>()
        : Get.put(GalleryController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (c)=> controller.obx(
        (state) {
          if (state != null) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.me ? state.length + 1 : state.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (c, i) => (i == 0 && widget.me)
                  ? controller.buttonLoading
                      ? Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: AppProgress(color: Colors.white),
                          ),
                        )
                      : InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: controller.chooseImages,
                          child: Center(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.18),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // height: 70,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.grey.shade200.withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Add Photos",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color:
                                          Colors.grey.shade200.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: MyImage(
                        "${state[widget.me ? (i - 1) : i].thumbnailImage}",
                        fit: BoxFit.cover,
                      ),
                    ),
            );
          }
          return SizedBox();
        },
        onError: (e) => AppEmptyWidget(
          title: "$e",
        ),
        onEmpty: SizedBox(
          height: 300,
          child: controller.buttonLoading
              ? Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: AppProgress(color: Colors.white),
                  ),
                )
              : AppEmptyWidget(
                  title: "No photos yet",
                  buttonText: 'Add',
                  onReload: () {
                    controller.chooseImages();
                  },
                ),
        ),
        onLoading: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
