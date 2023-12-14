
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_app_bar.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_dropdown.dart';
import '../../../../widgets/our_select_image_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/truck_controller.dart';

class CreateTruckPage extends GetView<TruckController>{
  const CreateTruckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OurAppBar(title: 'Create Truck'),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _formKey,
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OurTextField(hint: "Rego", controller: controller.rego),
                        SizedBox(
                          height: 16.sp,
                        ),
                        OurTextField(hint: "Odometer Value", controller: controller.odometer),
                        SizedBox(
                          height: 16.sp,
                        ),
                        OurTextField(hint: "Service Due (in km)", controller: controller.serviceDue),
                        SizedBox(
                          height: 16.sp,
                        ),
                        OurTextField(hint: "Truck Number", controller: controller.truckNumber),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Obx(() => OurListObjectDropDown(
                            dropdownItems: controller.vehicleTypes.value,
                            onDropdownChanged: (value) {
                              controller.selectedTruck = value;
                            },
                            keyName: "vehicle_type",
                            hintText: "Select Vehicle Type",
                            selectedDropdownItem: controller.selectedTruck)),
                        SizedBox(
                          height: 16.sp,
                        ),
                        SelectImageButton(
                            label: "Upload Truck Front side Photo",
                            title: controller.truckFrontPhoto.value.isNotEmpty ? "Truck Front Photo Selected" : null,
                            onTap: () {
                              controller.selectImage(ImageType.truckFrontPhoto);
                            },
                            isSelected: controller.truckFrontPhoto.value.isNotEmpty),
                        SizedBox(
                          height: 16.sp,
                        ),
                        SelectImageButton(
                            label: "Upload Truck Back side Photo",
                            title: controller.truckBackPhoto.value.isNotEmpty ? "Truck Back Photo Selected" : null,
                            onTap: () {
                              controller.selectImage(ImageType.truckBackPhoto);
                            },
                            isSelected: controller.truckBackPhoto.value.isNotEmpty),
                        SizedBox(
                          height: 16.sp,
                        ),
                        SelectImageButton(
                            label: "Upload Truck right side Photo",
                            title: controller.truckRightPhoto.value.isNotEmpty ? "Truck Right Photo Selected" : null,
                            onTap: () {
                              controller.selectImage(ImageType.truckRightPhoto);
                            },
                            isSelected: controller.truckRightPhoto.value.isNotEmpty),
                        SizedBox(
                          height: 16.sp,
                        ),
                        SelectImageButton(
                            label: "Upload Truck left side Photo",
                            title: controller.truckLeftPhoto.value.isNotEmpty ? "Truck Left Photo Selected" : null,
                            onTap: () {
                              controller.selectImage(ImageType.truckLeftPhoto);
                            },
                            isSelected: controller.truckLeftPhoto.value.isNotEmpty),
                        SizedBox(
                          height: 16.sp,
                        ),
                        SelectImageButton(
                            label: "Upload Fuel photo",
                            title: controller.fuelCardPhoto.value.isNotEmpty ? "Fuel Card Photo Selected" : null,
                            onTap: () {
                              controller.selectImage(ImageType.fuelCardPhoto);
                            },
                            isSelected: controller.fuelCardPhoto.value.isNotEmpty),
                        SizedBox(
                          height: 16.sp,
                        ),
                        OurButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.loaderOverlay.show();
                                controller.createVehicle().then((value) {
                                  HelpingMethods.showToast("Created Successfully.".toString());
                                  context.loaderOverlay.hide();
                                  Get.back();
                                }).onError((error, stackTrace) {
                                  HelpingMethods.showToast(error.toString());
                                  context.loaderOverlay.hide();
                                });
                              }
                            },
                            title: 'Create')
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}