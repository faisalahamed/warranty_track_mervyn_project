import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/transaction/view/widgets/transaction_card_widget.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_detail_screen.dart';

class PublicTransactionListWidget extends StatelessWidget {
  final List<TransactionModel> translist;

  final bool isReport;
  final bool isEdit;
  const PublicTransactionListWidget(
      {Key? key,
      required this.translist,
      this.isReport = false,
      this.isEdit = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    // List<Color> _rendColor = [
    //   AppColor.successColor,
    //   AppColor.secondaryColor,
    //   Colors.blue,
    // ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 3),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: translist.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              print('edit');
              isEdit
                  ? Get.to(
                      () => TransactionDetailScreen(
                        transectionItem: translist[index],
                      ),
                    )
                  : null;
            },
            child: TransactionCardWidget(transaction: translist[index]));
      },
    );
  }

  CachedNetworkImage transactionImage(int index, Size size) {
    return CachedNetworkImage(
      imageUrl: translist[index].image == "null"
          ? translist[index].rimage
          : translist[index].image,
      placeholder: (context, url) => Container(
        color: Colors.black12,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: size.height,
      width: 140,
      fit: BoxFit.cover,
    );
  }
}
