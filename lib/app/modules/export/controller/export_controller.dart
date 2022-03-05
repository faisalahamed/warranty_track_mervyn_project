import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';
import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ExportController extends GetxController {
  AuthService _authService = Get.find();
  // TransactionController _transactionController = Get.find();
  List<TransactionModel> _list = [];
  RxList<TransactionModel> transactionListRx = <TransactionModel>[].obs;

  void addintorxlist(List<TransactionModel> list) {
    transactionListRx.value = list;
  }

  @override
  void onInit() {
    streamDemo();
    super.onInit();
  }

  Future<bool> downloadZip(
      File file, Function uploadDrive, Function uploadStatus,
      {bool isUploadDrive = false}) async {
    final documentDirectory = await getExternalStorageDirectory();
    final String _todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
    var encoder = ZipFileEncoder();
    if (documentDirectory != null) {
      if (await File(documentDirectory.path + '/' + _todayDate + 'Receipt.zip')
          .exists()) {
        if (!isUploadDrive) {
          await File(documentDirectory.path + '/' + _todayDate + 'Receipt.zip')
              .delete(recursive: true);
          encoder.create(
              documentDirectory.path + '/' + _todayDate + 'Receipt.zip');
          encoder.addFile(file);
          if (await Directory(documentDirectory.path + '/' + _todayDate)
              .exists()) {
            encoder.addDirectory(
                Directory(documentDirectory.path + '/' + _todayDate));
          } else {
            print('image Folder not found');
          }

          encoder.close();
          CommonFunc().customSnackbar(
              msg: "Local Back Up Done Successfully", isTrue: true);
        }
        if (isUploadDrive) {
          await uploadDrive(File(
                  documentDirectory.path + '/' + _todayDate + 'Receipt.zip'))
              .then((_) {
            uploadStatus('Completed');
          });
        }
        return !isUploadDrive;
      } else {
        if (!isUploadDrive) {
          encoder.create(
              documentDirectory.path + '/' + _todayDate + 'Receipt.zip');
          encoder.addFile(file);
          // encoder.addDirectory(
          //     Directory(documentDirectory.path + '/' + _todayDate));
          if (await Directory(documentDirectory.path + '/' + _todayDate)
              .exists()) {
            encoder.addDirectory(
                Directory(documentDirectory.path + '/' + _todayDate));
          } else {
            print('image Folder not found');
          }
          encoder.close();
          CommonFunc().customSnackbar(
              msg: "Local Back Up Done Successfully", isTrue: true);
        }

        if (isUploadDrive) {
          await uploadDrive(File(
                  documentDirectory.path + '/' + _todayDate + 'Receipt.zip'))
              .then((_) {
            uploadStatus('Completed');
          });
        }
        return !isUploadDrive;
      }
    } else {
      print('===================directory not found');
      return false;
    }
  }

  streamDemo() async {
    FirebaseConf()
        .fref
        .ref
        .child("Details")
        .orderByChild('uid')
        .equalTo(_authService.user!.uid)
        // .orderByChild('isShared')
        // .equalTo(true)
        .once()
        .then((value) {
      _list = [];
      value.snapshot.value != null
          ? (value.snapshot.value as Map<dynamic, dynamic>).forEach((key, value2) {
              _list.add(TransactionModel.fromJson(value2, key));
              addintorxlist(_list);
            })
          : null;
    });
  }

  Future<bool> saveImageLocal() async {
    final documentDirectory = await getExternalStorageDirectory();
    final String _todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
    bool isSuccessful = true;
    if (documentDirectory != null) {
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
    } else {
      return false;
    }
  }
}
