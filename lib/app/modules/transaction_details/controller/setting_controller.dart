import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';

class SettingController extends GetxController {
  TextEditingController categoryTec = TextEditingController();
  final RxList<CategoryModel> catListRx = <CategoryModel>[].obs;

  getCatData(List<CategoryModel> list) {
    catListRx.value = list;
  }

  addCategoryDataGet() {
    if (categoryTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Category", isTrue: false);
      return;
    }

    FirebaseConf().addCategory(categoryTec.text);
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
