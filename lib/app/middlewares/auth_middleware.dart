import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/app/service/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  //  GetStorage _box;
  // @override
  // RouteSettings redirect(String route) {
  //   final authService = Get.find<AuthService>();
  //   if (!authService.isAuth) {
  //     return RouteSettings(name: Routes.LOGIN);
  //   }
  //   return null;
  // }
  @override
  RouteSettings? redirect(String? route) {
    AuthService authService = Get.find();
    // authService.getCurrentUser();
    // print('auth middleware called===================');
    if (authService.firebaseUser.value == null) {
      return const RouteSettings(name: Routes.rLOGIN);
    }
    return null;
  }

}
