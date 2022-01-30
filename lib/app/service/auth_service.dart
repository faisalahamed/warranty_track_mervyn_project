import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/view/login_page.dart';
import 'package:warranty_track/app/modules/home/view/home_screen.dart';

class AuthService extends GetxService {
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  User? get user => firebaseUser.value;

  // Future<AuthService> init() async {
  //   super.onReady();
  //   firebaseUser = Rx<User?>(auth.currentUser);
  //   firebaseUser.bindStream(auth.userChanges());
  //   ever(firebaseUser, _initialScreen);
  //   return this;
  // }

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginView());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void createUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
