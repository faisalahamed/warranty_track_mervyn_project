import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class SettingsController extends GetxController {
  var isEnabled = true.obs;
  AuthService authService = AuthService();

  @override
  void onInit() async {
    lista();
    super.onInit();
  }

  void lista() async {
    if (authService.auth.currentUser != null) {
      isEnabled.value = await FirebaseConf()
          .currentUserSharedStatus(authService.auth.currentUser!.uid);
    }
  }

  void updateUserShareStatus() {
    if (authService.auth.currentUser != null) {
      FirebaseConf().updateUserSharedData(
          authService.auth.currentUser!.uid, isEnabled.value);
    }
  }

  void updateShareStatusOfTransaction() {
    if (authService.auth.currentUser != null) {
      FirebaseConf().updateShareStatusOfTransaction(
          authService.auth.currentUser!.uid, isEnabled.value);
    }
  }
}
