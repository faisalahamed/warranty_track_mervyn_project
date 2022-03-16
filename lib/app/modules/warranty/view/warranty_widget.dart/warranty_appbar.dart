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
      centerTitle: true,
      title: const Text("Warranty"),
      backgroundColor: AppColor.primaryColor,
      elevation: 0,
      bottom: PreferredSize(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          // height: 44,
          // width: 50,
          child: Row(
            children: [
              Expanded(flex: 4, child: rowTitleBarBuilder(title: 'Name')),
              Expanded(
                  flex: 1,
                  child: rowTitleBarBuilder(
                    title: 'Year',
                  )),
              Expanded(flex: 2, child: rowTitleBarBuilder(title: 'Date')),
              Expanded(flex: 2, child: rowTitleBarBuilder(title: 'Remaining')),
            ],
          ),
          color: Colors.grey,
        ),
        preferredSize: Size.fromHeight(30),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: GestureDetector(
            onTap: () {
              // categoryWiseFilterDialogue();
              warrantyFilterDialogue(context);
            },
            child: Obx(() => Image(
                  height: 28,
                  image: AssetImage(AppIcons.filter),
                  color:
                      controller.selectedWarrantyCategories.contains('All') ||
                              controller.selectedWarrantyCategories.isEmpty
                          ? AppColor.textPrimarycolor
                          : AppColor.lightPrimarycolor,
                )),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: GestureDetector(
            onTap: () {
              // dateWiseFilterDialogue();
            },
            child: Obx(() => IconButton(
                  icon: Icon(
                    Icons.archive_outlined,
                    color: !controller.selectedWarrantyCategories
                            .contains('Archived')
                        ? AppColor.textPrimarycolor
                        : AppColor.lightPrimarycolor,
                    size: 28,
                  ),
                  onPressed: () {
                    if (controller.selectedWarrantyCategories
                        .contains('Archived')) {
                      controller.selectedWarrantyCategories.value = <String>[];
                      controller.selectedWarrantyCategories.value = <String>[
                        "All"
                      ];
                    } else {
                      controller.selectedWarrantyCategories.value = <String>[];
                      controller.selectedWarrantyCategories.add('Archived');
                    }
                  },
                )),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Center rowTitleBarBuilder({required String title}) => Center(
        // alignment: Alignment.topCenter,
        child: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      );

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
