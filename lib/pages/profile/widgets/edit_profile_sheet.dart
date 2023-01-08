import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/app_configs/app_validators.dart';
import 'package:event_admin/data_models/user.dart';
import 'package:event_admin/pages/profile/controllers/edit_profile_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_outline_button.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 06/03/22 at 7:52 am
///

class EditProfileSheet extends StatefulWidget {
  final User datum;

  const EditProfileSheet(this.datum);

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = EditProfileController();
    controller.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  User get user => widget.datum;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (EditProfileController controller) {
        return Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidateMode.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Transform.translate(
              offset: Offset(0, -50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: controller.handleAvatarUpload,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: [
                            MyImage(
                              controller.avatar.value.isNotEmpty
                                  ? controller.avatar.value
                                  : user.avatar != null &&
                                          user.avatar!.isNotEmpty
                                      ? "${user.avatar}"
                                      : "https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            if (!controller.loading.value)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: EditTag(),
                              ),
                            if (controller.loading.value)
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Center(
                                  child: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: controller.initialName,
                    validator: (data) =>
                        AppFormValidators.validateEmpty(data, context),
                    onSaved: controller.nameSaved,
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: 'Name',
                    ),
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    initialValue: controller.initialMail,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (c) => c == null || c.isEmpty
                        ? null
                        : AppFormValidators.validateMail(c, context),
                    onChanged: controller.mailSaved,
                    onSaved: controller.mailSaved,
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: "Email Id",
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: controller.initialPhone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (v) => controller.phoneSaved,
                    onSaved: controller.phoneSaved,
                    onChanged: controller.phoneSaved,
                    validator: (data) {
                      if (data != null &&
                          data.isNotEmpty &&
                          !GetUtils.isPhoneNumber(data)) {
                        return "Invalid phone no.";
                      } else {
                        return null;
                      }
                    },
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      hintText: 'Enter your phone number',
                      prefixIconConstraints: BoxConstraints.tightFor(width: 54),
                      prefixIcon: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            "+91",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: SvgPicture.asset(AppAssets.edit),
                  //   label: Text(
                  //     "Change Password",
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                  Transform.translate(
                    offset: Offset(0, 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppOutlineButton(
                            height: 48,
                            color: Colors.white,
                            borderColor: Colors.white,
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppPrimaryButton(
                            key: controller.buttonKey,
                            height: 48,
                            child: Text("Save"),
                            onPressed: controller.editProfile,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class EditTag extends StatelessWidget {
  const EditTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.black.withOpacity(0.6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.edit_new,
            color: Colors.white,
          ),
          // const SizedBox(width: 6),
          // Text(
          //   "Edit",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
