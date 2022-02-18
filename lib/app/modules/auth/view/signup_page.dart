import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/controller/signup_controller.dart';

import 'package:warranty_track/common/constants.dart';
// import 'package:mervyn_project/screens/login_screen.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  Widget textFieldContainer(
      {String? title,
      TextEditingController? controll,
      TextInputType? textInputType}) {
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
    // SignUpController signUpController = Get.find();

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
                    'Register',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                textFieldContainer(
                    title: 'Enter First Name', controll: controller.fNameTec),
                textFieldContainer(
                    title: 'Enter Last Name', controll: controller.lNameTec),
                textFieldContainer(
                    title: 'Enter Email ID', controll: controller.emailTec),
                textFieldContainer(
                  title: 'Enter Password',
                  controll: controller.passwordTec,
                ),
                InkWell(
                  onTap: () {
                 
                    controller.createUser();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.textSecondarycolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have an Account? "),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => AppColor.primaryColor,
                      )),
                      child: const Text('Login'),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        Get.back();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
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
