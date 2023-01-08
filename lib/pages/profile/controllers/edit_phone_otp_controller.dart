import 'dart:async';
import 'dart:developer';

import 'package:event_admin/app_configs/environment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:event_admin/utils/app_auth_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro  on 19/01/22 at 8:03 pm
///

class EditOtpController extends GetxController {
  String pin = "";
  RxBool isResendActive = RxBool(false);
  late Timer _timer;
  RxInt timerCounter = RxInt(59);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  late String phone;
  late String parentPath;

  late TextEditingController? textController;

  String get timerText =>
      '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '') : timerCounter}';

  void onCodeUpdated(String? code) {
    // textController?.text = code;
    pin = code ?? "";
    update();
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    // SmsAutoFill().getAppSignature.then((value) {
    //   log("APP SIGNATURE $value");
    // });
    // startTimer();
    // Future.delayed(const Duration(minutes: 1), () {
    //   isResendActive = true;
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    timerCounter.close();
    isResendActive.close();
    // textController?.dispose();
    // textController = null;
    super.dispose();
  }

  initData({String? phoneValue, String? parent}) {
    phone = phoneValue ?? "";
    parentPath = parent ?? "";
  }

  Future<void> listenToOtp() async {
    print("---listening for otp");
    await SmsAutoFill().listenForCode;
  }

  ///Timer
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        isResendActive.value = timerCounter < 15;

        if (timerCounter.value < 1) {
          timer.cancel();
        } else {
          timerCounter.value -= 1;
        }
      },
    );
  }

  regenerateOTP() {
    _timer.cancel();
    isResendActive.value = false;
    timerCounter.value = 59;
    buttonKey.currentState?.showLoader();
    AuthHelper.sendOTPToPhone(phone, login: false, operation: 'edit')
        .then((value) {
      buttonKey.currentState?.hideLoader();
      startTimer();
    }).catchError((err) {
      buttonKey.currentState?.hideLoader();
      SnackBarHelper.show(err.toString());
    });
  }

  void loginUsingOtp() {
    if (pin.isEmpty) {
      SnackBarHelper.show('Please enter pin to continue');
    } else {
      _login();
    }
  }

  void _login() {
    Get.focusScope!.unfocus();
    if (pin.isEmpty || pin.length != Environment.otpLength) {
      SnackBarHelper.show('Please enter pin to continue');
    } else {
      buttonKey.currentState?.showLoader();
      AuthHelper.verifyOtp(phone, pin, login: false, operation: 'edit')
          .then((value) {
        Get.back(result: true);
      }).catchError((e, s) {
        log("Verify_OTP_Error:", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void onChanged(String value) {
    pin = value.trim();
  }

  void onCompleted(String value) {
    pin = value.trim();
    _login();
  }

  void proceed() {
    _login();
  }
}
