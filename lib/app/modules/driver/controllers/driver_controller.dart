import 'dart:io';
import 'dart:typed_data';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';
import 'package:http/http.dart' as http;

enum ImageType { profilePhoto, passportFront, passportBack, license, licenseBack, abn, visa, signature }

class DriverController extends GetxController {
  //TODO: Implement DriverController
  var driverList = [].obs;
  var salariesList = [].obs;
  TextEditingController fullName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController passwordNumber = TextEditingController();
  TextEditingController bankAccNumber = TextEditingController();
  TextEditingController passportNumber = TextEditingController();
  TextEditingController refCode = TextEditingController();
  TextEditingController licenseNumber = TextEditingController();
  TextEditingController licenseState = TextEditingController();
  TextEditingController abn = TextEditingController();
  TextEditingController bankBsb = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController workingHours = TextEditingController();
  TextEditingController selectedDOB = TextEditingController();
  TextEditingController passportCountry = TextEditingController();
  TextEditingController visaFromDate = TextEditingController();
  TextEditingController visaToDate = TextEditingController();
  TextEditingController wage = TextEditingController();
  var isCheckBox = false.obs;
  var profilePhotoPath = "".obs;
  var passportFrontPhotoPath = "".obs;
  var passportBackPhotoPath = "".obs;
  var visaPhotoPath = "".obs;
  var abnPhotoPath = "".obs;
  var licensePhotoPath = "".obs;
  var licenseBackPhotoPath = "".obs;
  var signaturePhotoPath = "".obs;
  String? selectedLicenseState;
  String? selectedLicenseType;
  String? selectedWagesType;
  String? selectedBreakType;
  var isUserActive = false.obs;
  List<String> wagesType = ["Per Day", "Per Hour"];
  List<String> breakType = ["Paid", "Unpaid"];
  final formLogin = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getDriverLists() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getDrivers).then((value) {
      if (value.statusCode == 200) {
        driverList.value = value.data['data'];
      }
    });
  }

  Future getSalaries(String userId) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    await networkHelper.postFormData(Endpoints.getSalaries, {"user_id": userId}, []).then((value) {
      if (value.statusCode == 200) {
        salariesList.value = value.data['data'];
      }
    });
  }

  Future<ApiResponse<dynamic>> sendPdfMail(String id) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postData(Endpoints.sendPDFMail, {"id": id}).then((value) {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Sent to mail');
      } else {
        HelpingMethods.showToast('Unable to send.');
      }
      return value;
    });
  }

  // CONVERT UNIT8 to Image Path.
  Future<String> saveUint8ListToFile(Uint8List data, String fileName) async {
    try {
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      File file = File('${appDocumentsDirectory.path}/$fileName');
      await file.writeAsBytes(data);
      return file.path;
    } catch (e) {
      print('Error saving file: $e');
      return "";
    }
  }

  void selectImage(ImageType imageType) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (imageType == ImageType.profilePhoto) {
        profilePhotoPath.value = image.path;
      } else if (imageType == ImageType.signature) {
        signaturePhotoPath.value = image.path;
      } else if (imageType == ImageType.abn) {
        abnPhotoPath.value = image.path;
      } else if (imageType == ImageType.passportFront) {
        passportFrontPhotoPath.value = image.path;
      } else if (imageType == ImageType.passportBack) {
        passportBackPhotoPath.value = image.path;
      } else if (imageType == ImageType.visa) {
        visaPhotoPath.value = image.path;
      } else if (imageType == ImageType.license) {
        licensePhotoPath.value = image.path;
      } else if (imageType == ImageType.licenseBack) {
        licenseBackPhotoPath.value = image.path;
      }
    }
  }

  Future<ApiResponse<dynamic>> registerVendor() async {
    final ipv4 = await Ipify.ipv4();
    List<http.MultipartFile> files = [
      await http.MultipartFile.fromPath('photo', profilePhotoPath.value),
      await http.MultipartFile.fromPath('passport', passportFrontPhotoPath.value),
      await http.MultipartFile.fromPath('passport_back', passportBackPhotoPath.value),
      await http.MultipartFile.fromPath('visa', visaPhotoPath.value),
      await http.MultipartFile.fromPath('abn', abnPhotoPath.value),
      await http.MultipartFile.fromPath('license', licensePhotoPath.value),
      await http.MultipartFile.fromPath('license_back', licenseBackPhotoPath.value),
      await http.MultipartFile.fromPath('signature', signaturePhotoPath.value),
    ];

    return await networkHelper.postFormData(
        Endpoints.registerUser,
        {
          'ref_code': refCode.text,
          'full_name': fullName.text,
          'email': email.text,
          'password': password.text,
          'address': address.text,
          'age': age.text,
          'mobile_number': mobileNumber.text,
          'dob': selectedDOB.text,
          'passport_number': passportNumber.text,
          'passport_country': passportCountry.text,
          'visa_status_id': '1',
          'hours_allowed_to_work': workingHours.text,
          'bank_bsb': bankBsb.text,
          'abn': abn.text,
          'bank_account_number': bankAccNumber.text,
          'license_type_id': selectedLicenseType ?? "1",
          'license_state': selectedLicenseState ?? "",
          'license_number': licenseNumber.text,
          'employee_category': 'Vendor',
          'ip_address': ipv4.toString(),
          'wages_type': selectedWagesType!,
          'wages': wage.text,
          'break_type': selectedBreakType ?? "",
          "is_active": isUserActive.value.toString()
        },
        files);
  }

  Future<String> selectDOB(bool isDob) async {
    DateTime? _selectedDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime(2023),
      firstDate: DateTime(1920),
      lastDate: DateTime(isDob ? 2023 : 2300),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Set the theme for the date picker dialog
          child: child!,
        );
      },
    );
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    return formattedDate;
  }

  void onRegisterVendor(BuildContext context) {
    if (formLogin.currentState!.validate() && refCode.text.isNotEmpty) {
      if (profilePhotoPath.isNotEmpty &&
          licensePhotoPath.isNotEmpty &&
          licenseBackPhotoPath.isNotEmpty &&
          visaPhotoPath.isNotEmpty &&
          abnPhotoPath.isNotEmpty &&
          signaturePhotoPath.isNotEmpty &&
          passportFrontPhotoPath.isNotEmpty &&
          passportBackPhotoPath.isNotEmpty) {
        if (isCheckBox.value == true) {
          Get.overlayContext!.loaderOverlay.show();
          registerVendor().then((value) {
            Get.overlayContext!.loaderOverlay.hide();
            if (value.statusCode == 200) {
              HelpingMethods.showToast('Account created successfully.');
              resetValues();
              Get.back();
            } else {
              Get.overlayContext!.loaderOverlay.hide();
              HelpingMethods.showToast(value.error.toString());
            }
          }).onError((error, stackTrace) {
            Get.overlayContext!.loaderOverlay.hide();
          });
        } else {
          HelpingMethods.showToast('Please accept our terms & conditions.');
        }
      } else {
        HelpingMethods.showToast('Please provide all documents');
      }
    } else {
      HelpingMethods.showToast('Please fill required fields.');
    }
  }

  Future<ApiResponse<dynamic>> verifyAccountOTP(String emailID, String otp) async {
    return await networkHelper.postData('${Endpoints.accountVerifyOTP}?email=$emailID&otp=$otp', {});
  }

  Future<ApiResponse<dynamic>> editDriver(String driverId) async {
    // final ipv4 = await Ipify.ipv4();
    List<http.MultipartFile> files = [];

    if (profilePhotoPath.value.isNotEmpty) {
      files.addIf(profilePhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('photo', profilePhotoPath.value));
    }
    if (passportFrontPhotoPath.value.isNotEmpty) {
      files.addIf(passportFrontPhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('passport', passportFrontPhotoPath.value));
    }
    if (passportBackPhotoPath.value.isNotEmpty) {
      files.addIf(passportBackPhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('passport_back', passportBackPhotoPath.value));
    }
    if (visaPhotoPath.value.isNotEmpty) {
      files.addIf(visaPhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('visa', visaPhotoPath.value));
    }
    if (abnPhotoPath.value.isNotEmpty) {
      files.addIf(abnPhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('abn', abnPhotoPath.value));
    }
    if (licensePhotoPath.value.isNotEmpty) {
      files.addIf(licensePhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('license', licensePhotoPath.value));
    }
    if (licenseBackPhotoPath.value.isNotEmpty) {
      files.addIf(licenseBackPhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('license_back', licenseBackPhotoPath.value));
    }
    if (signaturePhotoPath.value.isNotEmpty) {
      files.addIf(signaturePhotoPath.value.isNotEmpty, await http.MultipartFile.fromPath('signature', signaturePhotoPath.value));
    }
    Map<String, String> editedData = {};

    editedData.addIf(driverId.isNotEmpty, 'driver_id', driverId);
    editedData.addIf(refCode.text.isNotEmpty, 'ref_code', refCode.text);
    editedData.addIf(password.text.isNotEmpty, 'password', password.text);
    editedData.addIf(address.text.isNotEmpty, 'address', address.text);
    editedData.addIf(age.text.isNotEmpty, 'age', age.text);
    editedData.addIf(mobileNumber.text.isNotEmpty, 'mobile_number', mobileNumber.text);
    editedData.addIf(selectedDOB.text.isNotEmpty, 'dob', selectedDOB.text);
    editedData.addIf(passportNumber.text.isNotEmpty, 'passport_number', passportNumber.text);
    editedData.addIf(passportCountry.text.isNotEmpty, 'passport_country', passportCountry.text);
    editedData.addIf(workingHours.text.isNotEmpty, 'hours_allowed_to_work', workingHours.text);
    editedData.addIf(bankBsb.text.isNotEmpty, 'bank_bsb', bankBsb.text);
    editedData.addIf(abn.text.isNotEmpty, 'abn', abn.text);
    editedData.addIf(bankAccNumber.text.isNotEmpty, 'bank_account_number', bankAccNumber.text);
    if (selectedLicenseType != null) {
      editedData.addIf(selectedLicenseType != null, 'license_type_id', selectedLicenseType!);
    }
    if (selectedLicenseState != null) {
      editedData.addIf(selectedLicenseState != null, 'license_state', selectedLicenseState!);
    }
    editedData.addIf(licenseNumber.text.isNotEmpty, 'license_number', licenseNumber.text);
    if (selectedWagesType != null) {
      editedData.addIf(selectedWagesType != null, 'wages_type', selectedWagesType!);
    }
    editedData.addIf(wage.text.isNotEmpty, 'wages', wage.text);

    return await networkHelper.postFormData(Endpoints.editDriver, editedData, files);
  }

  Future<ApiResponse<dynamic>> registerDriver() async {
    final ipv4 = await Ipify.ipv4();
    List<http.MultipartFile> files = [
      await http.MultipartFile.fromPath('photo', profilePhotoPath.value),
      await http.MultipartFile.fromPath('passport', passportFrontPhotoPath.value),
      await http.MultipartFile.fromPath('passport_back', passportBackPhotoPath.value),
      await http.MultipartFile.fromPath('visa', visaPhotoPath.value),
      await http.MultipartFile.fromPath('abn', abnPhotoPath.value),
      await http.MultipartFile.fromPath('license', licensePhotoPath.value),
      await http.MultipartFile.fromPath('license_back', licenseBackPhotoPath.value),
      await http.MultipartFile.fromPath('signature', signaturePhotoPath.value),
    ];

    return await networkHelper.postFormData(
        Endpoints.registerDriver,
        {
          'ref_code': refCode.text,
          'full_name': fullName.text,
          'email': email.text,
          'password': password.text,
          'address': address.text,
          'age': age.text,
          'mobile_number': mobileNumber.text,
          'dob': selectedDOB.text,
          'passport_number': passportNumber.text,
          'passport_country': passportCountry.text,
          'visa_status_id': '1',
          'hours_allowed_to_work': workingHours.text,
          'bank_bsb': bankBsb.text,
          'abn': abn.text,
          'bank_account_number': bankAccNumber.text,
          'license_type_id': selectedLicenseType ?? "1",
          'license_state': selectedLicenseState ?? "",
          'license_number': licenseNumber.text,
          'employee_category': 'driver',
          'ip_address': ipv4.toString(),
          'wages_type': selectedWagesType!,
          'wages': wage.text,
          'break_type': selectedBreakType ?? "",
          "is_active": isUserActive.value.toString()
        },
        files);
  }

  void onRegisterDriver(BuildContext context) {
    if (formLogin.currentState!.validate() && refCode.text.isNotEmpty) {
      if (profilePhotoPath.isNotEmpty &&
          licensePhotoPath.isNotEmpty &&
          licenseBackPhotoPath.isNotEmpty &&
          visaPhotoPath.isNotEmpty &&
          abnPhotoPath.isNotEmpty &&
          signaturePhotoPath.isNotEmpty &&
          passportFrontPhotoPath.isNotEmpty &&
          passportBackPhotoPath.isNotEmpty) {
        if (1 == 1) {
          Get.overlayContext!.loaderOverlay.show();
          registerDriver().then((value) async {
            Get.overlayContext!.loaderOverlay.hide();
            if (value.statusCode == 200) {
              resetValues();
              Get.overlayContext!.loaderOverlay.show();
              await getDriverLists();
              Get.overlayContext!.loaderOverlay.hide();
              HelpingMethods.showToast('Account created successfully.');
              Get.back();
            } else if (value.statusCode == 404) {
              Get.overlayContext!.loaderOverlay.hide();
              HelpingMethods.showToast(value.error.toString());
            } else {
              Get.overlayContext!.loaderOverlay.hide();
              HelpingMethods.showToast(value.error.toString());
            }
          }).onError((error, stackTrace) {
            Get.overlayContext!.loaderOverlay.hide();
            HelpingMethods.showToast(error.toString());
          });
        }
      } else {
        HelpingMethods.showToast('Please provide all documents');
      }
    } else {
      HelpingMethods.showToast('Please fill required fields.');
    }
  }

  void resetValues() {
    fullName.clear();
    age.clear();
    email.clear();
    password.clear();
    address.clear();
    mobileNumber.clear();
    passwordNumber.clear();
    bankAccNumber.clear();
    passportNumber.clear();
    refCode.clear();
    licenseNumber.clear();
    licenseState.clear();
    wage.clear();
    abn.clear();
    bankBsb.clear();
    workingHours.clear();
    selectedDOB.clear();
    isCheckBox.value = false;
    profilePhotoPath.value = "";
    passportFrontPhotoPath.value = "";
    passportBackPhotoPath.value = "";
    visaPhotoPath.value = "";
    abnPhotoPath.value = "";
    licensePhotoPath.value = "";
    licenseBackPhotoPath.value = "";
    signaturePhotoPath.value = "";
    visaFromDate.clear();
    visaToDate.clear();
    selectedLicenseType = null;
    selectedLicenseState = null;
    selectedWagesType = null;
    selectedBreakType = null;
  }
}
