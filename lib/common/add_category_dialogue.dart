import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/setting_controller.dart';

import 'package:warranty_track/common/constants.dart';

class AddCategoryDialogue extends StatefulWidget {
  final Function func;

  const AddCategoryDialogue({Key? key, required this.func}) : super(key: key);

  @override
  _AddCategoryDialogueState createState() => _AddCategoryDialogueState();
}

class _AddCategoryDialogueState extends State<AddCategoryDialogue> {
  SettingController settingController = Get.find();
  List<bool> isSelected = [false, false, false, false, false];

  List<String> selectedStringList = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
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
                'Add Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            Container(
              height: 0.5,
              color: Colors.grey[400],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: settingController.categoryTec,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Category Name',
                  hintStyle: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                settingController.addCategoryDataGet();
                widget.func();
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
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
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
