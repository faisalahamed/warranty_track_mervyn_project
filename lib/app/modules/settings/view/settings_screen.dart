import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/settings/controller/settings_controller.dart';
// import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/common/constants.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Obx(() => Text(
                        'Current Version ${controller.info.value.version}',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Get.snackbar('Update', 'You are using the Latest Version',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    child: Text('Check Update'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'Share',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              trailing: Obx(
                () => Switch(
                  value: controller.isEnabled.value,
                  onChanged: (bool val) {
                    controller.isEnabled.value = val;
                    controller.updateUserShareStatus();
                    controller.updateShareStatusOfTransaction();
                  },
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Items with price and receipt will be shared.\n',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Your personal identity will not be shared.',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
