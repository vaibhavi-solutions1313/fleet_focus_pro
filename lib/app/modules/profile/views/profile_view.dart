import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../../routes/app_pages.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.selectedImagePath.value = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                controller.pickImage();
              },
              child: Obx(() => ClipRRect(
                    borderRadius: BorderRadius.circular(100.sp),
                    child: Container(
                      width: Get.width / 3,
                      height: Get.width / 3,
                      color: Colors.black54,
                      child: controller.selectedImagePath.value.isNotEmpty
                          ? Image.file(
                              File(controller.selectedImagePath.value),
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              controller.userInfo.value['profile_photo_path'] ?? '${controller.userInfo.value['profile_photo_url']}&format=png',
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.image_not_supported,
                                size: 45.sp,
                                color: Colors.black54,
                              ),
                              fit: BoxFit.cover,
                              // width: 45.sp,
                              // height: 45.sp,
                            ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.sp),
            child: Text(
              "Basic Information",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "Full name",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'Full Name', controller: controller.name),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "Username",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'User Name', controller: controller.userName),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "Email",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'Email Address', controller: controller.email),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "Mobile",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'Mobile', controller: controller.mobile, isReadOnly: false),
          SizedBox(
            height: 10.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "Address",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'Address', controller: controller.address),
          SizedBox(
            height: 18.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0.sp),
            child: Text(
              "Security Information",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.sp),
            child: Text(
              "New Password",
              style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          OurTextField(hint: 'New Password', controller: controller.newPassword, isPassword: true),
          SizedBox(
            height: 15.sp,
          ),
          OurButton(
            onTap: () {
              if (controller.name.text.isNotEmpty && controller.userName.text.isNotEmpty && controller.email.text.isNotEmpty && controller.address.text.isNotEmpty)
                FocusManager.instance.primaryFocus?.unfocus();
              context.loaderOverlay.show();
              if (controller.selectedImagePath.value.isNotEmpty) {
                controller.updateProfilePic();
              }
              controller.updateDriverProfile().then((value) async {
                context.loaderOverlay.hide();
                if (value.statusCode == 200) {
                  HelpingMethods.showToast("Profile Updated Successfully.");
                  controller.selectedImagePath.value = "";
                  Get.back();
                } else {
                  if (value.error != null) {
                    HelpingMethods.showToast(value.error.toString());
                  } else {
                    HelpingMethods.showToast("Profile not updated.");
                  }
                }
              });
            },
            title: 'Update',
          ),
          SizedBox(
            height: 10.sp,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 13.sp)),
            onPressed: () async {
              box.erase();
              Get.offAllNamed(Routes.SPLASH);
              final splashControl = Get.find<SplashController>();
              await splashControl.getTokenBasedData();
            },
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Obx(() => controller.userInfo.value['created_at'] != null
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Joined: ${controller.reformattedTime(controller.userInfo.value['created_at'].toString())}",
                    style: TextStyle(color: Colors.black87, fontSize: 14.sp),
                  ))
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}
