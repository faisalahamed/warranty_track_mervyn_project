import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/common/common.dart';

class SignUpController extends GetxController {
  TextEditingController fNameTec = TextEditingController();
  TextEditingController lNameTec = TextEditingController();
  TextEditingController emailTec = TextEditingController();
  TextEditingController passwordTec = TextEditingController();

  AuthService _authService = Get.find();

  void createUser() {
    if (lNameTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Last Name", isTrue: false);
      return;
    }

    if (fNameTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter First Name", isTrue: false);
      return;
    }
    if (emailTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Email Address", isTrue: false);
      return;
    }
    if (passwordTec.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Valid Password", isTrue: false);
      return;
    }

    _authService.createUser(emailTec.text, passwordTec.text);
  }
}
