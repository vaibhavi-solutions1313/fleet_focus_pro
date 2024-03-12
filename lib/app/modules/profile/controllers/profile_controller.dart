import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';

class ProfileController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var userInfo = {}.obs;
  var selectedImagePath = "".obs;

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

  Future getUserInfo() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    await networkHelper.fetchData(Endpoints.getUser).then((value) {
      if (value.statusCode == 200) {
        userInfo.value = value.data['data'] ?? {};
        name.text = userInfo.value['name'] ?? "";
        userName.text = userInfo.value['username'] ?? "";
        address.text = userInfo.value['address'] ?? "";
        email.text = userInfo.value['email'] ?? "";
      }
    });
  }

  String reformattedTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDateTime = DateFormat('MMM d, y - HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  Future<ApiResponse<dynamic>> updateDriverProfile() async {
    Map<String, String> forms = {};
    forms.addIf(name.text.isNotEmpty, "name", name.text);
    forms.addIf(userName.text.isNotEmpty, "username", userName.text);
    forms.addIf(address.text.isNotEmpty, "address", address.text);
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.editDriverUser, forms, []);
  }

  Future<ApiResponse<dynamic>> updateProfilePic() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postFormData(Endpoints.editAvatar, {}, [await http.MultipartFile.fromPath('avatar', selectedImagePath.value)]);
  }

  Future<String?> pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImagePath.value = pickedFile.path;
        return selectedImagePath.value;
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
