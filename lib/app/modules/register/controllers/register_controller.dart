import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';

class RegisterController extends GetxController {
  TextEditingController fullName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController passwordNumber = TextEditingController();
  var isCheckBox = false.obs;
  Map termsConditions = {};
  final formLogin = GlobalKey<FormState>();

  @override
  void onInit() {
    getTermsConditions();
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

  Future<ApiResponse<dynamic>> registerUser() async {
    return await networkHelper.postFormData(Endpoints.registerUser, {
      'company_name': companyName.text,
      'name': fullName.text,
      'email': email.text,
      'password': password.text,
      'address': address.text,
      'mobile': mobileNumber.text,
    }, []);
  }

  Future<ApiResponse<dynamic>> getTermsConditions() async {
    return await networkHelper.fetchData(Endpoints.termsConditions).then((value) {
      if (value.statusCode == 200) {
        termsConditions = value.data['data'];
      }
      return value;
    });
  }
}
