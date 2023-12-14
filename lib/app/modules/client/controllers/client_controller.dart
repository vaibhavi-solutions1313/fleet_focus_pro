import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class ClientController extends GetxController {
  //TODO: Implement ClientController
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();

  var clientsList = [].obs;
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

  Future getClients() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getClients).then((value) {
      if (value.statusCode == 200) {
        clientsList.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> deleteClient(String id) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.deleteClient, {"client_id": id}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Deleted Successfully');
        await getClients();
      } else {
        HelpingMethods.showToast('Unable to delete.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> addClient() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.addClient, {"name": name.text, "amount": amount.text}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Created Successfully');
        await getClients();
      } else {
        HelpingMethods.showToast('Unable to create.');
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> updateClient(String clientID) async {
    Map<String, String> updatedData = {};
    updatedData.addAll({'client_id': clientID});
    updatedData.addIf(name.text.isNotEmpty, 'name', name.text);
    updatedData.addIf(amount.text.isNotEmpty, 'amount', amount.text);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.updateClient, updatedData, []).then((value) async {
      if (value.statusCode == 200) {
        await getClients();
        HelpingMethods.showToast('Updated Successfully');
        name.clear();
        amount.clear();
        Get.back();
      } else {
        HelpingMethods.showToast('Unable to create.');
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
