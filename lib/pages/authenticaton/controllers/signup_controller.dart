import 'package:platemate_user/pages/authenticaton/onboarding/avatar_selection_page.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  String _password_1 = '', _password_2 = '';
  String _emailId = '';
  String _name = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  String? parentPath;
  RxBool isObscure = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    isObscure.close();
    super.dispose();
  }

  void onNameSaved(String? newValue) {
    _name = newValue!.trim();
  }

  void onEmailSaved(String? newValue) {
    _emailId = newValue!.trim();
  }

  void onPasswordSaved(String? newValue) {
    _password_1 = newValue!.trim();
  }

  void onConfirmPasswordSaved(String? newValue) {
    _password_1 = newValue!.trim();
  }

  void visibilityChange() {
    isObscure.value = !isObscure.value;
  }

  void proceed() {
    Get.toNamed(AvatarSelectionPage.routeName);
    return;
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      print(" password - $_password_1 : name - $_name : mail - $_emailId");
      buttonKey.currentState?.showLoader();
      // AuthHelper.userSignupWithEmail(_name, _emailId, _password).then((value) {
      //   final String accessToken = value['accessToken'];
      //   final datum = UserResponse.fromJson(value);
      //   SharedPreferenceHelper.storeUser(user: datum);
      //   SharedPreferenceHelper.storeLoginSkipped(true);
      //   SharedPreferenceHelper.storeAccessToken(accessToken);
      //   final userController = Get.isRegistered()
      //       ? Get.find<UserController>()
      //       : Get.put<UserController>(UserController(), permanent: true);
      //   userController.updateUser(datum.user);
      //   SnackBarHelper.show("Signup successful");
      //   AuthHelper.checkUserLevel(parentPath: parentPath);
      // }).catchError((e, s) {
      //   log("Signup_Page", error: e, stackTrace: s);
      //   SnackBarHelper.show(e.toString());
      // }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
