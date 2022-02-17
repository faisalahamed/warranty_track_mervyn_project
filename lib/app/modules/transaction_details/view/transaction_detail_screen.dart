// ignore_for_file: unused_field

import 'dart:io';

// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';

// ignore: unused_import
import 'package:carousel_slider/carousel_slider.dart';

// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warranty_track/app/model/transaction_model.dart';
import 'package:warranty_track/app/modules/settings/controller/settings_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/transaction_details_controller.dart';
import 'package:warranty_track/app/modules/transaction_details/view/edit_map_location.dart';
import 'package:warranty_track/app/modules/transaction_details/view/transaction_date_change.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/date_time_calculation.dart';
import 'package:warranty_track/common/delete_alert_dialogue.dart';
import 'package:warranty_track/common/edit_category_dialogue.dart';
import 'package:warranty_track/common/slider_widget.dart';

// ignore: must_be_immutable
class TransactionDetailScreen extends StatefulWidget {
  TransactionModel transectionItem;

  TransactionDetailScreen({Key? key, required this.transectionItem})
      : super(key: key);

  @override
  _TransactionDetailScreenState createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  TextEditingController priceTec = TextEditingController();
  TextEditingController categoryTec = TextEditingController();
  TextEditingController descriptionTec = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController shopPurchached = TextEditingController();
  TextEditingController personWhoServed = TextEditingController();
  SettingsController _settingsController = SettingsController();

  final picker = ImagePicker();
  File? _image;
  File? _rImage;
  File? _sImage;
  String? fireImage;
  String? _price;
  String? _category;
  String? _itemname;
  String? _note;
  String? _shopname;
  String? _personwhoserved;
  late String _warrantytill;
  late String _warrantycount;
  // LocationData? _locationData;
  late int _current;

  TransactionDetailsController transactionController =
      TransactionDetailsController();

  List<String> sliderImages = [];

  deleteAlertDialogue(String id, Function remove) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DeleteAlertDialogue(
              msg: 'Do you want to delete Transaction?',
              func: () {
                transactionController.deleteCategoryData(id: id);
                remove();
              });
        });
  }

  Future getImage(
      {String? title,
      required ImageSource imageSource,
      required int index}) async {
    final pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 15);

    if (pickedFile != null) {
      if (index == 0) {
        _image = File(pickedFile.path);

        FirebaseConf().uploadImageAndGetUrl(_image, (String url) {
          fireImage = url;
        }).then((_) {
          FirebaseConf().updateTransaction(
              widget.transectionItem.id, 'rimage', fireImage!);
        });

        sliderImages[0] = _image!.path;
        setState(() {});
      } else if (index == 1) {
        _rImage = File(pickedFile.path);
        FirebaseConf().uploadImageAndGetUrl(_rImage, (String url) {
          fireImage = url;
        }).then((_) {
          FirebaseConf().updateTransaction(
              widget.transectionItem.id, 'image', fireImage!);
        });
        sliderImages[1] = _rImage!.path;
        setState(() {});
      } else if (index == 2) {
        _sImage = File(pickedFile.path);
        FirebaseConf().uploadImageAndGetUrl(_sImage, (String url) {
          fireImage = url;
        }).then((_) {
          FirebaseConf().updateTransaction(
              widget.transectionItem.id, 'sellerimage', fireImage!);
        });
        sliderImages[2] = _sImage!.path;
        setState(() {});
      }
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<void> showImagePickerOption(int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 3,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery Image'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(imageSource: ImageSource.gallery, index: index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  getImage(imageSource: ImageSource.camera, index: index);
                },
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          );
        });
  }

  categoryWiseFilterDialogue({required bool isEdit}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditCategoryDialogue(
              selectedCat: widget.transectionItem.category,
              func: (value) {
                FirebaseConf().updateTransaction(
                    widget.transectionItem.id, 'category', value);
                _category = value;
                setState(() {});
              });
        });
  }

  showEditModelSheet(
      {required TextEditingController? controller, required String title}) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 3,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: TextField(
                      controller: controller!,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseConf().updateTransaction(
                        widget.transectionItem.id, title, controller.text);
                    if (title == 'price') {
                      // controller.
                      _settingsController
                          .onEditupdateShareStatusOfTransaction();
                      _price = controller.text;
                    } else if (title == 'category') {
                      _category = controller.text;
                    } else if (title == 'itemname') {
                      _itemname = controller.text;
                    } else if (title == 'shoppurchached') {
                      _shopname = controller.text;
                    } else if (title == 'personwhoserved') {
                      _personwhoserved = controller.text;
                    } else if (title == 'note') {
                      _note = controller.text;
                    }
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.textSecondarycolor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Widget detailContainer(
      {required String title,
      required String value,
      required Function() onTap}) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  onTap: onTap,
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                value != 'RM null' ? value : 'RM 0.00',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  warrantyFilterDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return TranseactionWarrantyDate(
            transectionItem: widget.transectionItem,
            func: () {},
          );
        });
  }

  // showEditWarrantyDate(BuildContext ct) {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
  //       ),
  //       isScrollControlled: true,
  //       context: ct,
  //       builder: (ct) {
  //         return Padding(
  //           padding: MediaQuery.of(ct).viewInsets,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               const SizedBox(
  //                 height: 25,
  //               ),
  //               Container(
  //                 height: 3,
  //                 width: 70,
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey,
  //                   borderRadius: BorderRadius.circular(100),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               const Text(
  //                 'Change Warranty Year',
  //                 style: TextStyle(
  //                   color: Colors.black54,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               TransactionDateChange(),
  //               GestureDetector(
  //                 onTap: () {
  //                   // FirebaseConf().updateTransaction(
  //                   //     widget.transectionItem.id, title, controller.text);
  //                   // if (title == 'price') {
  //                   //   _price = controller.text;
  //                   // } else if (title == 'category') {
  //                   //   _category = controller.text;
  //                   // } else if (title == 'itemname') {
  //                   //   _itemname = controller.text;
  //                   // } else if (title == 'shoppurchached') {
  //                   //   _shopname = controller.text;
  //                   // } else if (title == 'personwhoserved') {
  //                   //   _personwhoserved = controller.text;
  //                   // } else if (title == 'note') {
  //                   //   _note = controller.text;
  //                   // }
  //                   // Navigator.pop(context);
  //                   // setState(() {});
  //                 },
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     color: AppColor.secondaryColor,
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   padding: const EdgeInsets.symmetric(
  //                       vertical: 10, horizontal: 25),
  //                   child: Text(
  //                     'Submit',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColor.textSecondarycolor,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  // dateCount({required bool isEdit}) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return EditDate(
  //             selectedCat: widget.transectionItem.category,
  //             func: (value) {
  //               FirebaseConf().updateTransaction(
  //                   widget.transectionItem.id, 'category', value);
  //               _category = value;
  //               setState(() {});
  //             });
  //       });
  // }

  @override
  void initState() {
    _price = widget.transectionItem.price;
    _category = widget.transectionItem.category;
    _itemname = widget.transectionItem.itemname;
    _warrantycount = widget.transectionItem.warrantyyearcount;
    _warrantytill = widget.transectionItem.warrantytill;

    _note =
        widget.transectionItem.note != '' && widget.transectionItem.note != null
            ? widget.transectionItem.note!
            : '(empty)';
    _shopname = widget.transectionItem.shoppurchached != '' &&
            widget.transectionItem.shoppurchached != null
        ? widget.transectionItem.shoppurchached!
        : '(empty)';
    _personwhoserved = widget.transectionItem.personwhoserved != '' &&
            widget.transectionItem.personwhoserved != null
        ? widget.transectionItem.personwhoserved!
        : '(empty)';

    sliderImages.add(widget.transectionItem.rimage);
    // sliderImages.add(widget.transectionItem.image);
    // sliderImages.add(widget.transectionItem.sellerimage);
    // sliderImages.add(widget.catDetail.image);

    widget.transectionItem.image != 'null'
        ? sliderImages.add(widget.transectionItem.image)
        : sliderImages.add('httimageperrerrerr');
    widget.transectionItem.sellerimage != 'null'
        ? sliderImages.add(widget.transectionItem.sellerimage)
        : sliderImages.add('httsellerperrerrerr');

    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    priceTec.dispose();
    categoryTec.dispose();
    descriptionTec.dispose();
    note.dispose();
    shopPurchached.dispose();
    personWhoServed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SliderWidget(
              sliderIma: sliderImages,
              showImagePickerModelSheet: showImagePickerOption,
            ),
            const SizedBox(
              height: 8,
            ),
            detailContainer(
                title: 'Price',
                value: "RM $_price",
                onTap: () {
                  priceTec.text = widget.transectionItem.price ?? '';
                  showEditModelSheet(controller: priceTec, title: 'price');
                }),
            detailContainer(
                title: 'Category',
                value: _category!,
                onTap: () {
                  categoryWiseFilterDialogue(isEdit: true);
                }),
            detailContainer(
                title: 'Item Name',
                value: _itemname!,
                onTap: () {
                  descriptionTec.text = widget.transectionItem.itemname;
                  showEditModelSheet(
                      controller: descriptionTec, title: 'itemname');
                }),
            detailContainer(
                title: 'Shop Purchached',
                value: _shopname!,
                onTap: () {
                  shopPurchached.text =
                      widget.transectionItem.shoppurchached != null
                          ? widget.transectionItem.shoppurchached!
                          : 'null';
                  showEditModelSheet(
                      controller: shopPurchached, title: 'shoppurchached');
                }),
            detailContainer(
                title: 'Person Who Served',
                value: _personwhoserved!,
                onTap: () {
                  personWhoServed.text =
                      widget.transectionItem.personwhoserved != null
                          ? widget.transectionItem.personwhoserved!
                          : '';
                  showEditModelSheet(
                      controller: personWhoServed, title: 'personwhoserved');
                }),
            detailContainer(
                title: 'Note',
                value: _note!,
                onTap: () {
                  note.text = widget.transectionItem.note != null
                      ? widget.transectionItem.note!
                      : '';
                  showEditModelSheet(controller: note, title: 'note');
                }),
            detailContainer(
                title: 'Warranty',
                value:
                    '''${widget.transectionItem.warrantyyearcount} Year      Date: ${MyDateCalculation().timestampToDate(widget.transectionItem.warrantytill)}''',
                onTap: () {
                  // note.text = widget.transectionItem.note != null
                  //     ? widget.transectionItem.note!
                  //     : '';
                  // showEditWarrantyDate(context);
                  // dateCount(isEdit: true);
                  warrantyFilterDialogue(context);
                }),
            detailContainer(
                title: 'Location',
                value: (widget.transectionItem.lat != '0.0' &&
                        widget.transectionItem.long != '0.0')
                    ? '''Latitude: ${widget.transectionItem.lat!.substring(0, 6)}
Longitude: ${widget.transectionItem.long!.substring(0, 6)}'''
                    : '''Latitude: 0.0
Longitude: 0.0''',
                onTap: () {
                  // print('object');
                  // note.text = widget.transectionItem.note != null
                  //     ? widget.transectionItem.note!
                  //     : '';
                  // showEditWarrantyDate(context);
                  // dateCount(isEdit: true);
                  if (widget.transectionItem.lat != null &&
                      widget.transectionItem.long != null) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditMapLocation(
                            item: widget.transectionItem,
                          );
                        });

                    // MapPopupDialog(
                    //     lat: double.parse(widget.transectionItem.lat!),
                    //     long: double.parse(widget.transectionItem.long!));
                  }
                }),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                deleteAlertDialogue(widget.transectionItem.id, () async {
                  await FirebaseConf()
                      .deleteTransaction(widget.transectionItem);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
