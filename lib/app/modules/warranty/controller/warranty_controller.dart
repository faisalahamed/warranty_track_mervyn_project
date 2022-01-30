// ignore: unused_import
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import 'package:warranty_track/app/model/transaction_model.dart';

class WarrantyController extends GetxController {
  var itemModelList = <TransactionModel>[].obs;
  var selectedWarrantyCategories = <String>['All'].obs;

  void filteredListCalculation(List<TransactionModel> list) {
    if (selectedWarrantyCategories.contains('Expiry')) {
      List<TransactionModel> newlist = [];

      for (var e in list) {
        if (e.isarchived == false) newlist.add(e);
      }
      newlist.sort((a, b) => a.warrantytill.compareTo(b.warrantytill));
      itemModelList.value = newlist;
    } else if (selectedWarrantyCategories.contains('All')) {
      List<TransactionModel> newlist = [];

      for (var e in list) {
        if (e.isarchived == false) newlist.add(e);
      }
      newlist.sort((a, b) => b.timeadded.compareTo(a.timeadded));

      itemModelList.value = newlist;
    } else if (selectedWarrantyCategories.contains('Old')) {
      List<TransactionModel> newlist = [];

      for (var e in list) {
        if (e.isarchived == false) newlist.add(e);
      }
      newlist.sort((a, b) => a.timeadded.compareTo(b.timeadded));

      itemModelList.value = newlist;
    } else if (selectedWarrantyCategories.contains('Archived')) {
      List<TransactionModel> newlist = [];

      for (var e in list) {
        if (e.isarchived == true) newlist.add(e);
      }
      itemModelList.value = newlist;
    } else {
      List<TransactionModel> newlist = [];

      for (var e in list) {
        if (e.isarchived == false) newlist.add(e);
      }
      newlist.sort((a, b) => a.timeadded.compareTo(b.timeadded));

      itemModelList.value = newlist;
    }
  }

  @override
  void onClose() {
    selectedWarrantyCategories.value = ['All'];
    super.onClose();
  }
}
