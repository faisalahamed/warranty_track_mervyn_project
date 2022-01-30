import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/common/common.dart';
import 'package:warranty_track/common/constants.dart';

class TransactionController extends GetxController {
  RxList<TransactionModel> transactionListRx = <TransactionModel>[].obs;

  // ignore: unused_field
  final List<Color> _rendColor = [
    AppColor.primaryColor,
    AppColor.secondaryColor,
    Colors.blue,
  ];

  void addintorxlist(List<TransactionModel> list) {
    transactionListRx.value = list;
  }

  Future<bool> saveImageLocal() async {
    final documentDirectory = await getApplicationSupportDirectory();
    final String _todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
    bool isSuccessful = true;

    if (await Directory("${documentDirectory.path}/$_todayDate").exists()) {
      await Directory("${documentDirectory.path}/$_todayDate")
          .delete(recursive: true);
    }

    try {
      for (int i = 0; i < transactionListRx.length; i++) {
        if (transactionListRx[i].image != 'null') {
          final response =
              await http.get(Uri.parse(transactionListRx[i].image));
          final Directory _dir =
              Directory("${documentDirectory.path}/$_todayDate/${i + 1}/");
          if (await _dir.exists()) {
            final file = File(
              join(documentDirectory.path, '$_todayDate/${i + 1}/0.jpg'),
            );

            file.writeAsBytesSync(response.bodyBytes);
          } else {
            await _dir.create(recursive: true);
            final file = File(
              join(_dir.path, '0.jpg'),
            );

            file.writeAsBytesSync(response.bodyBytes);
          }
        }
        if (transactionListRx[i].rimage != 'null') {
          final response =
              await http.get(Uri.parse(transactionListRx[i].rimage));
          final Directory _dir =
              Directory("${documentDirectory.path}/$_todayDate/${i + 1}/");
          if (await _dir.exists()) {
            final file = File(
                join(documentDirectory.path, '$_todayDate/${i + 1}/1.jpg'));

            file.writeAsBytesSync(response.bodyBytes);
          } else {
            await _dir.create(recursive: true);
            final file = File(
              join(_dir.path, '1.jpg'),
            );
            file.writeAsBytesSync(response.bodyBytes);
          }
        }
      }
    } catch (e) {
      isSuccessful = false;
    }
    return isSuccessful;
  }

  Future<bool> downloadZip(
      File file, Function uploadDrive, Function uploadStatus,
      {bool isUploadDrive = false}) async {
    final documentDirectory = await getApplicationSupportDirectory();
    final String _todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
    var encoder = ZipFileEncoder();
    String path = '/storage/emulated/0/Download/' + _todayDate + 'Receipt.zip';

    if (await File(path).exists()) {
      if (!isUploadDrive) {
        await File(path).delete(recursive: true);
        encoder.create(path);
        encoder.addFile(file);
        encoder
            .addDirectory(Directory('${documentDirectory.path}/$_todayDate'));
        encoder.close();
        CommonFunc().customSnackbar(msg: "Local Back Up Done Successfully", isTrue: true);
      }
      if (isUploadDrive) {
        await uploadDrive(File(path)).then((_) {
          uploadStatus('Completed');
        });
      }
      return !isUploadDrive;
    } else {
      if (!isUploadDrive) {
        encoder.create(path);
        encoder.addFile(file);
        encoder
            .addDirectory(Directory('${documentDirectory.path}/$_todayDate'));
        encoder.close();
        CommonFunc().customSnackbar(msg: "Local Back Up Done Successfully", isTrue: true);
      }

      if (isUploadDrive) {
        await uploadDrive(File(path)).then((_) {
          uploadStatus('Completed');
        });
      }
      return !isUploadDrive;
    }
  }
}
