import 'package:flutter/material.dart';
import 'package:warranty_track/common/constants.dart';

class SettingsScreen extends StatelessWidget {
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
      body: const Center(
        child: Text('Coming Soon...'),
      ),
    );
  }
}
