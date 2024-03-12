import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../../../models/send_roaster_model.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../driver/controllers/driver_controller.dart';
import '../controllers/roaster_controller.dart';

class SendRoasterView extends StatefulWidget {
  const SendRoasterView({super.key});

  @override
  State<SendRoasterView> createState() => _SendRoasterViewState();
}

class _SendRoasterViewState extends State<SendRoasterView> {
  final controller = Get.find<RoasterController>();

  @override
  void initState() {
    controller.vehicleList.value.forEach((element) {
      controller.selectedTableData.add(TableData(rego: element['rego'], startDate: TextEditingController(), endDate: TextEditingController()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.selectedDate.clear();
    controller.selectedTableData.value = [];
    controller.selectedDates.value = SetRoasterModel();
    // TODO: implement dispose
    super.dispose();
  }

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
          "Send Roaster",
          style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
            child: OurTextField(
              hint: 'Date',
              controller: controller.selectedDate,
              isReadOnly: true,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.selectDOB().then((value) {
                    controller.selectedDate.text = value;
                    controller.selectedDates.value.date = value;
                  });
                },
                icon: const Icon(
                  Icons.date_range,
                  color: AppColors.textAndOutlineColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10.sp),
              itemCount: controller.vehicleList.value.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1.5,
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Truck Rego : ${controller.vehicleList.value[index]['rego']}",
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: AppColors.textAndOutlineTop),
                        ),
                        Obx(() => OurListObjectDropDown(
                            dropdownItems: Get.find<DriverController>().driverList.value,
                            onDropdownChanged: (value) {
                              controller.selectedDriver.value = value;
                              controller.selectedTableData.value[index].type = Type(
                                id: controller.selectedDriver.value['id'].toString(),
                                label: controller.selectedDriver.value['user_name'].toString(),
                              );
                              controller.filterRoasterByDriverId();
                            },
                            keyName: 'user_name',
                            hintText: 'Select Driver')),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OurTextField(
                                hint: 'Shift Start Time',
                                controller: controller.selectedTableData.value[index].startDate,
                                isReadOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.selectTime(context).then((value) {
                                      if (value != null) {
                                        controller.selectedTableData.value[index].startDate.text = value;
                                        controller.selectedTableData.value[index].startTime = value;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.access_time,
                                    color: AppColors.textAndOutlineColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                              child: OurTextField(
                                hint: 'Shift End Time',
                                controller: controller.selectedTableData.value[index].endDate,
                                isReadOnly: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.selectTime(context).then((value) {
                                      if (value != null) {
                                        controller.selectedTableData.value[index].endDate.text = value;
                                        controller.selectedTableData.value[index].endTime = value;
                                      }
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.access_time,
                                    color: AppColors.textAndOutlineColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 15.sp),
            child: OurButton(
                onTap: () {
                  controller.selectedDates.value.tableData = controller.selectedTableData;
                  if (controller.selectedDates.value.tableData != null) {
                    context.loaderOverlay.show();
                    controller.setRoaster().then((value) async {
                      context.loaderOverlay.hide();
                      if (value.statusCode == 200) {
                        context.loaderOverlay.show();
                        await controller.getRoaster();
                        context.loaderOverlay.hide();
                        HelpingMethods.showToast('Added Successfully.');
                        Get.back();
                      } else {
                        HelpingMethods.showToast('Not Created.');
                      }
                    }).onError((error, stackTrace) {
                      HelpingMethods.showToast(error.toString());
                      context.loaderOverlay.hide();
                    });
                  } else {
                    HelpingMethods.showToast('You have not added a date yet.');
                  }
                },
                title: 'Submit'),
          )
        ],
      ),
    );
  }
}
