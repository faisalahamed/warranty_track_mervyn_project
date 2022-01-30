import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/common/helper.dart';

class SignUpPage extends GetView<LoginController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "SignUp",
          ),
          centerTitle: true,
          backgroundColor: Get.theme.colorScheme.secondary,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: const Text('Signup'),
              onPressed: () {
                controller.email.text = 'faisal.hye@gmail.com';
                controller.password.text = '1234567';
                controller.register();
              },
            ),
            ElevatedButton(
              child: const Text('To Login Page'),
              onPressed: () {
                Get.toNamed(Routes.rLOGIN);
              },
            )
          ],
        ),
      ),
    );
  }
}
