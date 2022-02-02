import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class SettingsController extends GetxController {
  var isEnabled = true.obs;
  AuthService _authService = AuthService();

  @override
  void onInit() async {
    lista();
    super.onInit();
  }

  void lista() async {
    if (_authService.auth.currentUser != null) {
      isEnabled.value = await FirebaseConf()
          .currentUserSharedStatus(_authService.auth.currentUser!.uid);
    }
  }

  void updateUserShareStatus() {
    if (_authService.auth.currentUser != null) {
      FirebaseConf().updateUserSharedData(
          _authService.auth.currentUser!.uid, isEnabled.value);
    }
  }
}
