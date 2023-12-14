import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/image_view.dart';
import '../controllers/driver_controller.dart';

class SalaryListView extends StatefulWidget {
  const SalaryListView({super.key});

  @override
  State<SalaryListView> createState() => _SalaryListViewState();
}

class _SalaryListViewState extends State<SalaryListView> {
  final controller = Get.find<DriverController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Salaries",
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
                  // columnSpacing: 2,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Driver Name',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'View',
                        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 14.5.sp),
                      ),
                    ),
                  ],
                  rows: controller.driverList.value.map((row) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            row['user_name'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.75), fontSize: 14.5.sp),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            onPressed: () async {
                              context.loaderOverlay.show();
                              await controller.getSalaries(row['user_id'].toString()).then((value) {
                                context.loaderOverlay.hide();
                                Get.to(SalaryCard(
                                  driverName: row['user_name'].toString(),
                                ));
                              }).onError((error, stackTrace) {
                                context.loaderOverlay.hide();
                              });
                            },
                            icon: Icon(Icons.visibility),
                          ),
                        ),
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

class SalaryCard extends StatefulWidget {
  final String driverName;
  const SalaryCard({super.key, required this.driverName});

  @override
  State<SalaryCard> createState() => _SalaryCardState();
}

class _SalaryCardState extends State<SalaryCard> {
  final controller = Get.find<DriverController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          widget.driverName,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: Obx(
        () => controller.salariesList.isNotEmpty
            ? ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12.sp),
                children: List.generate(
                  controller.salariesList.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                    child: Card(
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
                                        controller.salariesList[index]['rego'].toString(),
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
                                        controller.salariesList[index]['company'].toString(),
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
                                        '\$${controller.salariesList[index]['amount'] ?? "0"}',
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
                                        (controller.salariesList[index]['working_hours'] ?? "NA").toString(),
                                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      if (controller.salariesList[index]['vehicle_type'] != null)
                                        Text(
                                          "Vehicle Type",
                                          style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                      if (controller.salariesList[index]['vehicle_type'] != null)
                                        Text(
                                          controller.salariesList[index]['vehicle_type'],
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                      if (controller.salariesList[index]['vehicle_type'] != null)
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                      Text(
                                        "Odometer Value",
                                        style: TextStyle(color: OurColor.highlightBG, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.salariesList[index]['odometer_value'].toString(),
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
                                        controller.salariesList[index]['service_due'].toString(),
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
                                        controller.salariesList[index]['is_job_closed'] == 1 ? "Closed" : "Active".toString(),
                                        style: TextStyle(
                                            color: controller.salariesList[index]['is_job_closed'] == 1 ? Colors.black87 : Colors.green,
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
                                        if (controller.salariesList[index]["front_photo_url"] != null) {
                                          Get.to(ImageView(path: controller.salariesList[index]["front_photo_url"]), transition: Transition.circularReveal);
                                        } else {
                                          HelpingMethods.showToast('Image not found');
                                        }
                                      },
                                      child: Image.network(
                                        controller.salariesList[index]["front_photo_url"],
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
                                        if (controller.salariesList[index]["back_photo_url"] != null) {
                                          Get.to(ImageView(path: controller.salariesList[index]["back_photo_url"]), transition: Transition.circularReveal);
                                        } else {
                                          HelpingMethods.showToast('Image not found');
                                        }
                                      },
                                      child: Image.network(
                                        controller.salariesList[index]["back_photo_url"],
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
                                        if (controller.salariesList[index]["right_photo_url"] != null) {
                                          Get.to(ImageView(path: controller.salariesList[index]["right_photo_url"]), transition: Transition.circularReveal);
                                        } else {
                                          HelpingMethods.showToast('Image not found');
                                        }
                                      },
                                      child: Image.network(
                                        controller.salariesList[index]["right_photo_url"],
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
                                        if (controller.salariesList[index]["left_photo_url"] != null) {
                                          Get.to(ImageView(path: controller.salariesList[index]["left_photo_url"]), transition: Transition.circularReveal);
                                        } else {
                                          HelpingMethods.showToast('Image not found');
                                        }
                                      },
                                      child: Image.network(
                                        controller.salariesList[index]["left_photo_url"],
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
                                        if (controller.salariesList[index]["fuel_card_url"] != null) {
                                          Get.to(ImageView(path: controller.salariesList[index]["fuel_card_url"]), transition: Transition.circularReveal);
                                        } else {
                                          HelpingMethods.showToast('Image not found');
                                        }
                                      },
                                      child: Image.network(
                                        controller.salariesList[index]["fuel_card_url"],
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
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Salary not Found.",
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
