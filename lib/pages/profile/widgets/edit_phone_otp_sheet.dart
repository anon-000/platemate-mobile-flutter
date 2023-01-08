import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/environment.dart';
import 'package:event_admin/pages/profile/controllers/edit_phone_otp_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/my_divider.dart';
import 'package:event_admin/widgets/sheet_title.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

///
/// Created by Auro on 27/12/22 at 11:37 PM
///

class EditPhoneOTPSheet extends StatefulWidget {
  final String phone;
  final String parentPath;

  const EditPhoneOTPSheet({this.phone = '', this.parentPath = ''});

  @override
  State<EditPhoneOTPSheet> createState() => _EditPhoneOTPSheetState();
}

class _EditPhoneOTPSheetState extends State<EditPhoneOTPSheet> {
  late EditOtpController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EditOtpController();
    _controller.onInit();
    _controller.startTimer();
    _controller.initData(
      phoneValue: widget.phone,
      parent: widget.parentPath,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetTitle("Enter OTP"),
        MyDivider(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontFamily: Environment.fontFamily),
              children: [
                TextSpan(
                  text:
                      'Please enter the OTP that has been sent to your given Phone no. ',
                  style: TextStyle(color: const Color(0xff929292)),
                ),
                TextSpan(
                  text: '${_controller.phone}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.brightSecondaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: GetBuilder(
            init: _controller,
            builder: (ctrl) => Container(
              //width: 250,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: PinCodeTextField(
                controller: _controller.textController,
                length: 6,
                autoDisposeControllers: false,
                autoFocus: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                textStyle: TextStyle(color: Colors.white, fontSize: 22),
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderWidth: 2,
                    fieldOuterPadding:
                        const EdgeInsets.symmetric(horizontal: 5),
                    borderRadius: BorderRadius.circular(8),
                    activeColor: theme.primaryColor,
                    inactiveColor: AppColors.borderColor,
                    selectedColor: Colors.white),
                onChanged: _controller.onChanged,
                onCompleted: _controller.onCompleted,
                appContext: context,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.timerText,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Didn\'t receive the code? ',
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Resend',
                          style: TextStyle(fontWeight: FontWeight.w600)
                              .copyWith(
                                  color: _controller.isResendActive.value
                                      ? AppColors.brightSecondaryColor
                                      : Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (_controller.isResendActive.value) {
                                _controller.regenerateOTP();
                              }
                            })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AppPrimaryButton(
              key: _controller.buttonKey,
              child: Text("Verify & proceed"),
              onPressed: _controller.proceed,
            ),
          ),
        )
      ],
    );
  }
}
