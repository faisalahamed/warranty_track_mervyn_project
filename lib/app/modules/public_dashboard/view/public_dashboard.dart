import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warranty_track/app/modules/public_dashboard/controller/public_controller.dart';
import 'package:warranty_track/common/constants.dart';

class PublicDashboard extends GetView<PublicController> {
  const PublicDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: SizedBox()
    );
  }
}
