import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_controller.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class ExportController extends GetxController {
  AuthService _authService = Get.find();
  TransactionController _transactionController = Get.find();
  List<TransactionModel> _list = [];

  @override
  void onInit() {
    streamDemo();
    super.onInit();
  }

  streamDemo() async {
    FirebaseConf()
        .fref
        .reference()
        .child("Details")
        .orderByChild('uid')
        .equalTo(_authService.user!.uid)
        // .orderByChild('isShared')
        // .equalTo(true)
        .once()
        .then((value) {
      _list = [];
      value.value != null
          ? (value.value as Map<dynamic, dynamic>).forEach((key, value2) {
              _list.add(TransactionModel.fromJson(value2, key));
              _transactionController.addintorxlist(_list);
            })
          : null;
   
    });
  }
}
