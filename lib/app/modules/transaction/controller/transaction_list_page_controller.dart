import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/repository/transaction_repository.dart';

class TransactionListController extends GetxController {
  // TabController tabController = TabController();
  final Rx<List<TransactionModel>> transactionStreamList =
      Rx<List<TransactionModel>>([]);
  final Rx<List<TransactionModel>> globalTransactionStreamList =
      Rx<List<TransactionModel>>([]);

  var searchCategory = Rx<List<String>>([]);

  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    transactionStreamList.bindStream(DatabaseService().transactionListStream());
    globalTransactionStreamList
        .bindStream(DatabaseService().globalTransactionListStream());
    // isLoading.value = false;
    super.onInit();
  }

  List<TransactionModel> getSharedList() {
    // print('fetching');
    return transactionStreamList.value
        .where((element) => element.isShared == true)
        .toList();
  }

  // Stream<List<TransactionModel>>
  // search() {
  //   List<TransactionModel> oldList = transactionStreamList.value;
  //   List<TransactionModel> newList = [];

  //   for (var i = 0; i < oldList.length; i++) {
  //     if (searchCategory.value
  //         .any((element) => element == oldList[i].category)) {
  //       newList.add(oldList[i]);
  //     }

  //     if (searchCategory.value.isNotEmpty) {
  //       print(searchCategory.value.contains(oldList[i].category));
  //       searchCategory.value.forEach((element) {
  //         if (oldList[i].category == element) {
  //           newList.add(oldList[i]);
  //         }
  //       });
  //     }
  //   }
  //   transactionStreamList.value = newList;
  //   if (searchCategory.value.isEmpty) {
  //     transactionStreamList.value = newList;
  //     print('================empty category');
  //   } else {
  //     transactionStreamList
  //         .bindStream(DatabaseService().transactionListStream());
  //   }
  //   // transactionStreamList.refresh();
  //   print(searchCategory.value);
  //   // print('searching');
  // }

}
