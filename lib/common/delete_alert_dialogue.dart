import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:get/get.dart';
import 'package:warranty_track/common/constants.dart';

class DeleteAlertDialogue extends StatefulWidget {
  final Function func;
  final String msg;

  const DeleteAlertDialogue({Key? key, required this.func, required this.msg})
      : super(key: key);

  @override
  _DeleteAlertDialogueState createState() => _DeleteAlertDialogueState();
}

class _DeleteAlertDialogueState extends State<DeleteAlertDialogue> {
  Widget btnContainer(
      {required String title,
      required Function() onTap,
      required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Alert!!!",
              style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
            margin: const EdgeInsets.symmetric(vertical: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.msg,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(child: Container()),
              btnContainer(
                  color: AppColor.primaryColor,
                  title: 'Cancel',
                  onTap: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(
                width: 8,
              ),
              btnContainer(
                  color: Colors.red,
                  title: 'Yes',
                  onTap: () {
                    widget.func();
                    if (widget.msg == 'Do you want to delete Transaction?') {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                    }
                  }),
              const SizedBox(
                width: 22,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
