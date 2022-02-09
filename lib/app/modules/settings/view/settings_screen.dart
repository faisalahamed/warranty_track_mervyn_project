import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warranty_track/app/modules/settings/controller/settings_controller.dart';
import 'package:warranty_track/app/service/auth_service.dart';
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
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Version 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {},
                child: Text('Update'),
              ),
            ],
          ),
          ListTile(
            title: Text('Share'),
            trailing: Obx(
              () => Switch(
                value: controller.isEnabled.value,
                onChanged: (bool val) {
                  controller.isEnabled.value = val;
                  controller.updateUserShareStatus();
                  // TODO: Update all user transaction of shared settings

              
                  controller.updateShareStatusOfTransaction();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
