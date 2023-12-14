import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/license_type_controller.dart';

class LicenseTypeView extends GetView<LicenseTypeController> {
  const LicenseTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Licence Types",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Expanded(
                child: DataTable(
                  dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                  headingRowColor: MaterialStateProperty.all<Color>(OurColor.highlightBG),
                  border: TableBorder(borderRadius: BorderRadius.circular(12.sp)),
                  columnSpacing: 2,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ],
                  rows: controller.licenceTypes.value.map((row) {
                    return DataRow(
                      cells: [
                        DataCell(
                            Text(
                              row['type'].toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75), fontSize: 14.5.sp),
                            ),
                            showEditIcon: true, onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Update Licence",
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Please fill the information below",
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  OurTextField(hint: "Licence Type", controller: controller.name),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: OurButton(
                                        onTap: () {
                                          if (controller.name.text.isNotEmpty) {
                                            context.loaderOverlay.show();
                                            controller.updateLicence(row['id'].toString(), controller.name.text).then((value) async {
                                              await controller.getLicences();
                                              Get.back();
                                              context.loaderOverlay.hide();
                                            }).onError((error, stackTrace) {
                                              context.loaderOverlay.hide();
                                              HelpingMethods.showToast(error.toString());
                                            });
                                          } else {
                                            HelpingMethods.showToast('Please fill fields to update.');
                                          }
                                        },
                                        title: 'Update'),
                                  )
                                ],
                              ),
                            ),
                          ).whenComplete(() {
                            controller.name.clear();
                          });
                        }),
                      ],
                    );
                  }).toList(),
                ),
              )),
        ],
      ),
    );
  }
}
