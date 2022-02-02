import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:warranty_track/app/modules/auth/view/login_page.dart';
import 'package:warranty_track/app/modules/home/view/home_screen.dart';
import 'package:warranty_track/app/service/firebase_config.dart';

class AuthService extends GetxService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

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
      UserCredential _userCred = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      if (_userCred.user != null) {
        FirebaseConf().addUserSignup(
            _userCred.user!.uid, _userCred.user!.email, 'My name');
      }
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
      if (googleSignIn.currentUser != null) {
        googleSignIn.signOut();
      }
      await auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    print('hello=============');

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        if (googleAuth.idToken != null) {
          final userCredential = await auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );
          // Add Gamil user Details to USer FirebaseFirestore database;
          // FirebaseConf().addUserSignup(userCredential.user!.uid);
          if (userCredential.user != null) {
            FirebaseConf().addUserSignup(userCredential.user!.uid,
                userCredential.user!.displayName, userCredential.user!.email);
          }
        }
      } else {
        Get.snackbar(
          "Signing In Cancel",
          'Something went wrong.Please try again',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
