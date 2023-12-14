import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formLogin = GlobalKey<FormState>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<ApiResponse<dynamic>> loginUser() async {
    var token = await FirebaseMessaging.instance.getToken();
    return await networkHelper.postFormData(Endpoints.loginUser, {'email': email.text, 'password': password.text, 'device_token': token ?? ""}, []).then((value) {
      if (value.statusCode == 200) {
        box.write(StorageKeys.bearerToken, value.data!['data']['token']);
      }
      return value;
    });
  }

  // Recover Password
  Future<ApiResponse<dynamic>> requestOTPinMail(String emailAddress) async {
    return await networkHelper.postFormData(Endpoints.requestOTPinEmail, {"email": emailAddress}, []).then((value) {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('OTP sent to your email');
      } else {
        HelpingMethods.showToast(value.error.toString());
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> updatePasswordByOTP(String otp, String userId, String newPass) async {
    return await networkHelper.postFormData(Endpoints.confirmPassOtp, {"user_id": userId, "otp": otp, "password": newPass}, []).then((value) {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Password reset successful.');
      } else {
        HelpingMethods.showToast(value.error.toString());
      }
      return value;
    });
  }
}
