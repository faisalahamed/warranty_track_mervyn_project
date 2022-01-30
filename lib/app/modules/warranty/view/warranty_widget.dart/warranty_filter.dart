import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/warranty/controller/warranty_controller.dart';

class WarrantyFilter extends StatefulWidget {
  final Function func;

  const WarrantyFilter({Key? key, required this.func}) : super(key: key);

  @override
  _WarrantyFilterState createState() => _WarrantyFilterState();
}

class _WarrantyFilterState extends State<WarrantyFilter> {
  // HomeScreenController homeScreenController = HomeScreenController();
  // final Stream _api =
  //     FirebaseDatabase.instance.reference().child("Categories").onValue;
  // late int previousIndex;
  List<String> listwarrantyCategory = ['All', 'Expiry', 'Old'];
  WarrantyController controller = Get.find();

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
                'Sort By',
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
            ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                shrinkWrap: true,
                itemCount: listwarrantyCategory.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // select and unselet a item category
                    onTap: () {
                      if (controller.selectedWarrantyCategories
                          .contains(listwarrantyCategory[index])) {
                        // controller.selectedWarrantyCategories
                        //     .remove(listwarrantyCategory[index]);
                        controller.selectedWarrantyCategories.value =
                            <String>[];
                      } else {
                        controller.selectedWarrantyCategories.value =
                            <String>[];
                        controller.selectedWarrantyCategories
                            .add(listwarrantyCategory[index]);
                      }
                      Navigator.pop(context);
                    },
                    child: Obx(() => Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: controller.selectedWarrantyCategories
                                  .contains(listwarrantyCategory[index])
                              ? Colors.blue[200]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        child: Text(listwarrantyCategory[index]))),
                  );
                }),
            const SizedBox(
              height: 15,
            ),
            // SizedBox(
            //   width: 320.0,
            //   child: GestureDetector(
            //     onTap: () {
            //       // widget.func(selectedStringList);
          ],
        ),
      ),
    );
  }
}
