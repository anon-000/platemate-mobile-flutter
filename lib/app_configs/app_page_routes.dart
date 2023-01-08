import 'package:event_admin/pages/authenticaton/login/login_page.dart';
import 'package:event_admin/pages/booking_distribution/booking_distribution_page.dart';
import 'package:event_admin/pages/booking_history/event_history_page.dart';
import 'package:event_admin/pages/booking_stats/booking_stats_page.dart';
import 'package:event_admin/pages/dashboard/dashboard_page.dart';
import 'package:event_admin/pages/earnings/earnings_page.dart';
import 'package:event_admin/pages/event_types/event_types_page.dart';
import 'package:event_admin/pages/events/event_details_page.dart';
import 'package:event_admin/pages/reviews/reviews_page.dart';
import 'package:event_admin/pages/splash/splash_screen.dart';
import 'package:event_admin/pages/support/chat_details_page.dart';
import 'package:event_admin/pages/web_view/web_view_page.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => SplashPage()),
    GetPage(name: LoginPage.routeName, page: () => LoginPage()),
    GetPage(
      name: WebViewPage.routeName,
      page: () => WebViewPage(),
    ),
    GetPage(
      name: DashboardPage.routeName,
      page: () => DashboardPage(),
      children: [
        GetPage(
          name: BookingStatsPage.routeName,
          page: () => BookingStatsPage(),
        ),
        GetPage(
          name: ChatDetailsPage.routeName,
          page: () => ChatDetailsPage(),
        ),
        GetPage(
          name: EventHistoryPage.routeName,
          page: () => EventHistoryPage(),
        ),
        GetPage(
          name: EventTypesPage.routeName,
          page: () => EventTypesPage(),
        ),
        GetPage(
          name: BookingDistributionPage.routeName,
          page: () => BookingDistributionPage(),
        ),
        GetPage(
          name: EarningsPage.routeName,
          page: () => EarningsPage(),
        ),
        GetPage(
          name: ReviewsPage.routeName,
          page: () => ReviewsPage(),
        ),
        GetPage(
          name: EventDetailsPage.routeName,
          page: () => EventDetailsPage(),
        ),
      ],
    )
  ];
}
