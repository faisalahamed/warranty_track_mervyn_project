import 'package:flutter/material.dart';
import 'package:warranty_track/app/model/feedback.dart';
import 'package:warranty_track/common/common.dart';
import 'package:warranty_track/common/constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController nameTec = TextEditingController();
  TextEditingController emailTec = TextEditingController();
  TextEditingController feedbackTec = TextEditingController();

  Widget textFieldContainer({
    String? title,
    TextEditingController? controller,
    TextInputType? textInputType,
    int? maxLines,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title!,
          hintStyle: TextStyle(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameTec.dispose();
    emailTec.dispose();
    feedbackTec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Feedback"),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            textFieldContainer(
              title: 'Name',
              controller: nameTec,
            ),
            textFieldContainer(
              title: 'Email ID',
              controller: emailTec,
            ),
            textFieldContainer(
              title: 'Feedback',
              controller: feedbackTec,
              maxLines: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (nameTec.text.isEmpty) {
                  CommonFunc().customSnackbar(msg: "Enter Name", isTrue: false);
                  return;
                } else if (emailTec.text.isEmpty) {
                  CommonFunc()
                      .customSnackbar(msg: "Enter Email ID", isTrue: false);
                  return;
                } else if (!RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(emailTec.text)) {
                  CommonFunc().customSnackbar(
                      msg: "Enter Valid Email ID", isTrue: false);
                  return;
                } else if (feedbackTec.text.isEmpty) {
                  CommonFunc()
                      .customSnackbar(msg: "Enter Feedback", isTrue: false);
                  return;
                }

                FeedbackMail().sendMailApi(
                  nameTec.text,
                  emailTec.text,
                  feedbackTec.text,
                  () {
                    CommonFunc().customSnackbar(
                        msg: "Feedback Submitted Successfully!!!",
                        isTrue: true);
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                width: size.width - 45,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColor.textSecondarycolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
