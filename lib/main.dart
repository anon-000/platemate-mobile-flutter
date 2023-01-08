import 'package:event_admin/pages/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:event_admin/app_configs/app_theme.dart';
import 'package:event_admin/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_configs/app_page_routes.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();

  /// Setup for notification services
  // InAppNotification.configureInAppNotification();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // initDynamicLinks();
  }

  // void _goToLink(PendingDynamicLinkData data) {
  //   if (data == null) return;
  //   final Uri deepLink = data.link;
  //   if (deepLink != null) {
  //     switch (deepLink.path) {
  //       case '/profile':
  //         String id = deepLink.queryParameters['id'];
  //         Get.toNamed(OtherProfilePage.routeName, arguments: id);
  //         break;
  //     }
  //   }
  // }
  //
  // Future<void> initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData data) async {
  //         _goToLink(data);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Event Admin',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemes.appTheme,
      darkTheme: AppThemes.appTheme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: SplashPage.routeName,
      getPages: AppPages.pages,
    );
  }
}
