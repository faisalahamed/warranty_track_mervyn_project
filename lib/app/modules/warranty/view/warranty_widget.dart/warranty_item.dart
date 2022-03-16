import 'package:flutter/material.dart';

import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_widget.dart/show_archive_modal.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/date_time_calculation.dart';

class WarrantyItem extends StatelessWidget {
  final TransactionModel item;
  const WarrantyItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * 0.10,
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // gradient: LinearGradient(colors: [
          //   // AppColor.gradient1,
          //   AppColor.gradient2,
          //   AppColor.gradient3,
          //   AppColor.gradient4,
          // ]),
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey,
          //     // spreadRadius: 1,
          //     blurRadius: 1,
          //   ),
          // ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Center(child: textDesign(item.itemname)),
            ),
            Expanded(
              flex: 1,
              child: Center(child: textDesign(item.warrantyyearcount)),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: textDesign(
                  MyDateCalculation().timestampToDate(item.warrantytill),
                ),
              ),
            ),
            // Days count
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textDesign(
                          MyDateCalculation().remainingDays(item.warrantytill),
                        ),
                        Text('Days'),
                      ],
                    ),
                  ),
                  // Show Archive icon
                  MyDateCalculation()
                          .showArchive(item.warrantytill, item.isarchived)
                      ? Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.archive_outlined,
                                color: AppColor.dangerColor,
                              ),
                              onPressed: () {
                                archiveDialogue(context,
                                    'Do you really want to Archive It?', () {
                                  item.isarchived = true;
                                  // FirebaseConf().updateTransactionArchive(item);
                                  FirebaseConf().updateTransaction(
                                      item.id, 'isarchived', item.isarchived);
                                });
                              },
                            ),
                          ))
                      // : const Expanded(flex: 1, child: SizedBox()),
                      : const SizedBox(),
                  // Show UnArchive icon
                  MyDateCalculation()
                          .showUnArchive(item.warrantytill, item.isarchived)
                      ? Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                Icons.unarchive_outlined,
                                color: AppColor.accentcolor,
                              ),
                              onPressed: () {
                                archiveDialogue(context,
                                    'Do you really want to UnArchive It?', () {
                                  item.isarchived = false;
                                  // FirebaseConf().updateTransactionArchive(item);
                                  FirebaseConf().updateTransaction(
                                      item.id, 'isarchived', item.isarchived);
                                });
                              },
                            ),
                          ))
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ));
  }

  Padding textDesign(String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
      child: Text(
        val,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis),
        maxLines: 2,
      ),
    );
  }

  archiveDialogue(BuildContext context, String msg, Function archiveFunction) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ShowArchiveModal(message: msg, func: archiveFunction);
        });
  }
}
