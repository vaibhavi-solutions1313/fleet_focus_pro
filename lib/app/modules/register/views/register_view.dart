import 'package:fleet_focus_pro/app/modules/register/views/startup_forms.dart';
import 'package:fleet_focus_pro/app/modules/register/views/terms_conditions_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: OurColors.cardBG,
      //   centerTitle: false,
      //   iconTheme: const IconThemeData(color: Colors.blue),
      //   title: Text(
      //     "Register",
      //     style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
      //   ),
      // ),
      body: Form(
        key: controller.formLogin,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 10.sp),
              child: Row(
                children: [
                  SafeArea(
                    child: Text(
                      "Fill the details below \nto sign up",
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ),
                ],
              ),
            ),
            OurTextField(
              hint: 'Company Name',
              controller: controller.companyName,
            ),
            SizedBox(
              height: 10.sp,
            ),
            OurTextField(hint: 'Full Name', controller: controller.fullName),
            SizedBox(
              height: 10.sp,
            ),
            OurTextField(hint: 'Email', controller: controller.email, isEmail: true, keyboardType: TextInputType.emailAddress),
            SizedBox(
              height: 10.sp,
            ),
            OurTextField(hint: 'Address', controller: controller.address),
            SizedBox(
              height: 10.sp,
            ),
            OurTextField(hint: 'Mobile Number', controller: controller.mobileNumber, keyboardType: TextInputType.number),
            SizedBox(
              height: 12.sp,
            ),
            OurTextField(hint: 'Password', controller: controller.password, isPassword: true),
            SizedBox(
              height: 15.sp,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Checkbox(
                        value: controller.isCheckBox.value,
                        activeColor: Colors.green,
                        overlayColor: MaterialStateProperty.all<Color>(Colors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => const BorderSide(width: 1.0, color: Colors.black54),
                        ),
                        onChanged: (value) {
                          controller.isCheckBox.value = value!;
                        },
                      ),
                    )),
                SizedBox(
                  width: 8.sp,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(TermsConditionView(
                        url: controller.termsConditions['terms_condition'],
                      ));
                    },
                    child: Text(
                      "By accepting, you're agree to our terms & conditions",
                      style: GoogleFonts.urbanist(color: const Color(0Xff7983A3), fontSize: 16.sp),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.sp,
            ),
            OurButton(
              onTap: () {
                if (controller.formLogin.currentState!.validate()) {
                  context.loaderOverlay.show();
                  controller.registerUser().then((value) {
                    context.loaderOverlay.hide();
                    if (value.statusCode == 200) {
                      HelpingMethods.showToast("Registered Successfully.");
                      Get.back();
                    } else {
                      var data = value.data['data'];
                      HelpingMethods.showToast(data['message']);
                    }
                  }).onError((error, stackTrace) {
                    context.loaderOverlay.hide();
                    HelpingMethods.showToast(error.toString());
                  });
                }
              },
              title: 'Create my Account',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account already?",
                    style: GoogleFonts.urbanist(color: Color(0xFF7983A3), fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 8.sp)),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Login Now",
                      style: GoogleFonts.urbanist(color: OurColor.highlightBG, fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            OurButton(
                onTap: () {
                  Get.to(StartupViews());
                },
                title: 'Startup Questions')
          ],
        ),
      ),
    );
  }
}
