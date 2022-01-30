import 'dart:io';
import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/model/transaction_model.dart';

class FirebaseConf {
  final DatabaseReference fref = FirebaseDatabase.instance.reference();
  // final FirebaseAuth fauth = FirebaseAuth.instance;
  final dbstore = FirebaseStorage.instance.ref();

  Future<void> addTransectionToDB(
      TransactionModel transactionModel, Function? func) async {
    await fref
        .child('Details')
        .push()
        .set(
          transactionModel.toJson(),
        )
        .then((val) {
      func!();
    });
  }

  Future<void> uploadImageAndGetUrl(
    File? image,
    Function func,
  ) async {
    Random _rednd = Random();
    String _redstr = _rednd.nextInt(10).toString();
    String _rst = _rednd.nextInt(4).toString();
    final ref = dbstore.child('Details').child('$_rst$_redstr.jpg');
    await ref.putFile(image!).catchError((error) {}).then((_) async {
      String url = await ref.getDownloadURL();
      func(url);
    });
  }

// Category Database
  Future<void> addCategory(String category) async {
    await fref.child('Categories').push().set({
      "name": category,
      "count": 0,
    });
  }

  Future<void> deleteCategory(String id) async {
    await fref.child('Categories').child(id).remove();
  }

  void reorderFire(List<CategoryModel> category) {
    for (int i = 0; i < category.length; i++) {
      fref.child("Categories").child(category[i].id).child("count").set(i);
    }
  }

  void updateTransaction(String id, String title, dynamic value) async {
    await fref.child("Details").child(id).child(title).set(value);
  }

// delete transection
// delete image from storage
  Future<void> deleteTransaction(TransactionModel transactionModel) async {
    var dbstorenew = FirebaseStorage.instance;
    await dbstorenew
        .refFromURL(transactionModel.rimage)
        .delete()
        .catchError((e) => debugPrint('delete image error'));
    transactionModel.sellerimage != 'null'
        ? await dbstorenew
            .refFromURL(transactionModel.sellerimage)
            .delete()
            .catchError((e) => debugPrint('delete image error'))
        : null;
    transactionModel.image != 'null'
        ? await dbstorenew
            .refFromURL(transactionModel.image)
            .delete()
            .catchError((e) => debugPrint('delete image error'))
        : null;
    await fref.child('Details').child(transactionModel.id).remove();
  }
}
