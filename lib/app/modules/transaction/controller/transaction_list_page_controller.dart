import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/repository/transaction_repository.dart';

class TransactionListController extends GetxController {
  // TabController tabController = TabController();
  final Rx<List<TransactionModel>> transactionStreamList =
      Rx<List<TransactionModel>>([]);
  final Rx<List<TransactionModel>> globalTransactionStreamList =
      Rx<List<TransactionModel>>([]);
  List<TransactionModel> _defaultTransactionList = [];
  List<TransactionModel> _defaultglobalTransactionList = [];

  Rx<List<String>> searchCategory = Rx<List<String>>([]);
  // Rx<List<String>> searchCategory = Rx<List<String>>(['As', 'who']);

  List<TransactionModel> get globalTransactionList =>
      globalTransactionStreamList.value;
  List<TransactionModel> get transactionList => transactionStreamList.value;

  // RxInt selectedTab = 0.obs;
  TextEditingController globalSearchText = TextEditingController();
  TextEditingController myTransactionSearchText = TextEditingController();

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

  void globalTransactionsearch() {
    if (_defaultglobalTransactionList.length == 0) {
      _defaultglobalTransactionList = globalTransactionStreamList.value;
      List<TransactionModel> oldList = globalTransactionStreamList.value;
      List<TransactionModel> newList = [];

      for (var i = 0; i < oldList.length; i++) {
        if (oldList[i]
                .itemname
                .toLowerCase()
                .contains(globalSearchText.text.toLowerCase()) ||
            oldList[i]
                .shoppurchached!
                .toLowerCase()
                .contains(globalSearchText.text.toLowerCase())) {
          newList.add(oldList[i]);
        }
      }
      if (globalSearchText.text.isNotEmpty) {
        globalTransactionStreamList.value = newList;
      } else {
        globalTransactionStreamList
            .bindStream(DatabaseService().globalTransactionListStream());
      }
    } else {
      List<TransactionModel> oldList = _defaultglobalTransactionList;
      List<TransactionModel> newList = [];

      for (var i = 0; i < oldList.length; i++) {
        if (oldList[i]
                .itemname
                .toLowerCase()
                .contains(globalSearchText.text.toLowerCase()) ||
            oldList[i]
                .shoppurchached!
                .toLowerCase()
                .contains(globalSearchText.text.toLowerCase()) ||
            searchCategory.value.contains(oldList[i].category)) {
          newList.add(oldList[i]);
        }
      }
      if (globalSearchText.text.isNotEmpty) {
        globalTransactionStreamList.value = newList;
      } else {
        globalTransactionStreamList.value = _defaultglobalTransactionList;
        // globalTransactionStreamList
        //     .bindStream(DatabaseService().globalTransactionListStream());
      }
    }
  }

  void myTransactionsearch() {
    if (_defaultTransactionList.length == 0) {
      _defaultTransactionList = transactionStreamList.value;
      List<TransactionModel> oldList = transactionStreamList.value;
      List<TransactionModel> newList = [];

      for (var i = 0; i < oldList.length; i++) {
        if (oldList[i]
            .itemname
            .toLowerCase()
            .contains(myTransactionSearchText.text.toLowerCase())) {
          newList.add(oldList[i]);
        }
      }
      if (myTransactionSearchText.text.isNotEmpty) {
        transactionStreamList.value = newList;
      } else {
        transactionStreamList
            .bindStream(DatabaseService().transactionListStream());
      }
    } else {
      List<TransactionModel> oldList = _defaultTransactionList;
      List<TransactionModel> newList = [];

      for (var i = 0; i < oldList.length; i++) {
        if (oldList[i]
            .itemname
            .toLowerCase()
            .contains(myTransactionSearchText.text.toLowerCase())) {
          newList.add(oldList[i]);
        }
      }
      if (myTransactionSearchText.text.isNotEmpty) {
        transactionStreamList.value = newList;
      } else {
        transactionStreamList.value = _defaultTransactionList;
        // globalTransactionStreamList
        //     .bindStream(DatabaseService().globalTransactionListStream());
      }
    }
  }
}
