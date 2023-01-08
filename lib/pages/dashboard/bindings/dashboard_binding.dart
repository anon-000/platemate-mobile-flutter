import 'package:event_admin/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
