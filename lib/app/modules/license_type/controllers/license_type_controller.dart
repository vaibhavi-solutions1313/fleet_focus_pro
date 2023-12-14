import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../helpers/api_helper.dart';

class LicenseTypeController extends GetxController {
  var licenceTypes = [].obs;
  TextEditingController name = TextEditingController();
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

  Future getLicences() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getLicence).then((value) {
      if (value.statusCode == 200) {
        licenceTypes.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> updateLicence(String id, String newName) async {
    print({"license_type_id": id, "license_type": newName});
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.updateLicence, {"license_type_id": id, "license_type": newName}, []).then((value) {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Updated Successfully.');
      } else {
        HelpingMethods.showToast('Unable to update.');
      }
      return value;
    });
  }
}
