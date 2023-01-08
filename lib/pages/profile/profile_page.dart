import 'package:event_admin/app_configs/app_assets.dart';
import 'package:event_admin/app_configs/environment.dart';
import 'package:event_admin/global_controllers/user_controller.dart';
import 'package:event_admin/pages/booking_distribution/booking_distribution_page.dart';
import 'package:event_admin/pages/booking_history/event_history_page.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/earnings/earnings_page.dart';
import 'package:event_admin/pages/event_types/event_types_page.dart';
import 'package:event_admin/pages/feedback/feedback_page.dart';
import 'package:event_admin/pages/reviews/reviews_page.dart';
import 'package:event_admin/pages/web_view/web_view_page.dart';
import 'package:event_admin/utils/app_auth_helper.dart';
import 'package:event_admin/utils/dialog_helper.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:event_admin/widgets/my_divider.dart';
import 'package:event_admin/widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

///
/// Created by Auro on 18/01/22 at 9:27 pm
///

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text("Profile"),
            titleSpacing: 20,
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 20,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: userController.obx(
                    (state) {
                      if (state != null) {
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${SharedPreferenceHelper.user!.user!.name}",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (SharedPreferenceHelper
                                              .user!.user!.email !=
                                          null &&
                                      SharedPreferenceHelper
                                          .user!.user!.email!.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, top: 4),
                                      child: Text(
                                        "${SharedPreferenceHelper.user!.user!.email}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 15),
                                  // InkWell(
                                  //   onTap: () {
                                  //     Get.bottomSheet(
                                  //       EditProfileSheet(
                                  //         SharedPreferenceHelper.user!.user!,
                                  //       ),
                                  //       backgroundColor: Color(0xff0A061D),
                                  //       isScrollControlled: true,
                                  //     );
                                  //   },
                                  //   child: Row(
                                  //     children: [
                                  //       Text(
                                  //         'Edit',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w600,
                                  //         ),
                                  //       ),
                                  //       const SizedBox(width: 5),
                                  //       Icon(
                                  //         Icons.edit,
                                  //         size: 14,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Get.bottomSheet(
                                //   EditProfileSheet(
                                //     SharedPreferenceHelper.user!.user!,
                                //   ),
                                //   backgroundColor: Color(0xff0A061D),
                                //   isScrollControlled: true,
                                // );
                              },
                              child: UserCircleAvatar(
                                SharedPreferenceHelper.user!.user!.avatar ==
                                            null ||
                                        SharedPreferenceHelper
                                            .user!.user!.avatar!.isEmpty
                                    ? "https://st3.depositphotos.com/6672868/13701/v/600/depositphotos_137014128-stock-illustration-user-profile-icon.jpg"
                                    : "${SharedPreferenceHelper.user!.user!.avatar}",
                              ),
                            ),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ),
                // const SizedBox(height: 23),
                // Container(
                //   clipBehavior: Clip.antiAlias,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade200.withOpacity(0.18),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Column(
                //     children: [
                //       ListTile(
                //         onTap: () {},
                //         leading: UserCircleAvatar("", radius: 15),
                //         title: Text("Your Events"),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_rounded,
                //           size: 18,
                //         ),
                //       ),
                //       MyDivider(),
                //       ListTile(
                //         onTap: () {},
                //         leading: UserCircleAvatar("", radius: 15),
                //         title: Text("Invited Events"),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_rounded,
                //           size: 18,
                //         ),
                //       ),
                //       MyDivider(),
                //       ListTile(
                //         onTap: () {},
                //         leading: UserCircleAvatar("", radius: 15),
                //         title: Text("Your chats"),
                //         trailing: Icon(
                //           Icons.arrow_forward_ios_rounded,
                //           size: 18,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 23),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.toNamed(DashboardPage.routeName +
                              EventHistoryPage.routeName);
                        },
                        leading: SvgPicture.asset(AppAssets.feedback),
                        title: Text("Event History"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            DashboardPage.routeName + EventTypesPage.routeName,
                          );
                        },
                        leading: SvgPicture.asset(AppAssets.feedback),
                        title: Text("Event Types"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            DashboardPage.routeName +
                                BookingDistributionPage.routeName,
                          );
                        },
                        leading: SvgPicture.asset(AppAssets.feedback),
                        title: Text("Booking Distribution"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            DashboardPage.routeName + EarningsPage.routeName,
                          );
                        },
                        leading: SvgPicture.asset(AppAssets.feedback),
                        title: Text("Earnings"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ),
                      MyDivider(),
                      ListTile(
                        onTap: () {
                          Get.toNamed(
                            DashboardPage.routeName + ReviewsPage.routeName,
                          );
                        },
                        leading: SvgPicture.asset(AppAssets.feedback),
                        title: Text("Ratings & Reviews"),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 23),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: () {
                      showEventDialog(
                          title: "Logout",
                          description: "Are you sure want to logout?",
                          positiveCallback: () {
                            Get.back();
                            dashboardIndexNotifier.value = 0;
                            AuthHelper.logoutUser();
                          });
                    },
                    leading: SvgPicture.asset(AppAssets.logout),
                    title: Text("Logout"),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 135),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
