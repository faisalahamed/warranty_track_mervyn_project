import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
// import 'package:warranty_track/app/modules/transaction/controller/transaction_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_detail_screen.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/category_filter_dialogue.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/date_filter_dialogue.dart';

class TransactionListWidget extends StatelessWidget {
  // List<String> selectedCategories = [];
  List<TransactionModel> translist = [];
  TransactionListWidget({Key? key, required this.translist}) : super(key: key);

  // DateTime? _start;
  // DateTime? _end;

  // AuthService _authService = Get.find();

  // categoryWiseFilterDialogue() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CategoryFilterDialogue(func: (value) {
  //           selectedCategories = value;
  //           setState(() {});
  //         });
  //       });
  // }

  // dateWiseFilterDialogue() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return DateFilterDialogue(func: (DateTime? start, DateTime? end) {
  //           _start = start;
  //           _end = end;
  //           setState(() {});
  //         });
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // final Stream _api = FirebaseConf()
    //     .fref
    //     .ref
    //     .child("Details")
    //     .orderByChild('uid')
    //     .equalTo(_authService.user!.uid)
    //     // .orderByChild('isShared')
    //     // .equalTo(true)
    //     .onValue;
    List<Color> _rendColor = [
      AppColor.successColor,
      AppColor.secondaryColor,
      Colors.blue,
    ];

    // transactionController.addintorxlist(_translist);
    return SingleChildScrollView(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 3),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: translist.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                () => TransactionDetailScreen(
                  transectionItem: translist[index],
                ),
              );
            },
            child: Container(
              height: size.height * 0.15,
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
                                      DateTime.parse(
                                          translist[index].dateadded)),
                                  style: TextStyle(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                Text(
                                  DateFormat("hh : mm a").format(DateTime.parse(
                                      translist[index].dateadded)),
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
                  CachedNetworkImage(
                    imageUrl: translist[index].image == "null"
                        ? translist[index].rimage
                        : translist[index].image,
                    placeholder: (context, url) => Container(
                      color: Colors.black12,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: size.height,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
