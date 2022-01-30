// class ItemModel {
//   late String itemname;
//   late String warrantytill;
//   late String? image;
//   late int timeadded;
//   late bool isarchived;

//   late String id;

//   ItemModel({
//     required this.itemname,
//     required this.warrantytill,
//     required this.timeadded,
//     required this.isarchived,
//     this.image,
//   });

//   ItemModel.fromJson(Map<dynamic, dynamic> json, String docid) {
//     itemname = json['itemname'];
//     warrantytill = json['warrantytill'];
//     image = json['image'];
//     timeadded = json['timeadded'];
//     isarchived = json['isarchived'];
//     id = docid;
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['itemname'] = itemname;
//     _data['warrantytill'] = warrantytill;
//     _data['image'] = image;
//     _data['timeadded'] = timeadded;
//     _data['isarchived'] = isarchived;

//     return _data;
//   }
// }
