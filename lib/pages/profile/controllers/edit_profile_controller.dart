import 'dart:developer';

import 'package:event_admin/api_services/base_api.dart';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/global_controllers/user_controller.dart';
import 'package:event_admin/pages/profile/widgets/edit_phone_otp_sheet.dart';
import 'package:event_admin/utils/app_auth_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/photo_chooser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 06/03/22 at 7:57 am
///

class EditProfileController extends GetxController {
  String? _name, _phone, _email;
  RxBool loading = RxBool(false);
  RxString avatar = RxString('');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  final UserController userController = Get.find<UserController>();

  String? get initialName => userController.state?.name;

  String? get initialPhone => userController.state?.phone;

  String? get initialMail => userController.state?.email;

  String? get initialAvatar => userController.state?.avatar;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    _name = initialName;
    _phone = initialPhone;
    _email = initialMail;
    avatar.value = initialAvatar ?? "";
  }

  @override
  void dispose() {
    avatar.close();
    autoValidateMode.close();
    super.dispose();
  }

  void nameSaved(String? newValue) {
    _name = newValue!.trim();
  }

  void phoneSaved(String? newValue) {
    _phone = newValue!.trim();
  }

  void mailSaved(String? newValue) {
    _email = newValue!.trim();
  }

  handleAvatarUpload() async {
    if (loading.value) return;
    var result = await Get.bottomSheet(PhotoChooser(),
        backgroundColor: AppColors.brightBackground);
    if (result != null) {
      try {
        loading.value = true;
        update();
        final url = await ApiCall.singleFileUpload(result);
        // await ApiCall.patch(
        //   ApiRoutes.user,
        //   id: SharedPreferenceHelper.user!.user!.id,
        //   body: {
        //     "avatar": url,
        //   },
        // );
        print("photo upload result : $url");
        loading.value = false;
        avatar.value = url ?? '';
        update();
        // User tempUser = SharedPreferenceHelper.user!.user!;
        // tempUser.avatar = url;
        // final UserController userController = Get.find<UserController>();
        // userController.updateUser(tempUser);
      } catch (err) {
        loading.value = false;
        SnackBarHelper.show(err.toString());
      }
    }
  }

  static Future<dynamic> sendOtpToOnBoardingPhone(String phone) async {
    final result = await AuthHelper.sendOTPToPhone(phone, operation: 'edit');
    log('OTP result $result');
    // SnackBarHelper.show("OTP sent to $phone");
    return null;
  }

  // static Future<bool> verifyOnBoardingOtp(String phone, String otp) async {
  //   final result = await ApiCall.post(ApiRoutes.authenticatePhone,
  //       body: {"phone": phone, "otp": otp, "action": "onboarding"});
  //   return result.data['result'] ?? false;
  // }

  editProfile() async {
    final formState = formKey.currentState;
    if (formState == null) return;
    if (!formState.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      formState.save();
      try {
        if (loading.value) return;
        if (initialMail == _email &&
            initialAvatar == avatar.value &&
            initialPhone == _phone &&
            initialName == _name) {
          Get.back();
          return;
        }

        buttonKey.currentState!.showLoader();
        if (initialPhone != _phone) {
          await sendOtpToOnBoardingPhone(_phone!);
          final otpResult = await Get.bottomSheet(
            EditPhoneOTPSheet(phone: _phone!),
            backgroundColor: Color(0xff0A061D),
            isScrollControlled: true,
          );
          print("$otpResult");
          if (otpResult == null ||
              (otpResult != null && otpResult is bool && !otpResult)) {
            throw 'Please verify phone to update.';
          }
        }
        await AuthHelper.updateUser({
          if (_name != null && _name!.isNotEmpty) "name": _name,
          if (_phone != null && _phone!.isNotEmpty) "phone": _phone,
          if (_email != null && _email!.isNotEmpty) "email": _email,
          if (avatar.value.isNotEmpty) "avatar": avatar.value,
        });
        Get.back();
        SnackBarHelper.show('Profile updated');
      } catch (e, s) {
        buttonKey.currentState!.hideLoader();
        SnackBarHelper.show(e.toString());
        log('editProfile $e', stackTrace: s);
      }
    }
  }
}
