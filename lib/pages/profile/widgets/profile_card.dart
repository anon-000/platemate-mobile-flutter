import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/app_configs/app_colors.dart';
import 'package:platemate_user/data_models/user.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';

///
/// Created by Auro on 18/04/23 at 1:59 AM
///

class ProfileCard extends StatelessWidget {
  final User? user;
  final VoidCallback? onUpdated;

  const ProfileCard(this.user, {this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Stack(
        children: [
          // Positioned.fill(
          //   child: Opacity(
          //     opacity: 0.4,
          //     child: SvgPicture.asset(
          //       AppAssets.card_back,
          //       fit: BoxFit.fill,
          //       color: Colors.yellow,
          //     ),
          //   ),
          // ),
          user == null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        await Get.toNamed(
                          LoginPage.routeName,
                          arguments: {
                            "parent": Get.currentRoute,
                          },
                        );
                        onUpdated!.call();
                      },
                      child: Text("Sign In"),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.fromLTRB(22, 12, 22, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${user!.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.white),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Edit"),
                          )
                        ],
                      ),
                      Text(
                        "+91 ${user!.phone}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${user!.email}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.brightPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
