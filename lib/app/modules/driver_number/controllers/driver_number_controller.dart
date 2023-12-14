import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class DriverNumberController extends GetxController {
  TextEditingController driverNumber = TextEditingController();
  var driverLists = [].obs;
  var driverNumbersLists = [].obs;

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

  Future getDriversLists() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getDrivers).then((value) {
      if (value.statusCode == 200) {
        driverLists.value = value.data['data'];
      }
    });
  }

  Future getDriverNumbers() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getDriverNumbers).then((value) {
      if (value.statusCode == 200) {
        driverNumbersLists.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> addDriverNumber(String userId) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.addDriverNumber, {"driver_number": driverNumber.text, "user_id": userId}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Created Successfully');
        await getDriverNumbers();
      } else {
        HelpingMethods.showToast('Unable to create.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> updateDriverNumber(String driverNumberId,String userId) async {
    Map<String, String> updatedData = {};
    updatedData.addAll({'driver_number_id': driverNumberId});
    updatedData.addIf(driverNumber.text.isNotEmpty, 'driver_number', driverNumber.text);
    updatedData.addIf(userId.isNotEmpty, 'user_id', userId);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.updateDriverNumber, updatedData, []).then((value) async {
      if (value.statusCode == 200) {
        await getDriverNumbers();
        HelpingMethods.showToast('Updated Successfully');
        driverNumber.clear();
      } else {
        HelpingMethods.showToast('Unable to update.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> deleteDriverNumber(String id) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.deleteDriverNumber, {"driver_number_id": id}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Deleted Successfully');
        await getDriverNumbers();
      } else {
        HelpingMethods.showToast('Unable to delete.');
      }
      return value;
    });
  }
}
