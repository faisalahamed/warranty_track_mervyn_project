import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/auth/controller/login_controller.dart';
import 'package:warranty_track/app/modules/auth/controller/signup_controller.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/transaction_details_controller.dart';
import 'package:warranty_track/app/modules/warranty/controller/warranty_controller.dart';
import 'package:warranty_track/app/routes/pages.dart';
import 'package:warranty_track/app/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthService());
  // await Get.putAsync(() => AuthService().init());
  Get.put(LoginController());
  Get.put(SignUpController());
  Get.put(HomeViewController());
  // Get.put(TransactionController());
  Get.put(TransactionDetailsController());
  Get.put(WarrantyController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'Warranty Track',
      debugShowCheckedModeBanner: false,
      initialRoute: RoutePage.rInitial,
      getPages: RoutePage.routes,
    );
  }
}
