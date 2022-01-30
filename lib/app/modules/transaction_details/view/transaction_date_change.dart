import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_detail_screen.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/date_time_calculation.dart';

class TranseactionWarrantyDate extends StatefulWidget {
  final Function func;
  final TransactionModel transectionItem;

  const TranseactionWarrantyDate(
      {Key? key, required this.func, required this.transectionItem})
      : super(key: key);

  @override
  _TranseactionWarrantyDateState createState() =>
      _TranseactionWarrantyDateState();
}

class _TranseactionWarrantyDateState extends State<TranseactionWarrantyDate> {
  // String _warrantyYear = '22';
  String selectedVlue = '1';
  String selectedDate = '';

  @override
  void initState() {
    selectedVlue = widget.transectionItem.warrantyyearcount;
    selectedDate = widget.transectionItem.warrantytill;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Edit Warranty',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ListTile(
                      title: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Center(
                            child: Text(
                              selectedVlue,
                              style: TextStyle(
                                  color: AppColor.textSecondarycolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: const TextStyle(color: Colors.blue),
                          items: AppConstants.dropdownYear.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: ListTile(title: Text(val)),
                              );
                            },
                          ).toList(),
                          onChanged: (String? val) {
                            setState(() {
                              // val != null ? _warrantyYear = val : null;
                              val != null ? selectedVlue = val : null;
                            });
                            if (val != 'Lifetime') {
                              DateTime t = DateTime.now();

                              var newDate = DateTime(
                                  t.year + int.parse(val!), t.month, t.day);
                              selectedDate =
                                  newDate.millisecondsSinceEpoch.toString();
                            } else {
                              selectedDate = "Lifetime";
                            }
                            // setState(() {});
                          },
                        ),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Year'),
                      ),
                      trailing: Column(
                        children: [
                          Expanded(
                            child: Text(
                              selectedVlue != 'Lifetime'
                                  ? MyDateCalculation()
                                      .timestampToDate(selectedDate)
                                  : 'Lifetime',
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                (states) => AppColor.primaryColor,
                              )),
                              child: const Text('Change Date'),
                              onPressed: () {
                                // homeScreenController
                                //     .warrantyTillDate.text = 'adsf';

                                _selectDate(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            // SizedBox(
            //   width: 320.0,
            //   child: GestureDetector(
            //     onTap: () {
            //       // widget.func(selectedStringList);
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    FirebaseConf().updateTransaction(widget.transectionItem.id,
                        'warrantyyearcount', selectedVlue);
                    FirebaseConf().updateTransaction(widget.transectionItem.id,
                        'warrantytill', selectedDate);
                    widget.transectionItem.warrantyyearcount = selectedVlue;
                    widget.transectionItem.warrantytill = selectedDate;
                    // Navigator.pop(context);
                    // Get.to(() => TransactionDetailScreen(
                    // transectionItem: widget.transectionItem));
                    // Get.to(() => const TransactionScreen());
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TransactionDetailScreen(
                            transectionItem: widget.transectionItem)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.accentcolor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    // int intitialDate = int.parse(homeScreenController.warrantyTillDate.text);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate != 'Lifetime'
            ? DateTime.fromMillisecondsSinceEpoch(int.parse(selectedDate))
            : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2120));
    if (pickedDate == null) {
      // return DateTime.fromMillisecondsSinceEpoch(intitialDate);
      selectedDate = selectedDate.toString();
    } else {
      setState(() {
        selectedDate = pickedDate.millisecondsSinceEpoch.toString();
      });
    }
  }
}
