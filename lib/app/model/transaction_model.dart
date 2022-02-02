import 'package:flutter/material.dart';

class TransactionModel {
  late final String id;
  late String category;
  late String dateadded;
  late String image;
  late String rimage;
  late String itemname;
  late String? price;
  late Color? color;
  late String sellerimage;
  late String? shoppurchached;
  late String? personwhoserved;
  late String? note;
  late String? long;
  late String? lat;
  late String warrantytill;
  late String warrantyyearcount;
  late bool isarchived;
  late int timeadded;
  late String uid;
  late bool isShared;

  TransactionModel(
      {required this.category,
      required this.dateadded,
      required this.image,
      required this.rimage,
      required this.itemname,
      required this.uid,
      this.price,
      this.color,
      required this.sellerimage,
      this.shoppurchached,
      this.personwhoserved,
      this.note,
      this.long,
      this.lat,
      required this.warrantytill,
      required this.warrantyyearcount,
      required this.isarchived,
      required this.timeadded,
      required this.isShared});

  TransactionModel.fromJson(Map<dynamic, dynamic> json, String docid) {
    id = docid;
    uid = json['uid'];
    category = json['category'];
    dateadded = json['dateadded'];
    image = json['image'];
    isShared = json['isShared'];
    rimage = json['rimage'];
    itemname = json['itemname'];
    price = json['price'];
    color = json['color'];
    sellerimage = json['sellerimage'];
    shoppurchached = json['shoppurchached'];
    personwhoserved = json['personwhoserved'];
    note = json['note'];
    long = json['long'];
    lat = json['lat'];
    warrantytill = json['warrantytill'];
    warrantyyearcount = json['warrantyyearcount'];
    isarchived = json['isarchived'];
    timeadded = json['timeadded'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['uid'] = uid;
    _data['category'] = category;
    _data['dateadded'] = dateadded;
    _data['image'] = image;
    _data['rimage'] = rimage;
    _data['itemname'] = itemname;
    _data['price'] = price;
    _data['isShared'] = isShared;

    _data['color'] = color;
    _data['sellerimage'] = sellerimage;
    _data['shoppurchached'] = shoppurchached;
    _data['personwhoserved'] = personwhoserved;
    _data['note'] = note;
    _data['long'] = long;
    _data['lat'] = lat;
    _data['warrantytill'] = warrantytill;
    _data['warrantyyearcount'] = warrantyyearcount;
    _data['isarchived'] = isarchived;
    _data['timeadded'] = timeadded;
    return _data;
  }
}
