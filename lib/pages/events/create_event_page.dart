import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/app_configs/app_validators.dart';
import 'package:event_admin/pages/events/controllers/create_event_controller.dart';
import 'package:event_admin/pages/event_types/controllers/event_type_controller.dart';
import 'package:event_admin/pages/events/widgets/choose_event_type.dart';
import 'package:event_admin/pages/events/widgets/create_post.dart';
import 'package:event_admin/pages/events/widgets/event_more_details.dart';
import 'package:event_admin/pages/events/widgets/feed_type.dart';
import 'package:event_admin/pages/events/widgets/photo_grid.dart';
import 'package:event_admin/pages/events/widgets/post_add_image.dart';
import 'package:event_admin/pages/events/widgets/post_list.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_outline_button.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/app_error_widget.dart';
import 'package:event_admin/widgets/app_loader.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 23/10/22 at 10:44 PM
///

class CreateEventPage extends StatefulWidget {
  static const routeName = '/create-event-page';

  const CreateEventPage({Key? key}) : super(key: key);

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  late CreateEventController controller;
  late EventTypeController eventTypeController;

  // int feedType = 1;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> args = Get.arguments ?? {};
    controller = Get.put(CreateEventController());
    controller.onInit();
    String? eventId = args['eventId'];

    if (eventId != null) {
      controller.onEventIdSaved(eventId);
      controller.getDetails();
    } else {
      controller.createNewEvent();
    }

    eventTypeController = Get.isRegistered<EventTypeController>()
        ? Get.find<EventTypeController>()
        : Get.put(EventTypeController());
    eventTypeController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showEventDialog(
          title: "Do you really want to exit without saving the changes?",
          // description: "There are unsaved changes to this event.",
          positiveCallback: () {
            Get.back();
            Get.back();
          },
        );
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: MyBackground(),
            ),
            Positioned.fill(
              child: SafeArea(
                child: controller.obx(
                  (state) => Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        title: Text("Create an event"),
                        iconTheme: IconThemeData(color: Colors.white),
                      ),
                      Expanded(
                        child: GetBuilder(
                          init: controller,
                          builder: (c) => Form(
                            key: controller.formKey,
                            autovalidateMode: controller.autoValidateMode.value,
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Title",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.borderColor,
                                        ),
                                      ),
                                      Text(
                                        " *",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          height: 1,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextFormField(
                                    controller: controller.titleController,
                                    onChanged: controller.onTitleSaved,
                                    onSaved: controller.onTitleSaved,
                                    validator: (data) =>
                                        AppFormValidators.validateEmpty(
                                            data, context),
                                    decoration: AppDecorations
                                            .textFieldDecoration_2(context)
                                        .copyWith(
                                            hintText:
                                                "Enter the title of your event"),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: TextFormField(
                                    controller: controller.descController,
                                    minLines: 4,
                                    maxLines: 6,
                                    onChanged: controller.onDescriptionSaved,
                                    onSaved: controller.onDescriptionSaved,
                                    decoration: AppDecorations
                                            .textFieldDecoration_2(context)
                                        .copyWith(
                                            hintText:
                                                "Enter the description of your event"),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "Photos",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.borderColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ImageAddSection(
                                    controller.imageList,
                                    onRemove: controller.onRemoveImage,
                                    onAdd: controller.chooseImages,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: AppOutlineButton(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${controller.addressLine1.isEmpty ? "Enter" : "View"} your Venue ",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.location_on_outlined,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                          )
                                        ],
                                      ),
                                      onPressed: controller.handleVenueClick,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ChooseEventType(
                                  eventTypeController,
                                  eventType: controller.selectedEventType,
                                  onEventChanged:
                                      controller.onEventTypeSelected,
                                ),
                                const SizedBox(height: 25),
                                EventMoreDetails(
                                  datum: state,
                                  onDateClick: controller.handleDateTime,
                                ),
                                const SizedBox(height: 25),
                                BoldTitle("Feed"),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: FeedType(
                                    me: true,
                                    type: controller.feedType,
                                    onChanged: controller.onFeedTypeUpdate,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: controller.feedType == 1
                                        ? PostList()
                                        : controller.feedType == 2
                                            ? PhotoGrid(me: true)
                                            : CreatePost(
                                                create: true,
                                                eventId: state!.id,
                                              ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GetBuilder(
                        init: controller,
                        builder: (c) => controller.actionLoading
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AppProgress(color: Colors.white),
                              ))
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (controller.state!.status != 1)
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 10, 16, 14),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: AppPrimaryButton(
                                          key: controller.buttonKeyPublish,
                                          child: Text("Publish"),
                                          onPressed: () =>
                                              controller.saveData(2),
                                        ),
                                      ),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 0, 16, 16),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: MyOutlinedButton(
                                        title: controller.state!.status == 1
                                            ? "Save"
                                            : "Save as draft",
                                        // key: controller.buttonKeySave,
                                        // child: Text(
                                        //   "Save as draft",
                                        //   style: TextStyle(
                                        //     color: Colors.white,
                                        //   ),
                                        // ),
                                        onTap: controller.saveData,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                  onError: (e) => Column(
                    children: [
                      AppBar(),
                      Expanded(
                        child: AppEmptyWidget(
                          title: "$e",
                        ),
                      ),
                    ],
                  ),
                  onEmpty: AppEmptyWidget(
                    title: "No data found",
                  ),
                  onLoading: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppProgress(color: Colors.white),
                        const SizedBox(height: 6),
                        Text("Please wait...")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
