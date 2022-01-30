import 'dart:io';

// ignore: unused_import
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';

class HomeViewController extends GetxController {
  TextEditingController amount = TextEditingController();
  TextEditingController itemname = TextEditingController();
  TextEditingController warrantyTillDate = TextEditingController();
  TextEditingController shopPurchached = TextEditingController();
  TextEditingController personWhoServed = TextEditingController();
  TextEditingController note = TextEditingController();
  AuthService _authService = Get.find();
  // var warrantyTotalYear = '1'.obs;
  var loading = false.obs;
  var long = 0.0.obs;
  var lat = 0.0.obs;
  var isLocation = false.obs;
  final Location location = Location();

  final FirebaseConf _firebaseConf = FirebaseConf();

  Future<LocationData?> getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    await location.getLocation().then((value) {
      if (value.longitude != null && value.latitude != null) {
        long.value = value.longitude!;
        lat.value = value.latitude!;
      }

      return value;
    });
  }

  void homeScreenDataGet({
    String? category,
    File? image,
    File? receiptImage,
    File? sellerimage,
    String? warrantyyearcount,
    Function? func,
    Function? nofunc,
  }) async {
    loading.value = true;
    String? cat = category;
    String imageurl = 'null';
    String receiptImaurl = 'null';
    String sellerimageurl = 'null';

    if (_authService.user == null) {
      CommonFunc().customSnackbar(msg: "Not a Valid User", isTrue: false);
      nofunc!();
      loading.value = false;
      return;
    }
    if (category == null) {
      CommonFunc().customSnackbar(msg: "Select Category", isTrue: false);
      nofunc!();
      loading.value = false;
      return;
    }

    if (receiptImage == null) {
      CommonFunc().customSnackbar(msg: "Select Receipt Image", isTrue: false);
      nofunc!();
      loading.value = false;
      return;
    }
    if (warrantyyearcount == null) {
      CommonFunc().customSnackbar(msg: "Select a valid year", isTrue: false);
      nofunc!();
      loading.value = false;
      return;
    }

    if (itemname.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Item Name", isTrue: false);
      nofunc!();
      loading.value = false;
      return;
    }

    if (image != null) {
      await _firebaseConf.uploadImageAndGetUrl(
        image,
        (String url) {
          imageurl = url;
        },
      );
    }
    if (sellerimage != null) {
      await _firebaseConf.uploadImageAndGetUrl(
        sellerimage,
        (String url) {
          sellerimageurl = url;
        },
      );
    }
    // if (receiptImage != null) {
    await _firebaseConf.uploadImageAndGetUrl(
      receiptImage,
      (String url) {
        receiptImaurl = url;
      },
    );
    // }

    TransactionModel transactionModel = TransactionModel(
      uid: _authService.user!.uid,
      category: cat!,
      dateadded: DateTime.now().toIso8601String(),
      image: imageurl,
      rimage: receiptImaurl,
      sellerimage: sellerimageurl,
      itemname: itemname.text,
      price: amount.text,
      color: null,
      shoppurchached: shopPurchached.text,
      personwhoserved: personWhoServed.text,
      note: note.text,
      long: isLocation.value ? long.value.toString() : '0.0',
      lat: isLocation.value ? lat.value.toString() : '0.0',
      warrantytill: warrantyTillDate.text,
      warrantyyearcount: warrantyyearcount,
      isarchived: false,
      timeadded: DateTime.now().millisecondsSinceEpoch,
    );

    // Add Transection To Db
    _firebaseConf.addTransectionToDB(transactionModel, func);

    itemname.text = '';
    amount.text = '';
    note.text = '';
    shopPurchached.text = '';
    personWhoServed.text = '';
    // warrantyTillDate.text = '';
    // warrantyExpiry.text = '';
    // long.value = 0.0;
    // lat.value = 0.0;
  }

  // @override
  // void onClose() {
  //   itemname.dispose();
  //   amount.dispose();
  //   note.dispose();
  //   shopPurchached.dispose();
  //   personWhoServed.dispose();
  //   warrantyTillDate.dispose();
  //   super.onClose();
  // }
}
