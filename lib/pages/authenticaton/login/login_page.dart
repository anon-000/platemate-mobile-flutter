import 'dart:developer';
import 'package:event_admin/app_configs/app_colors.dart';
import 'package:event_admin/app_configs/app_decorations.dart';
import 'package:event_admin/app_configs/app_validators.dart';
import 'package:event_admin/pages/authenticaton/controllers/login_controller.dart';
import 'package:event_admin/widgets/app_buttons/app_primary_button.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:event_admin/widgets/rating_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:event_admin/data_models/user.dart';
import 'package:event_admin/utils/app_auth_helper.dart';
import 'package:event_admin/utils/snackbar_helper.dart';
import 'package:event_admin/widgets/app_loader.dart';

///
/// Created by Auro on 27/10/22 at 8:05 PM
///

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _parentPath;
  late LoginController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic>? map = Get.arguments ?? {};
    if (map != null) {
      _parentPath = map['parent'] ?? "";
    }
    _controller = LoginController();
    _controller.onInit();
  }

  void socialSignIn(int type) async {
    Get.key.currentState!.push(LoaderOverlay());
    try {
      UserResponse? user;
      switch (type) {
        case 1:
          user = await AuthHelper.userLoginWithGoogle();
          break;

        case 2:
          user = await AuthHelper.userLoginWithFacebook();
          break;

        case 3:
          user = await AuthHelper.userLoginWithApple();
          break;
      }
      if (user != null) {
        AuthHelper.checkUserLevel(parentPath: _parentPath);
      } else {
        Get.key.currentState!.pop();
      }
    } catch (err, s) {
      Get.key.currentState!.pop();
      log('$err $s');
      SnackBarHelper.show("$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: SafeArea(
          child: Form(
            key: _controller.formKey,
            autovalidateMode: _controller.autoValidateMode.value,
            child: Stack(
              children: [
                Positioned.fill(
                  child: MyBackground(),
                ),
                Column(
                  children: [
                    Expanded(
                      child: ListView(
                        reverse: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 55),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                // clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200.withOpacity(0.18),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: GetBuilder(
                                  init: _controller,
                                  builder: (c) => Column(
                                    children: [
                                      const SizedBox(height: 100),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 6),
                                            HeadText("Email"),
                                            if (_controller.emailErr != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6),
                                                child: Icon(
                                                  Icons.error_outline_sharp,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onChanged: _controller.onEmailSaved,
                                        validator: (data) =>
                                            AppFormValidators.validateMail(
                                                data, context),
                                        decoration: AppDecorations
                                                .underLinedTextFieldDecoration(
                                                    context)
                                            .copyWith(
                                          hintText: "Email ID",
                                          contentPadding: EdgeInsets.fromLTRB(
                                              6.0, 10.0, 0.0, 12.0),
                                          isDense: true,
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        scrollPadding:
                                            EdgeInsets.only(bottom: 40),
                                      ),
                                      const SizedBox(height: 18),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 6),
                                            HeadText("Password"),
                                            if (_controller.passwordErr != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 6),
                                                child: Icon(
                                                  Icons.error_outline_sharp,
                                                  size: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        obscureText:
                                            _controller.isObscure.value,
                                        textInputAction: TextInputAction.done,
                                        onChanged: _controller.onPasswordSaved,
                                        decoration: AppDecorations
                                                .underLinedTextFieldDecoration(
                                                    context)
                                            .copyWith(
                                          hintText: "Password",
                                          contentPadding: EdgeInsets.fromLTRB(
                                              6.0, 10.0, 0.0, 12.0),
                                          isDense: true,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _controller.isObscure.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: AppColors.labelColor,
                                              size: 22,
                                            ),
                                            onPressed:
                                                _controller.visibilityChange,
                                          ),
                                        ),
                                        // keyboardType: TextInputType.number,
                                        scrollPadding:
                                            EdgeInsets.only(bottom: 100),
                                      ),
                                      const SizedBox(height: 50),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 16),
                                          child: AppPrimaryButton(
                                            key: _controller.buttonKey,
                                            child: Text("Login"),
                                            onPressed: () =>
                                                _controller.proceed(),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                            "assets/icons/app_icon.png"),
                                        height: 110,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        "Welcome Admin",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String name;
  final String asset;
  final VoidCallback? onTap;

  const LoginButton({this.name = '', this.asset = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(vertical: 18),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: SvgPicture.asset(asset),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
      ),
    );
  }
}
