import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/wages_controller.dart';

class WagesView extends GetView<WagesController> {
  const WagesView({Key? key}) : super(key: key);
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
          "Wages",
          style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 15.sp),
        children: [
          OurTextField(
            hint: 'Select Start Date',
            controller: controller.selectedStartDate,
            isReadOnly: true,
            suffixIcon: IconButton(
              onPressed: () {
                controller.selectDOB(true);
              },
              icon: const Icon(
                Icons.date_range,
                color: AppColors.textAndOutlineColor,
              ),
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          OurTextField(
            hint: 'Select End Date',
            controller: controller.selectedEndDate,
            isReadOnly: true,
            suffixIcon: IconButton(
              onPressed: () {
                controller.selectDOB(false);
              },
              icon: const Icon(
                Icons.date_range,
                color: AppColors.textAndOutlineColor,
              ),
            ),
          ),
          SizedBox(
            height: 15.sp,
          ),
          OurButton(
              onTap: () {
                if (controller.selectedStartDate.text.isNotEmpty && controller.selectedEndDate.text.isNotEmpty) {
                  context.loaderOverlay.show();
                  controller.getWages().then((value) {
                    context.loaderOverlay.hide();
                  }).onError((error, stackTrace) {
                    context.loaderOverlay.hide();
                  });
                } else {
                  HelpingMethods.showToast("Please select dates first.");
                }
              },
              title: "Find Wages"),
          Obx(() => controller.wagesList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 15.sp,
                    ),
                    Text(
                      "Results",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white70),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Obx(() => Column(
                          children: List.generate(
                              controller.wagesList.length,
                              (index) => Card(
                                    color: Colors.white12,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            "JOB ID  #${controller.wagesList[index]['job_id']}",
                                            style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 18.sp),
                                          ),
                                          const Divider(
                                            color: Colors.black54,
                                          ),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      "Started Date",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.reformattedTime(controller.wagesList[index]['start_time'].toString()),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Working Hours",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['working_hours'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Break Hours",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['break_hours'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Amount",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['amount'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Job Status",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['is_job_closed'] == 1 ? "Closed" : "Active".toString(),
                                                      style: TextStyle(
                                                          color: controller.wagesList[index]['is_job_closed'] == 1 ? Colors.black.withOpacity(0.65) : Colors.blue,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      "Closed Date",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.reformattedTime(controller.wagesList[index]['closed_time'].toString()),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Work State",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['is_paused'] == 1 ? "Paused" : "Working".toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "ODO Meter Value",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['odometer_value'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Service",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['service_due'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Text(
                                                      "Rego",
                                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      controller.wagesList[index]['rego'].toString(),
                                                      style: TextStyle(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ))
                  ],
                )
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}
