class CategoryModel {
  String id;
  String catName;
  int count;
  bool isSelected;

  CategoryModel({
    required this.id,
    required this.catName,
    required this.count,
    this.isSelected = false,
  });
}
