import 'package:event_admin/pages/chats/all_conversations_page.dart';
import 'package:event_admin/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:event_admin/pages/vendors/vendors_page.dart';
import 'package:event_admin/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:event_admin/pages/dashboard/widgets/navigation_bar.dart';
import 'package:event_admin/pages/home/home_page.dart';
import 'package:event_admin/pages/profile/profile_page.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Auro from Boiler plate
///

ValueNotifier<int> dashboardIndexNotifier = ValueNotifier(0);
ValueNotifier<String> currentLocationNotifier = ValueNotifier('');

class DashboardPage extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<DashboardController>()
        ? Get.find<DashboardController>()
        : Get.put(DashboardController());
    controller.onInit();
    controller.getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (dashboardIndexNotifier.value != 0) {
          dashboardIndexNotifier.value = 0;
        } else {
          return true;
        }
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
                child: ValueListenableBuilder(
                  valueListenable: dashboardIndexNotifier,
                  builder: (ctx, value, _) => AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: [
                      HomePage(),
                      VendorsPage(),
                      AllConversationsPage(),
                      ProfilePage(),
                    ][dashboardIndexNotifier.value],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                onPageChange: (index) {
                  dashboardIndexNotifier.value = index;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
