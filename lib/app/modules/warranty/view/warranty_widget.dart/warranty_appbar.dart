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
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: GestureDetector(
            onTap: () {
              // categoryWiseFilterDialogue();
              warrantyFilterDialogue(context);
            },
            child: Obx(() => Image(
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
