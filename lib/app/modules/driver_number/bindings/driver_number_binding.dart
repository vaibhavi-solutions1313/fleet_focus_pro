import 'package:get/get.dart';

import '../controllers/driver_number_controller.dart';

class DriverNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverNumberController>(
      () => DriverNumberController(),
    );
  }
}
