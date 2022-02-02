import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/setting_controller.dart';
import 'package:warranty_track/common/constants.dart';

class CategoryFilterDialogue extends StatefulWidget {
  final Function func;

  const CategoryFilterDialogue({Key? key, required this.func})
      : super(key: key);

  @override
  _CategoryFilterDialogueState createState() => _CategoryFilterDialogueState();
}

class _CategoryFilterDialogueState extends State<CategoryFilterDialogue> {
  HomeViewController homeScreenController = HomeViewController();
  // final Stream _api =
  //     FirebaseDatabase.instance.reference().child("Categories").onValue;
  late int previousIndex;

  List<String> selectedStringList = [];

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
                'Select Category',
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
            GetX<TransactionDetailsController>(builder: (cont) {
              if (cont.catListRx.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    shrinkWrap: true,
                    itemCount: cont.catListRx.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            cont.catListRx[index].isSelected =
                                !cont.catListRx[index].isSelected;
                          });
                          if (cont.catListRx[index].isSelected) {
                            selectedStringList
                                .add(cont.catListRx[index].catName);
                          } else {
                            selectedStringList.remove(cont.catListRx[index].id);
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: cont.catListRx[index].isSelected
                                  ? Colors.blue[200]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                            child: Text(cont.catListRx[index].catName)),
                      );
                    });
              } else {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                    AppImages.dnf,
                  ))),
                );
              }
            }),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 320.0,
              child: GestureDetector(
                onTap: () {
                  widget.func(selectedStringList);

                  Navigator.pop(context);
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
