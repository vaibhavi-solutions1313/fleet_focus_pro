import 'package:get/get.dart';
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
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    Get.lazyPut<ClientController>(
      () => ClientController(),
    );
    Get.lazyPut<CustomerController>(
      () => CustomerController(),
    );
    Get.lazyPut<DriverController>(
      () => DriverController(),
    );
    Get.lazyPut<LicenseTypeController>(
      () => LicenseTypeController(),
    );
    Get.lazyPut<VisaController>(
      () => VisaController(),
    );
    Get.lazyPut<DriverNumberController>(
      () => DriverNumberController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );

    Get.lazyPut<TruckController>(
      () => TruckController(),
    );

    Get.lazyPut<JobController>(
      () => JobController(),
    );

    Get.lazyPut<WagesController>(
      () => WagesController(),
    );
    Get.lazyPut<RoasterController>(
      () => RoasterController(),
    );
  }
}
