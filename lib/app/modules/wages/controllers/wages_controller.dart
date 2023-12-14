import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant.dart';
import '../../splash/controllers/splash_controller.dart';

class WagesController extends GetxController {
  TextEditingController selectedStartDate = TextEditingController();
  TextEditingController selectedEndDate = TextEditingController();
  var wagesList = [].obs;

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

  String reformattedTime(String time) {
    DateTime dateTime = DateTime.parse(time);

    String formattedDateTime = DateFormat.yMd().add_jm().format(dateTime);
    print(formattedDateTime);
    return formattedDateTime;
  }

  void selectDOB(bool isStartDate) async {
    DateTime? _selectedDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime(DateTime.now().year, DateTime.now().month),
      firstDate: DateTime(1920),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), // Set the theme for the date picker dialog
          child: child!,
        );
      },
    );
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    if (isStartDate) {
      selectedStartDate.text = formattedDate;
    } else {
      selectedEndDate.text = formattedDate;
    }
  }

  Future getWages() async {
    Map<String, String> forms = {};
    forms.addIf(selectedStartDate.text.isNotEmpty, "startDate", selectedStartDate.text);
    forms.addIf(selectedEndDate.text.isNotEmpty, "endDate", selectedEndDate.text);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    await networkHelper.postFormData(Endpoints.wages, forms, []).then((value) {
      if (value.statusCode == 200) {
        wagesList.value = value.data;
        wagesList.refresh();
      }
    });
  }
}
