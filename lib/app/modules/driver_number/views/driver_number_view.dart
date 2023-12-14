import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/driver_number_controller.dart';

class DriverNumberView extends GetView<DriverNumberController> {
  const DriverNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedDropdownItem;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Driver Numbers",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFF12ADDD),
                  Color(0xFF14598D)
                ],
              ),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Create Driver Number",
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
                          OurTextField(hint: "Driver Number", controller: controller.driverNumber),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurListObjectDropDown(
                              selectedDropdownItem: selectedDropdownItem,
                              hintText: "Select Driver from List",
                              dropdownItems: controller.driverLists,
                              onDropdownChanged: (value) {
                                selectedDropdownItem = value;
                              },
                              keyName: "user_name"),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: OurButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.loaderOverlay.show();
                                    controller.addDriverNumber(selectedDropdownItem['id'].toString()).then((value) {
                                      context.loaderOverlay.hide();
                                      Get.back();
                                      controller.driverNumber.clear();
                                    }).onError((error, stackTrace) {
                                      HelpingMethods.showToast(error.toString());
                                      context.loaderOverlay.hide();
                                      controller.driverNumber.clear();
                                    });
                                  }
                                },
                                title: 'Create'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).whenComplete(() {
                  controller.driverNumber.clear();
                  selectedDropdownItem = null;
                });
              },
              icon: const Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.driverNumbersLists.value.isNotEmpty
                ? Expanded(
                    child: DataTable(
                      dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                      headingRowColor: MaterialStateProperty.all<Color>(OurColor.highlightBG),
                      border: TableBorder(borderRadius: BorderRadius.circular(12.sp)),
                      columnSpacing: 2,
                      columns: [
                        DataColumn(
                          label: Text(
                            'Driver Number',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ],
                      rows: controller.driverNumbersLists.value.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                row['driver_number'].toString(),
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.75), fontSize: 14.5.sp),
                              ),
                              showEditIcon: true,
                              onTap: () {
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
                                          "Update Driver Number",
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
                                        OurTextField(hint: "Driver Number", controller: controller.driverNumber),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        OurListObjectDropDown(
                                            selectedDropdownItem: selectedDropdownItem,
                                            hintText: "Select Driver from List",
                                            dropdownItems: controller.driverLists,
                                            onDropdownChanged: (value) {
                                              selectedDropdownItem = value;
                                            },
                                            keyName: "user_name"),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        OurButton(
                                            onTap: () {
                                              if (controller.driverNumber.text.isNotEmpty) {
                                                if(selectedDropdownItem!=null){
                                                  context.loaderOverlay.show();
                                                  controller.updateDriverNumber(row['id'].toString(), selectedDropdownItem['id'].toString()).then((v) {
                                                    context.loaderOverlay.hide();
                                                    Get.back();
                                                  }).onError((error, stackTrace) {
                                                    context.loaderOverlay.hide();
                                                  });
                                                }else {
                                                  HelpingMethods.showToast('Select driver');
                                                }

                                              } else {
                                                HelpingMethods.showToast('Please fill fields to update.');
                                              }
                                            },
                                            title: 'Update'),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Center(
                                            child: Text(
                                          "Or",
                                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                        )),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Padding(
                                          padding: MediaQuery.of(context).viewInsets,
                                          child: OurButton(
                                              isDelete: true,
                                              onTap: () {
                                                context.loaderOverlay.show();
                                                controller.deleteDriverNumber(row['id'].toString()).whenComplete(() {
                                                  context.loaderOverlay.hide();
                                                  Get.back();
                                                });
                                              },
                                              title: 'Delete'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).whenComplete(() {
                                  controller.driverNumber.clear();
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  )
                : Center(
                    child: Text(
                      "No data found.",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
