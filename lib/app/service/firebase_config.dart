import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseConf {
  final DatabaseReference fref = FirebaseDatabase.instance.ref();
  // final FirebaseAuth fauth = FirebaseAuth.instance;
  final dbstore = FirebaseStorage.instance.ref();
  final ffs = FirebaseFirestore.instance;

// USER TABLE==============================================================================
  void addUserSignup(String uid, String? email, String? fullname) async {
    await ffs.collection('user').doc(uid).set({
      'email': email,
      'fullname': fullname,
      'shared': false,
    }, SetOptions(merge: true));
  }

  void updateUserSharedData(String uid, bool shareStatus) async {
    await ffs.collection('user').doc(uid).update({
      'shared': shareStatus,
    });
  }

  Future currentUserSharedStatus(String uid) async {
    var p = await ffs.collection('user').doc(uid).get()
      ..data();
    // return p['shared'];
    // print(x);
    if (p['shared'] != null) {
      // print(p['shared']);
      return p['shared'];
    } else
      return false;
  }

// Transection TABLE==============================================================================
  Future updateShareStatusOfTransaction(String uid, bool shareStatus) async {
    var p = await FirebaseConf()
        .fref
        .ref
        .child("Details")
        .orderByChild('uid')
        .equalTo(uid)
        .once();
    if (p.snapshot.value != null) {
      Map data = p.snapshot.value as Map;
      data.forEach((key, value) async {
        print(value['image']);
        if (value['price'] != '' && value['rimage'] != 'null') {
          await fref
              .child("Details")
              .ref
              .child(key)
              .update({'isShared': shareStatus});
          print('here $shareStatus');
        } else {
          await fref
              .child("Details")
              .ref
              .child(key)
              .update({'isShared': false});
        }
      });
    }
  }

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
    var time = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = dbstore.child('Details').child('$time.jpg');
    await ref.putFile(image!).catchError((error) {}).then((_) async {
      String url = await ref.getDownloadURL();
      print('Image URL: $url');
      func(url);
    });
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

// Category Database TABLE==============================================================================
  Future<void> addCategory(String category, String uid) async {
    await fref.child('Categories').push().set({
      "name": category,
      "count": 0,
      "uid": uid,
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

// App Version Table==============================================================================
//  Future<void> setAppVersion() async {
//     await fref.child('appdata').push().set({
//       "version": '1.0.2',
//       "lastUpdateDate": 0,
//     });
//   }

}
