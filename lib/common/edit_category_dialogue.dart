import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/model/category_model.dart';
import 'package:warranty_track/app/modules/home/controller/home_controller.dart';
import 'package:warranty_track/app/service/auth_service.dart';
import 'package:warranty_track/app/service/firebase_config.dart';
import 'package:warranty_track/common/constants.dart';

class EditCategoryDialogue extends StatefulWidget {
  final Function func;
  final String selectedCat;

  const EditCategoryDialogue(
      {Key? key, required this.func, required this.selectedCat})
      : super(key: key);

  @override
  _EditCategoryDialogueState createState() => _EditCategoryDialogueState();
}

class _EditCategoryDialogueState extends State<EditCategoryDialogue> {
  HomeViewController homeScreenController = HomeViewController();
  AuthService _authService = Get.find();
  final Stream _api = FirebaseConf().fref.child("Categories").onValue;
  String? _selectedString;

  @override
  void initState() {
    super.initState();

    _selectedString = widget.selectedCat;
  }

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
                'Edit Category',
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
            StreamBuilder(
              stream: _api,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snap.hasData && snap.data.snapshot.value != null) {
                  List<CategoryModel> _catList = [];
                  Map data = snap.data.snapshot.value;
                  data.forEach((key, value) {
                    if (_authService.user != null &&
                        _authService.user!.uid == value['uid']) {
                      _catList.add(CategoryModel(
                          uid: _authService.user!.uid,
                          id: key,
                          catName: value['name'],
                          count: value['count']));
                    }
                  });

                  if (_catList.length > 1) {
                    _catList.sort((a, b) {
                      return a.count.compareTo(b.count);
                    });
                  }

                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      shrinkWrap: true,
                      itemCount: _catList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _selectedString = _catList[index].catName;
                            setState(() {});
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color:
                                    _catList[index].catName == _selectedString
                                        ? Colors.blue[200]
                                        : Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 15),
                              child: Text(_catList[index].catName)),
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
              },
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 320.0,
              child: GestureDetector(
                onTap: () {
                  widget.func(_selectedString);
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
