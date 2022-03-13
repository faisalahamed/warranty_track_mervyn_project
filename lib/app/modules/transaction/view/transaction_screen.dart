import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_list_page_controller.dart';
import 'package:warranty_track/common/transaction_list_widget.dart';
import 'package:warranty_track/common/category_filter_dialogue.dart';
import 'package:warranty_track/common/constants.dart';

class TransactionListPage extends GetWidget<TransactionListController> {
  const TransactionListPage({Key? key}) : super(key: key);

  categoryWiseFilterDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CategoryFilterDialogue(func: (value) {
            controller.searchCategory.value = value;
            // controller.search();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text("Transactions"),
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            actions: appbarIcon(context),
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              indicatorColor: AppColor.lightPrimarycolor,
              onTap: (tab) {
                // final index = DefaultTabController.of(context).index;
                // print(DefaultTabController.of(context).index??'a');

                controller.selectedTab.value = tab;
              },
              tabs: [
                Tab(text: "Global", icon: Icon(Icons.public)),
                Tab(
                    text: "My Transactions",
                    icon: Icon(Icons.list_alt_outlined)),
                Tab(text: "My Shares", icon: Icon(Icons.share_outlined)),
              ],
            ),
            // title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Obx(
                () => controller.globalTransactionStreamList.value.length != 0
                    ? TransactionListWidget(
                        translist: controller.globalTransactionStreamList.value,
                        isReport: true,
                        isEdit: false,
                      )
                    : SizedBox(
                        child: Image.asset(
                          AppImages.dnf,
                        ),
                      ),
              ),
              Obx(
                () => controller.transactionStreamList.value.length != 0
                    ? TransactionListWidget(
                        translist: controller.transactionStreamList.value)
                    : SizedBox(
                        child: Image.asset(
                          AppImages.dnf,
                        ),
                      ),
              ),
              Obx(
                () => controller.getSharedList().length != 0
                    ? TransactionListWidget(
                        translist: controller.getSharedList())
                    : SizedBox(
                        child: Image.asset(
                          AppImages.dnf,
                        ),
                      ),
              ),
              // Icon(Icons.directions_transit, size: 350),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> appbarIcon(BuildContext context) {
    return [
      Obx(() => controller.selectedTab.value != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: GestureDetector(
                onTap: () {
                  // TODO: Date filter
                  // categoryWiseFilterDialogue(context);
                },
                child: Image(
                  image: AssetImage(AppIcons.filter),
                  color: Colors.white,
                ),
              ),
            )
          : SizedBox()),
      const SizedBox(
        width: 20,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: GestureDetector(
          onTap: () {
            // TODO: Date filter
            // dateWiseFilterDialogue();
          },
          child: Image(
            image: AssetImage(AppIcons.calendar),
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(
        width: 20,
      ),
    ];
  }
}
