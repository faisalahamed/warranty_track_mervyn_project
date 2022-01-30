class CategoryModel {
  String id;
  String uid;
  String catName;
  int count;
  bool isSelected;

  CategoryModel({
    required this.id,
    required this.catName,
    required this.count,
    required this.uid,
    this.isSelected = false,
  });
}
