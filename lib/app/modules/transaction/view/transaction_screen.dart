import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_list_page_controller.dart';
import 'package:warranty_track/app/modules/transaction/view/widgets/public_transaction_list_widget.dart';
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
            centerTitle: true,
            title: const Text("Transactions"),
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            // TODO: implement blow action
            // actions: appbarIcon(context),
            bottom: TabBar(
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              indicatorColor: Colors.white,
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
              tabbarViewBuilder(
                  obxWidget: Obx(
                    () => controller.globalTransactionList.length != 0
                        ? PublicTransactionListWidget(
                            translist: controller.globalTransactionList,
                            isReport: true,
                            isEdit: false,
                          )
                        : SizedBox(
                            child: Image.asset(
                              AppImages.dnf,
                            ),
                          ),
                  ),
                  editingController: controller.globalSearchText,
                  searchFn: controller.globalTransactionsearch,
                  hintText: "Search by Item Name and Shopname"),
              tabbarViewBuilder(
                  obxWidget: Obx(
                    () => controller.transactionList.length != 0
                        ? TransactionListWidget(
                            translist: controller.transactionList)
                        : SizedBox(
                            child: Image.asset(
                              AppImages.dnf,
                            ),
                          ),
                  ),
                  editingController: controller.myTransactionSearchText,
                  searchFn: controller.myTransactionsearch,
                  hintText: "Search by Item Name .."),
              tabbarViewBuilder(
                obxWidget: Obx(
                  () => controller.getSharedList().length != 0
                      ? TransactionListWidget(
                          translist: controller.getSharedList())
                      : SizedBox(
                          child: Image.asset(
                            AppImages.dnf,
                          ),
                        ),
                ),
                editingController: controller.myTransactionSearchText,
                hintText: "Search by Item Name....",
                searchFn: controller.myTransactionsearch,
              )
              // Icon(Icons.directions_transit, size: 350),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView tabbarViewBuilder(
      {required Obx obxWidget,
      required searchFn,
      required TextEditingController editingController,
      String hintText = '',
      bool showtag = false}) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: editingController,
                      decoration: InputDecoration(
                        hintText: hintText,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onChanged: (input) {
                        searchFn();
                      },
                    ),
                  )),
              // Expanded(
              //   flex: 1,
              //   child: SizedBox(
              //     height: 50,
              //     child: Builder(builder: (context) {
              //       return GestureDetector(
              //         onTap: () {
              //           // TODO: Date filter
              //           categoryWiseFilterDialogue(context);
              //         },
              //         child: Image(
              //           image: AssetImage(AppIcons.filter),
              //           color: Colors.blue,
              //         ),
              //       );
              //     }),
              //   ),
              // ),
            ],
          ),
          obxWidget,
        ],
      ),
    );
  }

  List<Widget> appbarIcon(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: GestureDetector(
          onTap: () {
            // TODO: Date filter
            // categoryWiseFilterDialogue(context);
            // controller.
          },
          child: Image(
            image: AssetImage(AppIcons.filter),
            color: Colors.white,
          ),
        ),
      ),
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
