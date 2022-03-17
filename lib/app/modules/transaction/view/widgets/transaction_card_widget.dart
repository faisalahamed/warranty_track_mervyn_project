import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warranty_track/app/model/feedback.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/common.dart';
import 'package:warranty_track/common/constants.dart';
// import 'package:warranty_track_web/app/data/transaction_model.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    required this.transaction,
    Key? key,
  }) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    List<Color> _rendColor = [
      const Color(0xff42A460),
      const Color(0xffFFBF2A),
      Colors.blue,
    ];

    return Card(
      color: Colors.white54,
      // margin: EdgeInsets.only(top: 18),
      elevation: 6,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Date Time
                  dateTimeBuilder(),

                  // Item Name
                  const SizedBox(height: 8),
                  itemNameBuilder(),

                  // Shop Purchached
                  const SizedBox(height: 8),
                  subTitleBuilder(
                      title: 'Shop Name: ',
                      subtitle: transaction.shoppurchached != ''
                          ? transaction.shoppurchached
                          : 'Not Available'),

                  // Person Who Served
                  const SizedBox(height: 8),

                  subTitleBuilder(
                      title: 'Served By: ',
                      subtitle: transaction.personwhoserved != ''
                          ? transaction.personwhoserved
                          : 'Not Available'),

                  // Location
                  const SizedBox(height: 18),
                  locationBuilder(),

                  // Category and Price Builder
                  const SizedBox(height: 18),
                  Row(
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: categoryBuilder(_rendColor),
                      ),
                      // Spacer(flex: 2),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: priceBuilder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Image widget
          Expanded(
            flex: 1,
            child: Container(
              height: 200,
              // width: 200,
              color: Colors.grey[300],
              child: CarouselSlider(
                items: _getSlideList(),
                options: CarouselOptions(
                  disableCenter: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageBuilder(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorBuilder: (ctx, obj, trace) {
        return Center(child: Text('Failed to load image'));
      },
    );
  }

  RichText locationBuilder() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: [
          TextSpan(text: "Location: "),
          TextSpan(
              text: double.parse(transaction.lat!).toStringAsFixed(2),
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ', '),
          TextSpan(
              text: double.parse(transaction.long!).toStringAsFixed(2),
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Text priceBuilder() {
    var f = NumberFormat('###,###.00', 'en_US');
    var p = double.tryParse(transaction.price!);
    return Text(p == null ? "RM 0.00" : "RM ${f.format(p)}",
        style: TextStyle(
          color: transaction.color,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        overflow: TextOverflow.ellipsis);
  }

  Container categoryBuilder(List<Color> _rendColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      // width: 140,
      decoration: BoxDecoration(
        color: _rendColor[Random().nextInt(_rendColor.length)],
        borderRadius: BorderRadius.circular(3),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: Center(
        child: Text(
          transaction.category,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }

  RichText subTitleBuilder({required String title, required String? subtitle}) {
    return RichText(
      text: TextSpan(
          text: title,
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
                text: subtitle, style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
    );
  }

  Row itemNameBuilder() {
    return Row(
      children: [
        Expanded(
          child: Wrap(
            children: [
              Text(
                transaction.itemname,
                style: TextStyle(
                  // color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget dateTimeBuilder() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(DateFormat("dd-MM-yyyy")
              .format(DateTime.parse(transaction.dateadded))),
        ),
        // Text(transaction.dateadded),
        // Spacer(flex: 2),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat("hh : mm a")
                    .format(DateTime.parse(transaction.dateadded)),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  print(transaction.itemname);
                  Get.defaultDialog(
                    title: "Report this Transaction",
                    content: ListTile(
                      title: Text('Name: ' + transaction.itemname),
                      subtitle: Text('Price: ' + transaction.price.toString()),
                      trailing: SizedBox(
                        height: 50,
                        width: 80,
                        child: transactionImage(),
                      ),
                    ),
                    cancel: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.primaryColor)),
                      child: const Text('Cancel'),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    confirm: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColor.secondaryColor)),
                      child: const Text('Yes'),
                      onPressed: () {
                        AuthService _auth = Get.find();
                        var email = _auth.getcurrentUserEmail();

                        FeedbackMail().sendSpamApi(
                          reported_by: email,
                          uploader_uid: transaction.uid,
                          // uploader_email: _auth.user.email ?? '',
                          item_name: transaction.itemname,
                          item_reported: transaction.reportcount.toString(),
                          item_price: transaction.price ?? '0.0',
                          item_receipt: transaction.rimage,
                          item_image: transaction.image,
                          done: () {
                            CommonFunc().customSnackbar(
                                msg: "Spam Reported Successfully...!!!",
                                isTrue: true);
                          },
                        );

                        // Update User report Counter
                        if (transaction.reportcount == 4) {
                          FirebaseConf()
                              .updateUserReportCounter(transaction.uid);
                        }

                        // Update database of report
                        FirebaseConf().updateTransaction(transaction.id,
                            'reportcount', transaction.reportcount + 1);
                        Get.back();
                        // Get.snackbar('Thanks', 'Spam Reported Successfully',
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     backgroundColor: Colors.grey);
                      },
                    ),
                  );
                },
                icon: Icon(Icons.report_gmailerrorred),
                color: AppColor.dangerColor),
          ),
        ),
      ],
    );
  }

  List<Widget> _getSlideList() {
    List<Widget> _p = [];

    _p.add(imageBuilder(transaction.rimage));

    if (transaction.image != 'null') {
      _p.add(imageBuilder(transaction.image));
    }

    // if (transaction.sellerimage != 'null') {
    //   _p.add(imageBuilder(transaction.sellerimage));
    // }

    return _p;
  }

  CachedNetworkImage transactionImage() {
    return CachedNetworkImage(
      imageUrl:
          transaction.image == "null" ? transaction.rimage : transaction.image,
      placeholder: (context, url) => Container(
        color: Colors.black12,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: 60,
      width: 140,
      fit: BoxFit.cover,
    );
  }
}
