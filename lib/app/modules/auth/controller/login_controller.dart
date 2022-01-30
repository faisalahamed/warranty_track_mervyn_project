import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/repository/user_repository.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  void login() {
    _userRepository.signInWithEmailAndPassword(email.text, password.text);
  }

  void register()  {
    _userRepository.signUpWithEmailAndPassword(email.text, password.text);
  }
  void logout()  {
    _userRepository.logoutRepository();
  }
}
