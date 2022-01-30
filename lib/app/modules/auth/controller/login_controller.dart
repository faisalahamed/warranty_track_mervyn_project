import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/repository/user_repository.dart';
import 'package:warranty_track/common/common.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  void login() {
    if (email.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Valid Email", isTrue: false);
      return;
    }
    if (password.text.isEmpty) {
      CommonFunc().customSnackbar(msg: "Enter Valid Password", isTrue: false);
      return;
    }
    _userRepository.signInWithEmailAndPassword(email.text, password.text);
  }

  void register() {
    _userRepository.signUpWithEmailAndPassword(email.text, password.text);
  }

  void logout() {
    _userRepository.logoutRepository();
  }
}
