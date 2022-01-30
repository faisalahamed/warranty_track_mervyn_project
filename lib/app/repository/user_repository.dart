import 'package:get/get.dart';
import 'package:warranty_track/app/service/auth_service.dart';

// import '../models/user_model.dart';
// import '../providers/firebase_provider.dart';
// import '../providers/laravel_provider.dart';
// import '../services/auth_service.dart';

class UserRepository {
  final AuthService _authService = Get.find();

  void signInWithEmailAndPassword(String email, String password) {
    return _authService.login(email, password);
  }

  void signUpWithEmailAndPassword(String email, String password) {
    return _authService.login(email, password);
  }
  void logoutRepository() {
    return _authService.logout();
  }
}
