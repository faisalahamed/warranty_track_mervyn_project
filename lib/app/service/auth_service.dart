import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    showLoading(loading_message: "Sign up in Progress..");
    try {
      UserCredential _userCred = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      if (_userCred.user != null) {
        FirebaseConf().addUserSignup(
            _userCred.user!.uid, _userCred.user!.email, 'My name');
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      showLoading();
      await auth
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) => Get.back());
    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      // Get.back();
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
    showLoading(loading_message: 'Signing in with google....');
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
        Get.back();
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

  void showLoading({String loading_message = 'Siging in. Please Wait...'}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            height: 40,
            child: Row(
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                SizedBox(height: 20),
                Text(loading_message)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getcurrentUserEmail() {
    if (user != null && user!.email != null) {
      return user!.email!;
    } else {
      return '';
    }
  }
}
