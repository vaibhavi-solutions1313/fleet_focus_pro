import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../bindings/truck_binding.dart';
import '../controllers/truck_controller.dart';
import 'create_truck_page.dart';

class TruckView extends GetView<TruckController> {
  const TruckView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Vehicles",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
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
                  Get.to(()=>CreateTruckPage(),binding: TruckBinding());
                  // final _formKey = GlobalKey<FormState>();
                  // showModalBottomSheet(
                  //   context: context,
                  //   isScrollControlled: true,
                  //   builder: (context) => Padding(
                  //     padding: const EdgeInsets.all(18.0),
                  //     child: Form(
                  //       key: _formKey,
                  //       child: Obx(() => Column(
                  //             crossAxisAlignment: CrossAxisAlignment.stretch,
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Text(
                  //                 "Create Truck",
                  //                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  //               ),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               Text(
                  //                 "Please fill the information below",
                  //                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  //               ),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               OurTextField(hint: "Rego", controller: controller.rego),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               OurTextField(hint: "Odometer Value", controller: controller.odometer),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               OurTextField(hint: "Service Due (in km)", controller: controller.serviceDue),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               OurTextField(hint: "Truck Number", controller: controller.truckNumber),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               Obx(() => OurListObjectDropDown(
                  //                   dropdownItems: controller.vehicleTypes.value,
                  //                   onDropdownChanged: (value) {
                  //                     controller.selectedTruck = value;
                  //                   },
                  //                   keyName: "vehicle_type",
                  //                   hintText: "Select Vehicle Type",
                  //                   selectedDropdownItem: controller.selectedTruck)),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               SelectImageButton(
                  //                   label: "Truck Front Photo",
                  //                   title: controller.truckFrontPhoto.value.isNotEmpty ? "Truck Front Photo Selected" : null,
                  //                   onTap: () {
                  //                     controller.selectImage(ImageType.truckFrontPhoto);
                  //                   },
                  //                   isSelected: controller.truckFrontPhoto.value.isNotEmpty),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               SelectImageButton(
                  //                   label: "Truck Back Photo",
                  //                   title: controller.truckBackPhoto.value.isNotEmpty ? "Truck Back Photo Selected" : null,
                  //                   onTap: () {
                  //                     controller.selectImage(ImageType.truckBackPhoto);
                  //                   },
                  //                   isSelected: controller.truckBackPhoto.value.isNotEmpty),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               SelectImageButton(
                  //                   label: "Truck Right Photo",
                  //                   title: controller.truckRightPhoto.value.isNotEmpty ? "Truck Right Photo Selected" : null,
                  //                   onTap: () {
                  //                     controller.selectImage(ImageType.truckRightPhoto);
                  //                   },
                  //                   isSelected: controller.truckRightPhoto.value.isNotEmpty),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               SelectImageButton(
                  //                   label: "Truck Left Photo",
                  //                   title: controller.truckLeftPhoto.value.isNotEmpty ? "Truck Left Photo Selected" : null,
                  //                   onTap: () {
                  //                     controller.selectImage(ImageType.truckLeftPhoto);
                  //                   },
                  //                   isSelected: controller.truckLeftPhoto.value.isNotEmpty),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               SelectImageButton(
                  //                   label: "Fuel Photo",
                  //                   title: controller.fuelCardPhoto.value.isNotEmpty ? "Fuel Card Photo Selected" : null,
                  //                   onTap: () {
                  //                     controller.selectImage(ImageType.fuelCardPhoto);
                  //                   },
                  //                   isSelected: controller.fuelCardPhoto.value.isNotEmpty),
                  //               SizedBox(
                  //                 height: 10.sp,
                  //               ),
                  //               OurButton(
                  //                   onTap: () {
                  //                     if (_formKey.currentState!.validate()) {
                  //                       context.loaderOverlay.show();
                  //                       controller.createVehicle().then((value) {
                  //                         HelpingMethods.showToast("Created Successfully.".toString());
                  //                         context.loaderOverlay.hide();
                  //                         Get.back();
                  //                       }).onError((error, stackTrace) {
                  //                         HelpingMethods.showToast(error.toString());
                  //                         context.loaderOverlay.hide();
                  //                       });
                  //                     }
                  //                   },
                  //                   title: 'Create')
                  //             ],
                  //           )),
                  //     ),
                  //   ),
                  // ).whenComplete(() {
                  //   controller.selectedTruck = null;
                  //   controller.rego.clear();
                  //   controller.odometer.clear();
                  //   controller.serviceDue.clear();
                  //   controller.truckNumber.clear();
                  //   controller.truckFrontPhoto.value = "";
                  //   controller.truckBackPhoto.value = "";
                  //   controller.truckLeftPhoto.value = "";
                  //   controller.truckRightPhoto.value = "";
                  //   controller.fuelCardPhoto.value = "";
                  // });
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.vehiclesLists.isNotEmpty
            ? ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12.sp),
                children: List.generate(
                  controller.vehiclesLists.length,
                  (index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/vehicle_group.png",
                                    width: 25.sp,
                                  ),
                                  SizedBox(width: 4.0,),
                                  Text(
                                    "REGO: ",
                                    style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.vehiclesLists[index]['rego'].toString(),
                                    style: GoogleFonts.lato(color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Service Due: ",
                                    style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.vehiclesLists[index]['service_due'] != null ? controller.vehiclesLists[index]['service_due'].toString() : "NA",
                                    style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Odometer Value: ",
                                    style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                  ),
                                  Text(
                                    controller.vehiclesLists[index]['odometer_value'].toString(),
                                    style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (controller.vehiclesLists[index]['vehicle_type_name'] != null)
                                    Text(
                                      "Vehicle Type: ",
                                      style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                    ),
                                  if (controller.vehiclesLists[index]['vehicle_type_name'] != null)
                                    Text(
                                      controller.vehiclesLists[index]['vehicle_type_name'],
                                      style: GoogleFonts.lato(color: AppColors.darkBlackishTextColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                    ),
                                  if (controller.vehiclesLists[index]['vehicle_type_name'] != null)
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          // Container(
                          //   // color: OurColor.highlightBG.withOpacity(0.10),
                          //   padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          //   child: GridView.count(
                          //       shrinkWrap: true,
                          //       padding: EdgeInsets.symmetric(vertical: 10.sp),
                          //       physics: const NeverScrollableScrollPhysics(),
                          //       mainAxisSpacing: 5,
                          //       crossAxisSpacing: 5,
                          //       crossAxisCount: 5,
                          //       children: [
                          //         GestureDetector(
                          //           onTap: () {
                          //             if (controller.vehiclesLists[index]["front_photo_url"] != null) {
                          //               Get.to(ImageView(path: controller.vehiclesLists[index]["front_photo_url"]), transition: Transition.circularReveal);
                          //             } else {
                          //               HelpingMethods.showToast('Image not found');
                          //             }
                          //           },
                          //           child: Image.network(
                          //             controller.vehiclesLists[index]["front_photo_url"],
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return const Icon(
                          //                 Icons.broken_image_rounded,
                          //                 color: Colors.white60,
                          //               );
                          //             },
                          //             width: 50.sp,
                          //             height: 50.sp,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         GestureDetector(
                          //           onTap: () {
                          //             if (controller.vehiclesLists[index]["back_photo_url"] != null) {
                          //               Get.to(ImageView(path: controller.vehiclesLists[index]["back_photo_url"]), transition: Transition.circularReveal);
                          //             } else {
                          //               HelpingMethods.showToast('Image not found');
                          //             }
                          //           },
                          //           child: Image.network(
                          //             controller.vehiclesLists[index]["back_photo_url"],
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return const Icon(
                          //                 Icons.broken_image_rounded,
                          //                 color: Colors.white60,
                          //               );
                          //             },
                          //             width: 50.sp,
                          //             height: 50.sp,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         GestureDetector(
                          //           onTap: () {
                          //             if (controller.vehiclesLists[index]["right_photo_url"] != null) {
                          //               Get.to(ImageView(path: controller.vehiclesLists[index]["right_photo_url"]), transition: Transition.circularReveal);
                          //             } else {
                          //               HelpingMethods.showToast('Image not found');
                          //             }
                          //           },
                          //           child: Image.network(
                          //             controller.vehiclesLists[index]["right_photo_url"],
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return const Icon(
                          //                 Icons.broken_image_rounded,
                          //                 color: Colors.white60,
                          //               );
                          //             },
                          //             width: 50.sp,
                          //             height: 50.sp,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         GestureDetector(
                          //           onTap: () {
                          //             if (controller.vehiclesLists[index]["left_photo_url"] != null) {
                          //               Get.to(ImageView(path: controller.vehiclesLists[index]["left_photo_url"]), transition: Transition.circularReveal);
                          //             } else {
                          //               HelpingMethods.showToast('Image not found');
                          //             }
                          //           },
                          //           child: Image.network(
                          //             controller.vehiclesLists[index]["left_photo_url"],
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return const Icon(
                          //                 Icons.broken_image_rounded,
                          //                 color: Colors.white60,
                          //               );
                          //             },
                          //             width: 50.sp,
                          //             height: 50.sp,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         GestureDetector(
                          //           onTap: () {
                          //             if (controller.vehiclesLists[index]["fuel_card_url"] != null) {
                          //               Get.to(ImageView(path: controller.vehiclesLists[index]["fuel_card_url"]), transition: Transition.circularReveal);
                          //             } else {
                          //               HelpingMethods.showToast('Image not found');
                          //             }
                          //           },
                          //           child: Image.network(
                          //             controller.vehiclesLists[index]["fuel_card_url"],
                          //             errorBuilder: (context, error, stackTrace) {
                          //               return const Icon(
                          //                 Icons.broken_image_rounded,
                          //                 color: Colors.white60,
                          //               );
                          //             },
                          //             width: 50.sp,
                          //             height: 50.sp,
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //       ]),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "No Vehicles found.",
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  // Image.asset("assets/images/empty.png", repeat: ImageRepeat.repeatX),
                  // Text(
                  //   "It seems you haven't created a job yet.",
                  //   style: TextStyle(color: Colors.white70, fontSize: 16.sp, fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(
                  //   height: 10.sp,
                  // ),
                  // OurButton(
                  //     onTap: () {
                  //       Get.toNamed('/job');
                  //     },
                  //     title: "Create a Job")
                ],
              ),
      ),
    );
  }
}
