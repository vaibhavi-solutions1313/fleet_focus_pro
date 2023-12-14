import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class CustomerController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController abn = TextEditingController();
  TextEditingController acn = TextEditingController();

  var customersLists = [].obs;

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

  Future getCustomers() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getCustomers).then((value) {
      if (value.statusCode == 200) {
        customersLists.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> addCustomer() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.addCustomer, {"name": name.text, "address": address.text, "abn": abn.text, "acn": acn.text}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Created Successfully');
        await getCustomers();
      } else {
        HelpingMethods.showToast('Unable to create.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> updateCustomer(String customerId) async {
    Map<String, String> updatedData = {};
    updatedData.addAll({'customer_id': customerId});
    updatedData.addIf(name.text.isNotEmpty, 'name', name.text);
    updatedData.addIf(address.text.isNotEmpty, 'address', address.text);
    updatedData.addIf(abn.text.isNotEmpty, 'abn', abn.text);
    updatedData.addIf(acn.text.isNotEmpty, 'acn', acn.text);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.updateCustomer, updatedData, []).then((value) async {
      if (value.statusCode == 200) {
        await getCustomers();
        HelpingMethods.showToast('Updated Successfully');
        name.clear();
        address.clear();
        Get.back();
      } else {
        HelpingMethods.showToast('Unable to update.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> deleteClient(String id) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    print({"client_id": id});
    return await networkHelper.postFormData(Endpoints.deleteClient, {"client_id": id}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Deleted Successfully');
        await getCustomers();
      } else {
        HelpingMethods.showToast('Unable to delete.');
      }
      return value;
    });
  }

  String reformattedTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDateTime = DateFormat.yMMMEd().format(dateTime);
    return formattedDateTime;
  }
}
