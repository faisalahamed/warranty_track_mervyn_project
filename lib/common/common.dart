import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/common/constants.dart';

class CommonFunc {
  void customSnackbar({required String msg, required bool isTrue}) {
    Get.snackbar("Alert!!!", msg,
        backgroundColor: isTrue ? AppColor.secondaryColor : Colors.red,
        colorText: isTrue ? AppColor.primaryColor : Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 10,
        margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15));
  }

  void customSuccessSnackbar({required String msg, required bool isTrue}) {
    Get.snackbar(
      "Successfully Submited!!!!",
      msg,
      backgroundColor: isTrue ? AppColor.secondaryColor : Colors.green[200],
      colorText: isTrue ? AppColor.primaryColor : Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 40, left: 15, right: 15),
      onTap: (GetSnackBar snackBar) {
        // Get.to(
        //   () => const TransactionView(),
        // );
        Get.toNamed(Routes.rTRANSECTION);

      },
      duration: const Duration(seconds: 3),
      // titleText: Text('View Your Submission '),
      // messageText: Text('message text'),
      messageText: RichText(
        text: TextSpan(
            text: 'View Your Submission ',
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'here.',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColor.primaryColor,
                    fontSize: 18),
              )
            ]),
      ),
    );
  }
}
