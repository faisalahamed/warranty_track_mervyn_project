import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/common/constants.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  Widget textFieldContainer({
    String? title,
    TextEditingController? controll,
    TextInputType? textInputType,
    bool obscure = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: controll,
        obscureText: obscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title!,
          hintStyle: TextStyle(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginController loginController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(size.width, 50.0)),
              color: AppColor.primaryColor,
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: size.height * 0.22, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                textFieldContainer(
                    title: 'Enter Email ID', controll: loginController.email),
                textFieldContainer(
                  title: 'Enter Password',
                  controll: loginController.password,
                  obscure: true,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text('Forgot Password?'),
                //     ElevatedButton(
                //       style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.resolveWith(
                //         (states) => AppColor.primaryColor,
                //       )),
                //       child: const Text('Click Here'),
                //       onPressed: () {},
                //     ),
                //   ],
                // ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    // print(userController.emailInput.text);
                    // print(userController.passwordInput.text);
                    controller.login();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.textSecondarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    AuthService _authService = Get.find();
                    await _authService.signInWithGoogle();
                  },
                  child: Container(
                    color: Colors.grey[200],
                    margin: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 10),
                    child: ListTile(
                      title: Text(
                        'Google',
                        style: TextStyle(color: AppColor.textSecondarycolor),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: Image.asset('assets/icons/google.png'),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't Have an Account ? "),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => AppColor.primaryColor,
                      )),
                      child: const Text('Register'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        Get.toNamed(Routes.rREGISTER);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                // ElevatedButton(
                //   child: const Text('transection'),
                //   onPressed: () {
                //     Get.toNamed(Routes.rTRANSECTION);
                //   },
                // )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.07),
                child: Image(
                  image: AssetImage(
                    AppImages.appLogo,
                  ),
                  width: 90,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
