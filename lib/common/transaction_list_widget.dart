import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_detail_screen.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';

class TransactionListWidget extends StatelessWidget {
  final List<TransactionModel> translist;

  final bool isReport;
  final bool isEdit;
  const TransactionListWidget(
      {Key? key,
      required this.translist,
      this.isReport = false,
      this.isEdit = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Color> _rendColor = [
      AppColor.successColor,
      AppColor.secondaryColor,
      Colors.blue,
    ];

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
          child: Container(
            // height: size.height * 0.15,
            height: 120,
            margin: const EdgeInsets.symmetric(vertical: 3),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat("dd-MM-yyyy").format(
                                    DateTime.parse(translist[index].dateadded)),
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              Text(
                                DateFormat("hh : mm a").format(
                                    DateTime.parse(translist[index].dateadded)),
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          translist[index].itemname,
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxWidth: 125.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _rendColor[
                                      Random().nextInt(_rendColor.length)],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                child: Text(
                                  translist[index].category,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                  translist[index].price == ""
                                      ? "RM  0.00"
                                      : "RM  ${translist[index].price}",
                                  style: TextStyle(
                                    color: translist[index].color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: transactionImage(index, size)),
                      isReport
                          ? Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    print(translist[index].itemname);
                                    Get.defaultDialog(
                                      title: "Report this Transaction",
                                      content: ListTile(
                                        title: Text('Name: ' +
                                            translist[index].itemname),
                                        subtitle: Text('Price: ' +
                                            translist[index].price.toString()),
                                        trailing: SizedBox(
                                          height: 50,
                                          width: 80,
                                          child: transactionImage(index, size),
                                        ),
                                      ),
                                      cancel: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColor.primaryColor)),
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      confirm: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    AppColor.secondaryColor)),
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          // TODO: send email of spam
                                          // FeedbackMail().sendSpamApi(
                                          //   itemname: translist[index].itemname,
                                          //   done: () {
                                          //     CommonFunc().customSnackbar(
                                          //         msg:
                                          //             "Email send successfully!!!",
                                          //         isTrue: true);
                                          //   },
                                          // );

                                          // Update User report Counter
                                          if (translist[index].reportcount ==
                                              4) {
                                            FirebaseConf()
                                                .updateUserReportCounter(
                                                    translist[index].uid);
                                          }

                                          // Update database of report
                                          FirebaseConf().updateTransaction(
                                              translist[index].id,
                                              'reportcount',
                                              translist[index].reportcount + 1);
                                          Get.back();
                                          Get.snackbar('Thanks',
                                              'Spam Reported Successfully',
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: Colors.grey);
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.report_gmailerrorred),
                                  color: AppColor.dangerColor),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
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
