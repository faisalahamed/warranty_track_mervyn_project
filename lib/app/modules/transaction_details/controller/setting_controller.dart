import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';

class TransactionDetailsController extends GetxController {
  TextEditingController categoryTec = TextEditingController();
  final RxList<CategoryModel> catListRx = <CategoryModel>[].obs;
  AuthService _authService = Get.find();

  getCatData(List<CategoryModel> list) {
    catListRx.value = list;
  }

  addCategoryDataGet() {
    print(_authService.user!.uid);
    if (categoryTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Category", isTrue: false);
      return;
    }
    if (_authService.user == null) {
      CommonFunc().customSnackbar(msg: "User Not Valid", isTrue: false);
      return;
    }

    FirebaseConf().addCategory(categoryTec.text, _authService.user!.uid);
  }

  deleteCategoryData({required String id}) {
    FirebaseConf().deleteCategory(id);
  }

  @override
  void onClose() {
    categoryTec.dispose();
    super.onClose();
  }
}
