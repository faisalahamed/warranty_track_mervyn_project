import 'package:firebase_database/firebase_database.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
// import 'package:warranty_track_web/app/data/transaction_model.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Stream<List<TransactionModel>> transactionListStream() {
    return _firebaseDatabase
        .ref()
        .child("Details")
        .orderByChild('isShared')
        .equalTo(true)
        // .limitToFirst(2)
        .onValue
        .map((event) {
      List<TransactionModel> list = [];
      Map x = event.snapshot.value as Map;
      x.forEach((element, x) {
        list.add(TransactionModel.fromStream(x));
      });

      return list.reversed.toList();
    });
  }
}
