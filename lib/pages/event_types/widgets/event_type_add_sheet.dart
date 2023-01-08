import 'dart:developer';
import 'dart:io';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/api_routes.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/app_configs/app_validators.dart';
import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/pages/event_types/controllers/event_type_controller.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:event_admin/widgets/photo_chooser.dart';
import 'package:event_admin/widgets/sheet_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 07/01/23 at 11:35 PM
///

class EventTypeAdditionSheet extends StatefulWidget {
  final EventType? datum;

  const EventTypeAdditionSheet({Key? key, this.datum}) : super(key: key);

  @override
  State<EventTypeAdditionSheet> createState() => _EventTypeAdditionSheetState();
}

class _EventTypeAdditionSheetState extends State<EventTypeAdditionSheet> {
  String title = '';
  String desc = '';
  dynamic image;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  onTitleSaved(String? v) {
    title = v ?? '';
  }

  onDescSaved(String? v) {
    desc = v ?? '';
  }

  @override
  void initState() {
    super.initState();

    if (widget.datum != null) {
      title = widget.datum!.name ?? '';
      desc = widget.datum!.description ?? '';
      image = widget.datum!.avatar == null || widget.datum!.avatar!.isEmpty
          ? null
          : widget.datum!.avatar;
    }
  }

  addEventType() async {
    try {
      if (title.isEmpty) {
        SnackBarHelper.show("Name is required.");
        return;
      }
      if (image == null) {
        SnackBarHelper.show("Avatar is required.");
        return;
      }
      if (desc.isEmpty) {
        SnackBarHelper.show("Description is required.");
        return;
      }
      buttonKey.currentState!.showLoader();
      String? url;
      if (image != null && image is File)
        url = await ApiCall.singleFileUpload(image);

      dynamic result;

      if (widget.datum != null) {
        result = await ApiCall.patch(
          ApiRoutes.event_type,
          id: widget.datum!.id!,
          body: {
            "name": "$title",
            "description": "$desc",
            if (url != null) "avatar": "$url",
          },
        );
      } else {
        result = await ApiCall.post(
          ApiRoutes.event_type,
          body: {
            "name": "$title",
            "description": "$desc",
            if (url != null) "avatar": "$url",
          },
        );
      }

      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show(
        widget.datum == null
            ? "Event type added successfully"
            : "Event type updated",
      );
      Get.back();
      final datum = EventType.fromJson(result.data);
      if (Get.isRegistered<EventTypeController>()) {
        Get.find<EventTypeController>().updateEventType(datum);
      }
    } catch (err, s) {
      buttonKey.currentState!.hideLoader();
      log("$err :: $s");
      SnackBarHelper.show("$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return SizedBox(
      height: height * 0.68,
      child: Material(
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: Color(0xff0A061D),
                child: MyBackground(),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      SheetTitle("Add event type"),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue:
                              widget.datum == null ? '' : widget.datum!.name,
                          onChanged: onTitleSaved,
                          onSaved: onTitleSaved,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (data) =>
                              AppFormValidators.validateEmpty(data, context),
                          decoration:
                              AppDecorations.textFieldDecoration_2(context)
                                  .copyWith(
                                      hintText:
                                          "Enter the name of the event type"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          initialValue: widget.datum == null
                              ? ''
                              : widget.datum!.description,
                          minLines: 5,
                          maxLines: 5,
                          onChanged: onDescSaved,
                          onSaved: onDescSaved,
                          textInputAction: TextInputAction.done,
                          validator: (data) =>
                              AppFormValidators.validateEmpty(data, context),
                          decoration: AppDecorations.textFieldDecoration_2(
                                  context)
                              .copyWith(
                                  hintText:
                                      "Enter the description the your event type"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Avatar",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      image == null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () async {
                                  final result = await Get.bottomSheet(
                                    PhotoChooser(),
                                    backgroundColor: Color(0xff0A061D),
                                  );

                                  if (result != null) {
                                    setState(() {
                                      image = result;
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 16),
                                  margin: const EdgeInsets.only(left: 16),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.grey.shade200.withOpacity(0.18),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // height: 70,
                                  // width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.grey.shade200
                                            .withOpacity(0.5),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Add Photos",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.grey.shade200
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Stack(
                                children: [
                                  image is String
                                      ? Image.network(
                                          image,
                                          fit: BoxFit.cover,
                                          height: 60,
                                          width: 60,
                                        )
                                      : Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                          height: 60,
                                          width: 60,
                                        ),
                                  Positioned(
                                    right: 6,
                                    top: 5,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 20,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                    physics: ClampingScrollPhysics(),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: AppPrimaryButton(
                      key: buttonKey,
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: addEventType,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
