import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/common/helper.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.loginFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
          ),
          centerTitle: true,
          backgroundColor: Get.theme.colorScheme.secondary,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                controller.email.text = 'a@a.com';
                controller.password.text = '123456';
                controller.login();
                // Get.toNamed(Routes.rHome);
              },
            ),
            ElevatedButton(
              child: const Text('To Signup Page'),
              onPressed: () {
                Get.toNamed(Routes.rREGISTER);
              },
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.rHome);
              },
              child: const Text('home'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.rTRANSECTION);
              },
              child: const Text('Transection login'),
            ),
          ],
        ),
      ),
    );
  }
}
