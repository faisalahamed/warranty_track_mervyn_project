import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:warranty_track/app/modules/transaction/controller/transaction_list_page_controller.dart';
import 'package:warranty_track/app/modules/transaction/view/transaction_list_widget.dart';
import 'package:warranty_track/common/constants.dart';

class TransactionListPage extends GetWidget<TransactionListController> {
  const TransactionListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text("Transactions"),
            backgroundColor: AppColor.primaryColor,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Date filter
                    // categoryWiseFilterDialogue();
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
            ],
            bottom: TabBar(
              indicatorColor: AppColor.lightPrimarycolor,
              tabs: [
                Tab(
                    text: "My Transactions",
                    icon: Icon(Icons.list_alt_outlined)),
                Tab(
                    text: "Shared Transactions",
                    icon: Icon(Icons.share_outlined)),
              ],
            ),
            // title: Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              TransactionListWidget(),
              Icon(Icons.directions_transit, size: 350),
            ],
          ),
        ),
      ),
    );
  }
}
