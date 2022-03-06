import 'package:get/get.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_list_page_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionListController>(
      () => TransactionListController(),
    );
  }
}
