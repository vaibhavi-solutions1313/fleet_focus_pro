import 'package:fleet_focus_pro/app/modules/roaster/views/send_roaster_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../controllers/roaster_controller.dart';

class RoasterView extends GetView<RoasterController> {
  const RoasterView({Key? key}) : super(key: key);
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
          "Roaster",
          style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
                ),
              ),
              child: IconButton(
                  onPressed: () {
                    Get.to(SendRoasterView());
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Text(
          //   "Select Driver to Proceed",
          //   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          // ),
          // Obx(() => OurListObjectDropDown(
          //     dropdownItems: Get.find<DriverController>().driverList.value,
          //     onDropdownChanged: (value) {
          //       controller.selectedDriver.value = value;
          //       controller.filterRoasterByDriverId();
          //     },
          //     keyName: 'user_name',
          //     hintText: 'Select Driver')),
          // SizedBox(
          //   height: 18.sp,
          // ),
          Obx(() => controller.roasterInfo.value.isNotEmpty
              ? Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                      headingRowColor: MaterialStateProperty.all<Color>(OurColor.highlightBG),
                      border: TableBorder(borderRadius: BorderRadius.circular(12.sp)),
                      // datatable widget
                      columns: [
                        DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'User Name',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Rego',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Start Time',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'End Time',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                          ),
                        ),
                      ],

                      rows: List.generate(
                        controller.roasterInfo.value.length,
                        (index) => DataRow(cells: [
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                              decoration: BoxDecoration(
                                  color: controller.roasterInfo.value[index]['status'] == 0
                                      ? Colors.yellow
                                      : controller.roasterInfo.value[index]['status'] == 1
                                          ? Colors.green
                                          : controller.roasterInfo.value[index]['status'] == 2
                                              ? Colors.red
                                              : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.sp)),
                              child: Text(
                                controller.status(controller.roasterInfo.value[index]['status']),
                                style: TextStyle(
                                    color: controller.roasterInfo.value[index]['status'] == 0
                                        ? Colors.black
                                        : controller.roasterInfo.value[index]['status'] == 1
                                            ? Colors.white
                                            : controller.roasterInfo.value[index]['status'] == 2
                                                ? Colors.white
                                                : Colors.black),
                              ),
                            ),
                          ),
                          DataCell(Text(
                            controller.roasterInfo.value[index]['id'].toString(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          )),
                          DataCell(Text(
                            controller.roasterInfo.value[index]['username'].toString(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          )),
                          DataCell(Text(
                            controller.roasterInfo.value[index]['rego'].toString(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          )),
                          DataCell(Text(
                            controller.roasterInfo.value[index]['start_time'].toString(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          )),
                          DataCell(Text(
                            controller.roasterInfo.value[index]['end_time'].toString(),
                            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                          )),
                        ]),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                      child: Text(
                    "Not found.",
                    style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                  )),
                )),
        ],
      ),
    );
  }
}
