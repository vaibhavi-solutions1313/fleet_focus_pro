import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class VisaController extends GetxController {
  TextEditingController visaName = TextEditingController();
  var visaLists = [].obs;

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

  Future getVisa() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getVisa).then((value) {
      if (value.statusCode == 200) {
        visaLists.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> addVisaName() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.createVisaName, {"visa_type": visaName.text}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Created Successfully');
        await getVisa();
      } else {
        HelpingMethods.showToast('Unable to create.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> updateVisa(String visaId) async {
    Map<String, String> updatedData = {};
    updatedData.addAll({'visa_type_id': visaId});
    updatedData.addIf(visaName.text.isNotEmpty, 'visa_type', visaName.text);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.updateVisa, updatedData, []).then((value) async {
      if (value.statusCode == 200) {
        await getVisa();
        HelpingMethods.showToast('Updated Successfully');
        visaName.clear();
        Get.back();
      } else {
        HelpingMethods.showToast('Unable to update.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> deleteVisa(String id) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.deleteVisa, {"visa_type_id": id}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Deleted Successfully');
        await getVisa();
      } else {
        HelpingMethods.showToast('Unable to delete.');
      }
      return value;
    });
  }
}
