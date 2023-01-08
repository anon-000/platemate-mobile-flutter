import 'package:event_admin/global_controllers/user_controller.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 14/10/22 at 10:41 AM
///

class HomeTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return controller.obx((state) {
      if (state != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Hi, ${SharedPreferenceHelper.user!.user!.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
      return SizedBox();
    });
  }
}
