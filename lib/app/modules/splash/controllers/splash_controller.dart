import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../plans_view.dart';
import '../../../routes/app_pages.dart';
import '../../client/controllers/client_controller.dart';
import '../../customer/controllers/customer_controller.dart';
import '../../driver/controllers/driver_controller.dart';
import '../../driver_number/controllers/driver_number_controller.dart';
import '../../job/controllers/job_controller.dart';
import '../../license_type/controllers/license_type_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../roaster/controllers/roaster_controller.dart';
import '../../truck/controllers/truck_controller.dart';
import '../../visa/controllers/visa_controller.dart';
import '../../wages/controllers/wages_controller.dart';

class SplashController extends GetxController {
  var userInfo = {}.obs;
  TextEditingController email = TextEditingController(text: "atish007paul@gmail.com");
  TextEditingController password = TextEditingController(text: "123456789");
  var vehiclesList = [].obs;
  var licenseStateList = [].obs;
  var licenseTypesList = [].obs;
  Map termsConditions = {};

  //TODO: Implement SplashController
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

  Future<ApiResponse<dynamic>> getLicenseState() async {
    return await networkHelper.fetchData(Endpoints.getLicenseState).then((value) {
      if (value.statusCode == 200) {
        if (value.data['data'] != null) {
          licenseStateList.value = value.data['data'];
        }
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> getLicenseTypes() async {
    return await networkHelper.fetchData(Endpoints.licenseTypes).then((value) {
      if (value.statusCode == 200) {
        if (value.data['data'] != null) {
          licenseTypesList.value = value.data['data'];
        }
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> getTermsConditions() async {
    return await networkHelper.fetchData(Endpoints.termsConditions).then((value) {
      if (value.statusCode == 200) {
        termsConditions = value.data['data'];
      }
      return value;
    });
  }

  Future getTokenBasedData() async {
    if (box.read(StorageKeys.bearerToken) != null) {
      await getUser().then((value) async {
        if (userInfo.value['role_id'] == 2) {
          await Future.wait([
            getUser(),
            getVehicles(),
            Get.find<ProfileController>().getUserInfo(),
            Get.find<ClientController>().getClients(),
            Get.find<CustomerController>().getCustomers(),
            Get.find<LicenseTypeController>().getLicences(),
            Get.find<VisaController>().getVisa(),
            Get.find<DriverNumberController>().getDriversLists(),
            Get.find<DriverNumberController>().getDriverNumbers(),
            Get.find<TruckController>().getVehicleTypes(),
            Get.find<TruckController>().getVehiclesList(),
            Get.find<DriverController>().getDriverLists(),
            Get.find<JobController>().getJobs(),
            Get.find<WagesController>().getWages(),
            Get.find<RoasterController>().getRoaster(),
            getLicenseState(),
            getLicenseTypes()
          ]);
          if (value.data['isPlanExpireOrNot'] == true) {
            Get.to(const PlansView(), transition: Transition.rightToLeft);
          } else {
            Get.toNamed(Routes.DASHBOARD);
          }
        } else {
          HelpingMethods.showToast("Sorry! You're unauthorized user.");
        }
      });
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  Future<ApiResponse<dynamic>> getUser() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.fetchData(Endpoints.getUser).then((value) {
      if (value.statusCode == 200) {
        userInfo.value = value.data['data'];
      }
      return value;
    });
  }

  Future<ApiResponse<dynamic>> loginDriver() async {
    String? messagingToken = await FirebaseMessaging.instance.getToken();
    return await networkHelper.postFormData(Endpoints.loginUser, {'email': email.text, 'password': password.text, 'device_token': messagingToken ?? ""}, []).then((value) {
      if (value.statusCode == 200) {
        box.write(StorageKeys.bearerToken, value.data!['data']['token']);
      }
      return value;
    });
  }

  Future getVehicles() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    networkHelper.fetchData(Endpoints.getVehicles).then((value) {
      if (value.statusCode == 200) {
        vehiclesList.value = value.data['data'];
      }
    });
  }
}
