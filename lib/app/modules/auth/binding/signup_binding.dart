import 'package:get/get.dart';
// import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/modules/auth/controller/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
    );
  }
}
