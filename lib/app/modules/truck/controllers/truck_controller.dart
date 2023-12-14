import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/helping_methods.dart';
import '../../license_type/controllers/license_type_controller.dart';

enum ImageType { truckFrontPhoto, truckBackPhoto, truckRightPhoto, truckLeftPhoto, fuelCardPhoto, profilePhoto, passportBack, abn, passportFront, visa, licenseBack, license }

class TruckController extends GetxController {
  TextEditingController rego = TextEditingController();
  TextEditingController odometer = TextEditingController();
  TextEditingController serviceDue = TextEditingController();
  TextEditingController truckNumber = TextEditingController();
  var vehicleTypes = [].obs;
  var vehiclesLists = [].obs;
  var selectedTruck = null;

  var truckFrontPhoto = "".obs;
  var truckBackPhoto = "".obs;
  var truckLeftPhoto = "".obs;
  var truckRightPhoto = "".obs;
  var fuelCardPhoto = "".obs;

  TextEditingController vehicleType = TextEditingController();
  var selectedLicense = null;

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
    selectedTruck = null;
   rego.clear();
    odometer.clear();
    serviceDue.clear();
    truckNumber.clear();
    truckFrontPhoto.value = "";
    truckBackPhoto.value = "";
    truckLeftPhoto.value = "";
   truckRightPhoto.value = "";
    fuelCardPhoto.value = "";
    super.onClose();
  }

  void selectImage(ImageType imageType) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (imageType == ImageType.truckFrontPhoto) {
        truckFrontPhoto.value = image.path;
      } else if (imageType == ImageType.truckBackPhoto) {
        truckBackPhoto.value = image.path;
      } else if (imageType == ImageType.truckLeftPhoto) {
        truckLeftPhoto.value = image.path;
      } else if (imageType == ImageType.truckRightPhoto) {
        truckRightPhoto.value = image.path;
      } else if (imageType == ImageType.fuelCardPhoto) {
        fuelCardPhoto.value = image.path;
      }
    }
  }

  Future getVehicleTypes() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getTruckTypes).then((value) {
      if (value.statusCode == 200) {
        vehicleTypes.value = value.data['data'];
      }
    });
  }

  Future getVehiclesList() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getTrucks).then((value) {
      if (value.statusCode == 200) {
        vehiclesLists.value = value.data['data'];
      }
    });
  }

  Future createVehicle() async {
    List<http.MultipartFile> files = [
      await http.MultipartFile.fromPath('front_photo', truckFrontPhoto.value),
      await http.MultipartFile.fromPath('back_photo', truckBackPhoto.value),
      await http.MultipartFile.fromPath('right_photo', truckRightPhoto.value),
      await http.MultipartFile.fromPath('left_photo', truckLeftPhoto.value),
      await http.MultipartFile.fromPath('fuel_card', fuelCardPhoto.value),
    ];

    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    await networkHelper
        .postFormData(
            Endpoints.addVehicle,
            {
              'odovalue': odometer.text,
              'rego': rego.text,
              'rego': rego.text,
              'type': selectedTruck['vehicle_id'].toString(),
            },
            files)
        .then((value) async => await getVehiclesList());
  }

  Future<ApiResponse<dynamic>> addVehicleType() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper
        .postFormData(Endpoints.addVehicleType, {"vehicle_type": vehicleType.text, "license_type_id": selectedLicense['id'].toString()}, []).then((value) async {
      if (value.statusCode == 200) {
        HelpingMethods.showToast('Created Successfully');
        await getVehicleTypes();
      } else {
        HelpingMethods.showToast('Unable to create.');
      }
      return value;
    });
  }

  String findLicenseType(int id) {
    var found = Get.find<LicenseTypeController>().licenceTypes.value.firstWhereOrNull((element) => element['id'] == id);
    if(found != null) {
      return found['type'];
    } else {
      return "NA";
    }
  }
}
