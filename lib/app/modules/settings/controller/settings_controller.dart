// import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class SettingsController extends GetxController {
  var isEnabled = true.obs;
  AuthService _authService = AuthService();

  User? getCurrentUser() {
    return _authService.user;
  }

  updateUserShareStatus() {
    if (_authService.auth.currentUser != null) {
      FirebaseConf().updateUserSharedData(
          _authService.auth.currentUser!.uid, isEnabled.value);
    }
  }
}
