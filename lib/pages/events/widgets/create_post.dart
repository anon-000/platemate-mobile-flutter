import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/pages/events/controllers/add_post_controller.dart';
import 'package:event_admin/pages/events/widgets/post_add_image.dart';
import 'package:event_admin/widgets/app_buttons/app_outline_button.dart';
import 'package:event_admin/widgets/app_loader.dart';
import 'package:event_admin/widgets/rating_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/10/22 at 6:13 PM
///

class CreatePost extends StatefulWidget {
  final bool create;
  final String? eventId;

  const CreatePost({Key? key, this.eventId, this.create = false})
      : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late AddPostController controller;

  @override
  void initState() {
    super.initState();
    controller = AddPostController();
    controller.onInit();
    controller.saveEventId(widget.eventId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
        vertical: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GetBuilder(
        init: controller,
        builder: (c) => Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidateMode.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.create ? "Start a post" : "Add a New Post",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    HeadText("Title"),
                    if (controller.titleErr != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.error_outline_sharp,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
              // Text(
              //   "Title",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.borderColor,
              //   ),
              // ),
              const SizedBox(height: 6),
              TextFormField(
                onChanged: controller.onTitleSaved,
                onSaved: controller.onTitleSaved,
                // validator: (data) =>
                //     AppFormValidators.validateEmpty(data, context),
                decoration:
                    AppDecorations.textFieldDecoration(context).copyWith(),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (c) =>
                    FocusScope.of(context).requestFocus(controller.descNode),
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.borderColor,
                ),
              ),
              const SizedBox(height: 6),
              TextFormField(
                focusNode: controller.descNode,
                minLines: 4,
                maxLines: 6,
                onChanged: controller.onDescriptionSaved,
                onSaved: controller.onDescriptionSaved,
                decoration:
                    AppDecorations.textFieldDecoration(context).copyWith(),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    HeadText("Photos"),
                    if (controller.imageErr != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.error_outline_sharp,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              ImageAddSection(
                controller.imageList,
                onRemove: controller.onRemoveImage,
                onAdd: controller.chooseImages,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: controller.actionLoading
                    ? Center(
                        child: AppProgress(
                          color: Colors.white,
                        ),
                      )
                    : AppOutlineButton(
                        key: controller.buttonKey,
                        child: Text(
                          "Add a post",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: controller.proceed,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
