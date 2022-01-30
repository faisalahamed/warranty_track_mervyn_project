

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Helper {
  DateTime currentBackPressTime = DateTime.now();

  // static Future<dynamic> getJsonFile(String path) async {
  //   return rootBundle.loadString(path).then(convert.jsonDecode);
  // }

  // static Future<dynamic> getFilesInDirectory(String path) async {
  //   var files = io.Directory(path).listSync();
  //   // return rootBundle.(path).then(convert.jsonDecode);
  // }

  // static String toUrl(String path) {
  //   if (!path.endsWith('/')) {
  //     path += '/';
  //   }
  //   return path;
  // }

  // static String toApiUrl(String path) {
  //   path = toUrl(path);
  //   if (!path.endsWith('/')) {
  //     path += '/';
  //   }
  //   return path;
  // }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.defaultDialog(content:const Text('Back agin to exit app'));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
