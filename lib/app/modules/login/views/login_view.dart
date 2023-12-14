import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: OurColor.scaffoldBG,
      body: Form(
        key: controller.formLogin,
        child: ListView(

          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.sp), bottomRight: Radius.circular(25.sp)),
            //   child: Stack(
            //     children: [
            //       ColorFiltered(
            //           colorFilter: ColorFilter.mode(
            //             Colors.black.withOpacity(0.2), // Adjust opacity to control darkness
            //             BlendMode.darken,
            //           ),
            //           child: Image.asset(
            //             'assets/login_bg.jpg',
            //             width: Get.width,
            //             fit: BoxFit.cover,
            //           )),
            //       Positioned(
            //         bottom: 0,
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 18.sp),
            //           child: Text(
            //             "Effortless Courier Management.",
            //             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp, color: Colors.white70),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 50,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Simply Freight, Anywhere',
                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text(
                            ' Empowering',
                            style: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6E6969)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text(
                            ' Effortless Freight Management',
                            style: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6E6969)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text(
                            ' Simplified Your Logistics',
                            style: GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color(0xFF6E6969)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                // Image.asset(
                //   'assets/map_login.png',
                //   height: Get.width / 1.5,
                // ),
              ],
            ),
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OurTextField(hint: "Email", controller: controller.email, isEmail: true),
                  SizedBox(
                    height: 15.sp,
                  ),
                  OurTextField(
                    hint: "Password",
                    controller: controller.password,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: 22.sp,
                  ),
                  OurButton(
                    title: "Login",
                    onTap: () {
                      if (controller.formLogin.currentState!.validate()) {
                        context.loaderOverlay.show();
                        controller.loginUser().then((loginRes) {
                          if (loginRes.statusCode == 200) {
                            Get.find<SplashController>().getTokenBasedData().whenComplete(() {
                              context.loaderOverlay.hide();
                            }).onError((error, stackTrace) {
                              context.loaderOverlay.hide();
                            });
                            // Get.find<SplashController>().getUser().then((gerUserRes) {
                            //   context.loaderOverlay.hide();
                            //   if (gerUserRes.statusCode == 200) {
                            //     if(gerUserRes.data['data']['isPlanExpireOrNot'] == false) {
                            //       Get.find<SplashController>().getTokenBasedData();
                            //     } else {
                            //       Get.to(PlansView(),transition: Transition.rightToLeft);
                            //     }
                            //   }
                            // }).onError((error, stackTrace) {
                            //   context.loaderOverlay.hide();
                            //   HelpingMethods.showToast(error.toString());
                            // });
                          } else if (loginRes.statusCode == 404) {
                            context.loaderOverlay.hide();
                            HelpingMethods.showToast("Invalid Credentials. Please re-check.");
                          }
                        }).onError((error, stackTrace) {
                          context.loaderOverlay.hide();
                          HelpingMethods.showToast(error.toString());
                        });
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      TextEditingController emailAddress = TextEditingController();
                      TextEditingController otp = TextEditingController();
                      TextEditingController newPass = TextEditingController();
                      TextEditingController conNewPass = TextEditingController();
                      Map dataFound = {};
                      showModalBottomSheet(
                        backgroundColor: OurColor.scaffoldBG,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Please provide email address, and enter OTP received in email.",
                                  style: TextStyle(color: Colors.black87, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                Row(
                                  children: [
                                    Expanded(child: OurTextField(hint: 'Email Address', controller: emailAddress)),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0.sp),
                                      child: TextButton(
                                          onPressed: () async {
                                            if (emailAddress.text.isNotEmpty) {
                                              context.loaderOverlay.show();
                                              await controller.requestOTPinMail(emailAddress.text).then((value) {
                                                context.loaderOverlay.hide();
                                                if (value.statusCode == 200) {
                                                  dataFound.addAll(value.data);
                                                  otp.clear();
                                                }
                                              }).onError((error, stackTrace) {
                                                context.loaderOverlay.hide();
                                                HelpingMethods.showToast(error.toString());
                                              });
                                            } else {
                                              HelpingMethods.showToast('Please enter email address first.');
                                            }
                                          },
                                          child: const Text(
                                            "Verify",
                                            style: TextStyle(color: OurColor.highlightBG),
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                OurTextField(hint: "OTP", controller: otp),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                OurTextField(hint: "New Password", controller: newPass),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                OurTextField(hint: "Confirm New Password", controller: conNewPass),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: OurButton(
                                      onTap: () {
                                        if (otp.text.isNotEmpty && newPass.text.isNotEmpty && conNewPass.text.isNotEmpty) {
                                          if (newPass.text == conNewPass.text) {
                                            context.loaderOverlay.show();
                                            controller.updatePasswordByOTP(otp.text, dataFound['data']['user_id'].toString(), newPass.text).then((value) {
                                              context.loaderOverlay.hide();
                                              Get.back();
                                            }).onError((error, stackTrace) {
                                              context.loaderOverlay.hide();
                                              HelpingMethods.showToast(error.toString());
                                            });
                                          } else {
                                            HelpingMethods.showToast('Passwords not matched');
                                          }
                                        }
                                      },
                                      title: "Update Password"),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.urbanist(color: OurColor.highlightBG, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Color(0xFF7983A3), fontSize: 15.sp, fontWeight: FontWeight.w700),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 8.sp)),
                          onPressed: () {
                            Get.toNamed('/register');
                          },
                          child: Text(
                            "Register Now",
                            style: GoogleFonts.urbanist(color: OurColor.highlightBG, fontWeight: FontWeight.w700, fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Card(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.sp), topRight: Radius.circular(25.sp))),
      //   child: Padding(
      //     padding: EdgeInsets.symmetric(vertical: 12.0.sp),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "New User? Let's create an",
      //           style: TextStyle(color: Colors.black87, fontSize: 16.sp),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             Get.toNamed('/register');
      //           },
      //           child: Text(
      //             "Account!",
      //             style: TextStyle(color: OurColor.highlightBG, fontSize: 16.sp),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
