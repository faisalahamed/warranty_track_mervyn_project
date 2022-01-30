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
        height: size.height * 0.15,
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(colors: [
            // AppColor.gradient1,
            AppColor.gradient2,
            AppColor.gradient3,
            AppColor.gradient4,
          ]),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              // spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 4),
                      child: Align(
                        // color: Colors.grey,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.itemname,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.textSecondarycolor,
                          ),
                        ),
                      ),
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
           
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  // Warranty Count
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textDesign(item.warrantyyearcount, false),
                        const SizedBox(height: 10),
                        textDesign('Year', true)
                      ],
                    ),
                  ),
                  // Warranty Till
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textDesign(
                            MyDateCalculation()
                                .timestampToDate(item.warrantytill),
                            false),
                        const SizedBox(height: 10),
                        textDesign('Date', true)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: MyDateCalculation()
                                  .remainingDays(item.warrantytill),
                              style: TextStyle(
                                color: int.tryParse(MyDateCalculation()
                                                .remainingDays(
                                                    item.warrantytill)) !=
                                            null &&
                                        int.tryParse(MyDateCalculation()
                                                .remainingDays(
                                                    item.warrantytill))! >
                                            0
                                    ? AppColor.successColor
                                    : AppColor.dangerColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: MyDateCalculation()
                                          .remainingDays(item.warrantytill) !=
                                      "Lifetime"
                                  ? ' Days'
                                  : null,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        textDesign('Remaining', true)
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Text textDesign(String val, bool isStyle) {
    return Text(
      val,
      style: isStyle
          ? const TextStyle(fontSize: 12)
          : const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
