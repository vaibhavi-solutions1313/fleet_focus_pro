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
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Licence Types",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.splashDark, AppColors.splashLight],
                ),
              ),
              child: IconButton(
                  onPressed: () {
                    // Get.to(SendRoasterView());
                    // final _formKey = GlobalKey<FormState>();
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   context: context,
                    //   builder: (context) => Padding(
                    //     padding: MediaQuery.of(context).viewInsets,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(18.0),
                    //       child: Form(
                    //         key: _formKey,
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.stretch,
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text(
                    //               "Send Roaster",
                    //               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                    //             ),
                    //             SizedBox(
                    //               height: 10.sp,
                    //             ),
                    //             Text(
                    //               "Please fill the information below",
                    //               style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    //             ),
                    //             SizedBox(
                    //               height: 10.sp,
                    //             ),
                    //             Obx(() => OurListObjectDropDown(
                    //                 dropdownItems: Get.find<DriverController>().driverList.value,
                    //                 onDropdownChanged: (value) {
                    //                   controller.selectedDriver.value = value;
                    //                   controller.filterRoasterByDriverId();
                    //                 },
                    //                 keyName: 'user_name',
                    //                 hintText: 'Select Driver')),
                    //             SizedBox(
                    //               height: 10.sp,
                    //             ),
                    //             Obx(() => OurListObjectDropDown(
                    //                 dropdownItems: controller.regoList.value,
                    //                 onDropdownChanged: (value) {
                    //                   controller.selectedRego.value = value;
                    //                 },
                    //                 keyName: 'rego',
                    //                 hintText: 'Select Rego')),
                    //             OurTextField(
                    //               hint: 'Date',
                    //               controller: controller.selectedDate,
                    //               isReadOnly: true,
                    //               suffixIcon: IconButton(
                    //                 onPressed: () {
                    //                   controller.selectDOB().then((value) {
                    //                     controller.selectedDate.text = value;
                    //                   });
                    //                 },
                    //                 icon: const Icon(
                    //                   Icons.date_range,
                    //                   color: Colors.black54,
                    //                 ),
                    //               ),
                    //             ),
                    //             OurTextField(
                    //               hint: 'Shift Start Time',
                    //               controller: controller.selectedShiftStartDate,
                    //               isReadOnly: true,
                    //               suffixIcon: IconButton(
                    //                 onPressed: () {
                    //                   controller.selectTime(context).then((value) {
                    //                     if(value != null) {
                    //                       controller.selectedShiftStartDate.text = value;
                    //                     }
                    //                   });
                    //                 },
                    //                 icon: const Icon(
                    //                   Icons.date_range,
                    //                   color: Colors.black54,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 10.sp,
                    //             ),
                    //             OurTextField(
                    //               hint: 'Shift End Time',
                    //               controller: controller.selectedShiftEndDate,
                    //               isReadOnly: true,
                    //               suffixIcon: IconButton(
                    //                 onPressed: () {
                    //                   controller.selectTime(context).then((value) {
                    //                     if(value != null) {
                    //                       controller.selectedShiftEndDate.text = value;
                    //                     }
                    //                   });
                    //                 },
                    //                 icon: const Icon(
                    //                   Icons.date_range,
                    //                   color: Colors.black54,
                    //                 ),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               height: 10.sp,
                    //             ),
                    //             Obx(() => OurButton(
                    //                 onTap: () {
                    //                   if (controller.selectedDate.text.isNotEmpty) {
                    //                     controller.selectedDates.value.date = controller.selectedDate.text;
                    //                     controller.selectedTableData.value.add(TableData(
                    //                       startTime: controller.selectedShiftStartDate.text,
                    //                       endTime: controller.selectedShiftEndDate.text,
                    //                       type: Type(id: controller.selectedDriver.value['id'].toString(), label: controller.selectedDriver.value['user_name']),
                    //                     ));
                    //                     controller.selectedDates.value.tableData = controller.selectedTableData.value;
                    //                     controller.selectedDate.clear();
                    //                     controller.selectedShiftStartDate.clear();
                    //                     controller.selectedShiftEndDate.clear();
                    //                     HelpingMethods.showToast('Added to List');
                    //                     controller.refreshAddtoList();
                    //                   } else {
                    //                     HelpingMethods.showToast('Please select date first.');
                    //                   }
                    //                 },
                    //                 title: 'Add to List (${controller.selectedTableData.length})')),
                    //             SizedBox(
                    //               height: 8.sp,
                    //             ),
                    //             OurButton(
                    //                 onTap: () {
                    //                   if (controller.selectedDates.value.date != null && controller.selectedDates.value.tableData != null ) {
                    //                     context.loaderOverlay.show();
                    //                     controller.setRoaster().then((value) async {
                    //                       if (value.statusCode == 200) {
                    //                         await controller.getRoaster();
                    //                         context.loaderOverlay.hide();
                    //                         HelpingMethods.showToast('Added Successfully.');
                    //                         Get.back();
                    //                       } else {
                    //                         HelpingMethods.showToast('Not Created.');
                    //                       }
                    //                     }).onError((error, stackTrace) {
                    //                       HelpingMethods.showToast(error.toString());
                    //                       context.loaderOverlay.hide();
                    //                     });
                    //                   } else {
                    //                     HelpingMethods.showToast('You have not added a date yet.');
                    //                   }
                    //                 },
                    //                 title: 'Submit')
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ).then((value) {
                    //   controller.selectedDate.clear();
                    //   controller.selectedShiftStartDate.clear();
                    //   controller.selectedShiftEndDate.clear();
                    //   controller.selectedDates.value = SetRoasterModel();
                    // });
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            ),
          )
        ],
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
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
                              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                              child: Text(
                                row['type'].toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.75), fontSize: 15.5.sp),
                              ),
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
