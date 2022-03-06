import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/service/auth_service.dart';
// import 'package:warranty_track_web/app/data/transaction_model.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  AuthService _authService = Get.find();

  Stream<List<TransactionModel>> transactionListStream() {
    return _firebaseDatabase
        .ref()
        .child("Details")
        // .orderByChild('isShared')
        // .equalTo(true)
        // .limitToFirst(2)
        .orderByChild('uid')
        .equalTo(_authService.user!.uid)
        .onValue
        .map((event) {
      List<TransactionModel> list = [];
      Map x = event.snapshot.value as Map;
      x.forEach((element, x) {
        // print('===================$element');
        list.add(TransactionModel.fromStream(x, element));
      });

      return list.reversed.toList();
    });
  }

  Stream<List<TransactionModel>> globalTransactionListStream() {
    return _firebaseDatabase
        .ref()
        .child("Details")
        .orderByChild('isShared')
        .equalTo(true)
        .onValue
        .map((event) {
      List<TransactionModel> list = [];
      Map x = event.snapshot.value as Map;
      x.forEach((element, x) {
        // print('===================$element');
        if (x['reportcount'] == null) {
          list.add(TransactionModel.fromStream(x, element));
        } else if (x['reportcount'] < 5) {
          list.add(TransactionModel.fromStream(x, element));
        }
      });

      return list.reversed.toList();
    });
  }
}
