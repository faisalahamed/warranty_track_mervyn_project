import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/warranty/controller/warranty_controller.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_widget.dart/warranty_appbar.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_widget.dart/warranty_item.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';

class WarrantyScreen extends GetView<WarrantyController> {
  const WarrantyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // WarrantyController controller = Get.find();

    final Stream _api = FirebaseConf().fref.child("Details").onValue;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: WarrantyAppbar(),
      ),
      body: StreamBuilder(
        stream: _api,
        builder: (context, AsyncSnapshot<dynamic> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snap.hasData && snap.data.snapshot.value != null) {
            List<TransactionModel> _translist = [];
            Map data = snap.data.snapshot.value;
            data.forEach((key, value) {
              _translist.add(TransactionModel.fromJson(value, key));
            });

            return Obx(() {
              controller.filteredListCalculation(_translist);

              return controller.itemModelList.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.itemModelList.length,
                      itemBuilder: (context, index) {
                        return WarrantyItem(
                          item: controller.itemModelList[index],
                        );
                      })
                  : SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Image.asset(
                        AppImages.dnf,
                      ),
                    );
            });
          } else {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                AppImages.dnf,
              ),
            );
          }
        },
      ),
    );
  }
}
