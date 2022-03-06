
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/feedback/controller/feedback_controller.dart';

class FeedbackBinding extends Bindings{
  @override
  void dependencies() {
      Get.lazyPut<FeedbackController>(
      () => FeedbackController(),
    );
  }

}