import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warranty_track/common/common.dart';
import 'package:warranty_track/common/constants.dart';

class DateFilterDialogue extends StatefulWidget {
  final Function func;

  const DateFilterDialogue({Key? key, required this.func}) : super(key: key);

  @override
  _DateFilterDialogueState createState() => _DateFilterDialogueState();
}

class _DateFilterDialogueState extends State<DateFilterDialogue> {
  DateTime? selectedEndDate;
  DateTime? selectedStartDate;

  void _selectDate(BuildContext context, String whatDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(
          days: 365,
        )));

    if (whatDate == "start") {
      if (picked != null) {
        setState(() {
          selectedStartDate = picked;
        });
      }
    } else {
      if (picked != null) {
        setState(() {
          selectedEndDate = picked;
        });
      }
    }
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
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Choose Date',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _selectDate(context, 'start');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedStartDate == null
                          ? 'Select Start Date'
                          : DateFormat("dd-MM-yyyy").format(selectedStartDate!),
                      style: const TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    Image(
                      image: AssetImage(AppIcons.calendar),
                      width: 25,
                      fit: BoxFit.contain,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () {
                _selectDate(context, 'end');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedEndDate == null
                          ? 'Select End Date'
                          : DateFormat("dd-MM-yyyy").format(selectedEndDate!),
                      style: const TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    Image(
                      image: AssetImage(AppIcons.calendar),
                      width: 25,
                      fit: BoxFit.contain,
                      color: Colors.black38,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 320.0,
              child: GestureDetector(
                onTap: () {
                  if (selectedStartDate!.isAfter(selectedEndDate!)) {
                    CommonFunc().customSnackbar(
                        msg: "Please Choose Date in proper sequence",
                        isTrue: false);
                  } else {
                    widget.func(selectedStartDate, selectedEndDate);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
