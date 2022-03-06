import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  TextEditingController nameTec = TextEditingController();
  TextEditingController emailTec = TextEditingController();
  TextEditingController feedbackTec = TextEditingController();
  var isSending = false.obs;

  @override
  void onClose() {
    nameTec.dispose();
    emailTec.dispose();
    feedbackTec.dispose();
    super.onClose();
  }
}
