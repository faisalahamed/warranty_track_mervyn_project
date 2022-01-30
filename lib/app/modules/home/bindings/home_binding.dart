import 'package:get/get.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(),
    );
    // Get.put(HomeController(), permanent: true);
    // Get.put(BookingsController(), permanent: true);

    // Get.lazyPut<BookingController>(
    //   () => BookingController(),
    // );
    // Get.lazyPut<MessagesController>(
    //   () => MessagesController(),
    // );
    // Get.lazyPut<AccountController>(
    //   () => AccountController(),
    // );
    // Get.lazyPut<SearchController>(
    //   () => SearchController(),
    // );
  }
}
