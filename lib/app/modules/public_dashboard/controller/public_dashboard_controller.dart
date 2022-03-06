import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/repository/transaction_repository.dart';

class PublicDashboardController extends GetxController {
  final Rx<List<TransactionModel>> transactionStreamList =
      Rx<List<TransactionModel>>([]);

  var searchCategory = Rx<List<String>>([]);

  @override
  void onInit() {
    transactionStreamList
        .bindStream(DatabaseService().globalTransactionListStream());
    // isLoading.value = false;
    super.onInit();
  }
}
