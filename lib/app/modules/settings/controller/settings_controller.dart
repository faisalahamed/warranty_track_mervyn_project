import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsController extends GetxController {
  var isEnabled = true.obs;
  AuthService authService = AuthService();
  Rx<PackageInfo> info = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  ).obs;

  @override
  void onInit() async {
    lista();
    getAppVersion();
    super.onInit();
  }

  void lista() async {
    if (authService.auth.currentUser != null) {
      isEnabled.value = await FirebaseConf()
          .currentUserSharedStatus(authService.auth.currentUser!.uid);
    }
  }

// TODO: Set App Version Temporary
  void getAppVersion() async {
    // await FirebaseConf().setAppVersion();
    info.value = await PackageInfo.fromPlatform();
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
