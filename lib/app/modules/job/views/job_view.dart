import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/image_view.dart';
import '../controllers/job_controller.dart';

class JobView extends GetView<JobController> {
  const JobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Job List",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Obx(
        () => controller.getAllJobsList.isNotEmpty
            ? ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15.sp,horizontal: 12.sp),
              children: List.generate(
                controller.getAllJobsList.length,
                (index) => Card(
                  elevation: 5,
                  // color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "REGO",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.getAllJobsList[index]['rego'].toString(),
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Company",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.getAllJobsList[index]['company'].toString(),
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Salary",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    '\$${controller.getAllJobsList[index]['amount'] ?? "0"}',
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Working Hours",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    (controller.getAllJobsList[index]['working_hours'] ?? "NA").toString(),
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (controller.getAllJobsList[index]['vehicle_type'] != null)
                                    Text(
                                      "Vehicle Type",
                                      style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                    ),
                                  if (controller.getAllJobsList[index]['vehicle_type'] != null)
                                    Text(
                                      controller.getAllJobsList[index]['vehicle_type'],
                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                    ),
                                  if (controller.getAllJobsList[index]['vehicle_type'] != null)
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                  Text(
                                    "Odometer Value",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.getAllJobsList[index]['odometer_value'].toString(),
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Service Due",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.getAllJobsList[index]['service_due'].toString(),
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    "Job Status",
                                    style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.getAllJobsList[index]['is_job_closed'] == 1 ? "Closed" : "Active".toString(),
                                    style: TextStyle(
                                        color: controller.getAllJobsList[index]['is_job_closed'] == 1 ? Colors.black87 : Colors.green,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Container(
                          color: OurColor.highlightBG.withOpacity(0.10),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: GridView.count(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 10.sp),
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              crossAxisCount: 5,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.getAllJobsList[index]["front_photo_url"] != null) {
                                      Get.to(ImageView(path: controller.getAllJobsList[index]["front_photo_url"]), transition: Transition.circularReveal);
                                    } else {
                                      HelpingMethods.showToast('Image not found');
                                    }
                                  },
                                  child: Image.network(
                                    controller.getAllJobsList[index]["front_photo_url"],
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image_rounded,
                                        color: Colors.white60,
                                      );
                                    },
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.getAllJobsList[index]["back_photo_url"] != null) {
                                      Get.to(ImageView(path: controller.getAllJobsList[index]["back_photo_url"]), transition: Transition.circularReveal);
                                    } else {
                                      HelpingMethods.showToast('Image not found');
                                    }
                                  },
                                  child: Image.network(
                                    controller.getAllJobsList[index]["back_photo_url"],
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image_rounded,
                                        color: Colors.white60,
                                      );
                                    },
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.getAllJobsList[index]["right_photo_url"] != null) {
                                      Get.to(ImageView(path: controller.getAllJobsList[index]["right_photo_url"]), transition: Transition.circularReveal);
                                    } else {
                                      HelpingMethods.showToast('Image not found');
                                    }
                                  },
                                  child: Image.network(
                                    controller.getAllJobsList[index]["right_photo_url"],
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image_rounded,
                                        color: Colors.white60,
                                      );
                                    },
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.getAllJobsList[index]["left_photo_url"] != null) {
                                      Get.to(ImageView(path: controller.getAllJobsList[index]["left_photo_url"]), transition: Transition.circularReveal);
                                    } else {
                                      HelpingMethods.showToast('Image not found');
                                    }
                                  },
                                  child: Image.network(
                                    controller.getAllJobsList[index]["left_photo_url"],
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image_rounded,
                                        color: Colors.white60,
                                      );
                                    },
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.getAllJobsList[index]["fuel_card_url"] != null) {
                                      Get.to(ImageView(path: controller.getAllJobsList[index]["fuel_card_url"]), transition: Transition.circularReveal);
                                    } else {
                                      HelpingMethods.showToast('Image not found');
                                    }
                                  },
                                  child: Image.network(
                                    controller.getAllJobsList[index]["fuel_card_url"],
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image_rounded,
                                        color: Colors.white60,
                                      );
                                    },
                                    width: 50.sp,
                                    height: 50.sp,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "No Jobs Found.",
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
