import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/category/view/categories_screen.dart';
import 'package:warranty_track/app/modules/feedback/view/feedback_screen.dart';
import 'package:warranty_track/app/modules/settings/view/settings_screen.dart';
import 'package:warranty_track/app/modules/transaction/view/transaction_screen.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_screen.dart';
import 'package:warranty_track/app/routes/routes.dart';
import 'package:warranty_track/common/constants.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff171A73),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(
                            AppConstants.appLogo,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Version 1.0.2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                    )),
              ],
            ),
          ),
          drawerItem(
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          drawerItem(
            title: 'Transactions',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const TransactionView());
            },
          ),
          drawerItem(
            title: 'Exports',
            onTap: () {
              Navigator.pop(context);
              // Get.to(() => const ExportsScreen());
            },
          ),
          drawerItem(
            title: 'Categories',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => CategoriesScreen());
            },
          ),
          drawerItem(
            title: 'Feedback',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const FeedbackScreen());
            },
          ),
          drawerItem(
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              Get.to(() => const SettingsScreen());
            },
          ),
          drawerItem(
            title: 'Warranty',
            onTap: () {
              Navigator.pop(context);
              // Get.to(() => const WarrantyScreen());
              Get.toNamed(Routes.rWARRANTY);
            },
          ),
        ],
      ),
    );
  }

  Widget drawerItem({String? title, Function()? onTap}) {
    return ListTile(
      title: Text(
        title!,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
