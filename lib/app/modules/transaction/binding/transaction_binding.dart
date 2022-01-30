import 'package:get/get.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
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
