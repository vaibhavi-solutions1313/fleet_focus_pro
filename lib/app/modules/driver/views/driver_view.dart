import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../map_view_drivers.dart';
import '../controllers/driver_controller.dart';
import 'create_driver_view.dart';

class DriverView extends GetView<DriverController> {
  const DriverView({Key? key}) : super(key: key);
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
          "Drivers",
          style: TextStyle(fontSize: 18.sp, color: Color(0xFF524C4C), letterSpacing: 0.2, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(MapDriversView(), transition: Transition.rightToLeft);
            },
            icon: const Icon(Icons.map),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[Color(0xFF12ADDD), Color(0xFF14598D)],
              ),
            ),
            child: IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero
              ),
              onPressed: () {
                Get.to(const CreateDriverView(isEdit: false), transition: Transition.rightToLeft);
              },
              icon: const Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.driverList.isNotEmpty
            ? ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12.sp),
                children: List.generate(
                  controller.driverList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.5, 0.5),
                                spreadRadius: 0.8,
                                blurRadius: 2,
                                color: Colors.grey.shade200
                            )
                          ]
                      ),
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
                                        "User Name: ${controller.driverList[index]['user_name'].toString()}",
                                        style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.sp),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      if (controller.driverList[index]['mobile_number'] != null)
                                        Text(
                                          "Mobile Number: ${controller.driverList[index]['mobile_number']}",
                                          style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Wages : ${controller.driverList[index]['wages'] != null ? controller.driverList[index]['wages'].toString() : "NA"}",
                                            style: GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16.sp),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Get.to(CreateDriverView(isEdit: true, editData: controller.driverList[index]),
                                                        transition: Transition.rightToLeft);
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black45,
                                                  )),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.search,
                                                color: Colors.black45,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.print,
                                                color: Colors.black45,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.edit_document,
                                                color: Colors.black45,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.black45,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Icon(
                                                Icons.message,
                                                color: Colors.black45,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Flexible(
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                                //     children: [
                                //       TextButton(
                                //         onPressed: () {
                                //           Get.to(CreateDriverView(isEdit: true, editData: controller.driverList[index]), transition: Transition.rightToLeft);
                                //         },
                                //         child: const Text("View More"),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset("assets/images/empty.png", repeat: ImageRepeat.repeatX),
                  Center(
                    child: Text(
                      "No Drivers Found.",
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
