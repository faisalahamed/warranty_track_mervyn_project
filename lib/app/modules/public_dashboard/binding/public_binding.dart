import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:warranty_track/app/modules/public_dashboard/controller/public_dashboard_controller.dart';

class PublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicDashboardController>(
      () => PublicDashboardController(),
    );
  }
}
