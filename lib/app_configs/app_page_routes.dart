import 'package:platemate_user/pages/authenticaton/onboarding/avatar_selection_page.dart';
import 'package:platemate_user/pages/authenticaton/login/login_page.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_first_page.dart';
import 'package:platemate_user/pages/authenticaton/onboarding/preferences_second_page.dart';
import 'package:platemate_user/pages/authenticaton/signup/signup_page.dart';
import 'package:platemate_user/pages/dashboard/dashboard_page.dart';
import 'package:platemate_user/pages/splash/splash_screen.dart';
import 'package:platemate_user/pages/web_view/web_view_page.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: LoginPage.routeName, page: () => LoginPage()),
    GetPage(name: SignupPage.routeName, page: () => SignupPage()),
    GetPage(
        name: PreferencesFirstPage.routeName,
        page: () => PreferencesFirstPage()),
    GetPage(
        name: PreferencesSecondPage.routeName,
        page: () => PreferencesSecondPage()),
    GetPage(
      name: AvatarSelectionPage.routeName,
      page: () => AvatarSelectionPage(),
    ),
    GetPage(
      name: WebViewPage.routeName,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: DashboardPage.routeName,
      page: () => DashboardPage(),
      children: [],
    )
  ];
}
