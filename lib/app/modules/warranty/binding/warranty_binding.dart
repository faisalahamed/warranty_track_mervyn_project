import 'package:get/get.dart';
import 'package:warranty_track/app/modules/warranty/controller/warranty_controller.dart';

class WarrantyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WarrantyController>(
      () => WarrantyController(),
    );
  }
}