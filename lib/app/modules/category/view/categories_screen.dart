import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/modules/transaction_details/controller/transaction_details_controller.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/add_category_dialogue.dart';
import 'package:warranty_track/common/constants.dart';
import 'package:warranty_track/common/delete_alert_dialogue.dart';

// ignore: use_key_in_widget_constructors
class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TransactionDetailsController settingController = Get.find();
  List<CategoryModel> _catList = [];
  AuthService _authService = Get.find();

  deleteAlertDialogue(String id, Function remove) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DeleteAlertDialogue(
              msg: "Do you want to delete category?",
              func: () {
                settingController.deleteCategoryData(id: id);
                remove();
              });
        });
  }

  addCategoryDialogue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddCategoryDialogue(
            func: () {
              addCatList();
            },
          );
        });
  }

  Widget textFieldContainer(
      {String? title,
      TextEditingController? controll,
      TextInputType? textInputType}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: textInputType,
        controller: controll,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title!,
          hintStyle: TextStyle(
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  Future<void> addCatList() async {
    List<CategoryModel> _dummy = [];
    await FirebaseConf().fref.child("Categories").once().then((snap) {
      if (snap.snapshot.value != null) {
        Map data = snap.snapshot.value as Map;
        data.forEach((key, value) {
          if (_authService.user != null &&
              value['uid'] == _authService.user!.uid) {
            _dummy.add(CategoryModel(
                id: key,
                catName: value['name'],
                count: value['count'],
                uid: _authService.user!.uid));
          }
        });

        if (_dummy.length > 1) {
          _dummy.sort((a, b) {
            return a.count.compareTo(b.count);
          });
        }

        _catList = _dummy;

        settingController.getCatData(_catList);

        setState(() {});
      }
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final CategoryModel item = _catList.removeAt(oldIndex);
        _catList.insert(newIndex, item);
      },
    );

    FirebaseConf().reorderFire(_catList);
  }

  @override
  void initState() {
    super.initState();

    addCatList();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
        title: const Text('Categories'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_catList.isEmpty)
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                AppImages.dnf,
              ))),
            )
          else
            ReorderableListView(
              onReorder: _onReorder,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: List.generate(
                _catList.length,
                (index) {
                  return Container(
                    key: Key('$index'),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _catList[index].catName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            deleteAlertDialogue(_catList[index].id, () {
                              _catList.removeAt(index);
                              setState(() {});
                            });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Positioned(
            bottom: 20,
            right: 10,
            child: GestureDetector(
              onTap: () {
                addCategoryDialogue();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.secondaryColor,
                ),
                margin: const EdgeInsets.only(top: 15, right: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Add Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.add,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
