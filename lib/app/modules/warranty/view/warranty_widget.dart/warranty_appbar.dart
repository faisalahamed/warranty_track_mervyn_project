import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warranty_track/app/modules/warranty/controller/warranty_controller.dart';
import 'package:warranty_track/app/modules/warranty/view/warranty_widget.dart/warranty_filter.dart';
import 'package:warranty_track/common/constants.dart';

class WarrantyAppbar extends GetView<WarrantyController> {
  // final WarrantyController controller = Get.find();

  const WarrantyAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text("Warranty"),
      backgroundColor: AppColor.primaryColor,
      elevation: 0,

      bottom: PreferredSize(
        child: Container(
          height: 24,
          // width: 50,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Center(child: Text('Name')),
              ),
              Expanded(
                flex: 1,
                child: Text('Year'),
              ),
              Expanded(
                flex: 2,
                child: Center(child: Text('Date')),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Center(child: Text('Remaining')),
                ),
              ),
            ],
          ),
          color: Colors.grey[400],
        ),
        preferredSize: Size.fromHeight(12),
      ),

      // bottom: PreferredSize(
      //   child: Container(
      //     // color: Color.fromRGBO(255, 152, 0, 1),
      //     color: Colors.grey[100],
      //     height: 24.0,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
      //       child: TextField(
      //         textAlignVertical: TextAlignVertical.center,
      //         textAlign: TextAlign.center,
      //         // onChanged: (value) => controller.search(),
      //         // controller: controller.searchController,
      //         cursorColor: Colors.black,
      //         cursorWidth: 3.0,
      //         decoration: InputDecoration(
      //             suffixIcon: Icon(
      //               Icons.search,
      //               color: Colors.black,
      //             ),
      //             focusedBorder: OutlineInputBorder(
      //               borderSide:
      //                   const BorderSide(color: Colors.black, width: 1.5),
      //               borderRadius: BorderRadius.circular(25.0),
      //             ),
      //             fillColor: Colors.white,
      //             filled: true,
      //             border: OutlineInputBorder(
      //               borderSide:
      //                   const BorderSide(color: Colors.black, width: 2.0),
      //               borderRadius: BorderRadius.circular(25),
      //             ),
      //             hintStyle: TextStyle(fontSize: 14),
      //             hintText: 'Search Item and Shop'),
      //       ),
      //     ),
      //   ),
      //   preferredSize: Size.fromHeight(144.0),
      // ),

      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 18),
      //     child: GestureDetector(
      //       onTap: () {
      //         // categoryWiseFilterDialogue();
      //         warrantyFilterDialogue(context);
      //       },
      //       child: Obx(() => Image(
      //             image: AssetImage(AppIcons.filter),
      //             color:
      //                 controller.selectedWarrantyCategories.contains('All') ||
      //                         controller.selectedWarrantyCategories.isEmpty
      //                     ? AppColor.textPrimarycolor
      //                     : AppColor.lightPrimarycolor,
      //           )),
      //     ),
      //   ),
      //   const SizedBox(
      //     width: 20,
      //   ),
      //   Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 1),
      //     child: GestureDetector(
      //       onTap: () {
      //         // dateWiseFilterDialogue();
      //       },
      //       child: Obx(() => IconButton(
      //             icon: Icon(
      //               Icons.archive_outlined,
      //               color: !controller.selectedWarrantyCategories
      //                       .contains('Archived')
      //                   ? AppColor.textPrimarycolor
      //                   : AppColor.lightPrimarycolor,
      //               size: 28,
      //             ),
      //             onPressed: () {
      //               if (controller.selectedWarrantyCategories
      //                   .contains('Archived')) {
      //                 controller.selectedWarrantyCategories.value = <String>[];
      //                 controller.selectedWarrantyCategories.value = <String>[
      //                   "All"
      //                 ];
      //               } else {
      //                 controller.selectedWarrantyCategories.value = <String>[];
      //                 controller.selectedWarrantyCategories.add('Archived');
      //               }
      //             },
      //           )),
      //     ),
      //   ),
      //   const SizedBox(
      //     width: 20,
      //   ),
      // ],
    );
  }

  warrantyFilterDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WarrantyFilter(func: (value) {
            WarrantyController _c = Get.find();
            _c.selectedWarrantyCategories.value = <String>[];
            _c.selectedWarrantyCategories.value = value;
          });
        });
  }
}
