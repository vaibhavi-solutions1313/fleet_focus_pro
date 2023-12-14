import 'package:get/get.dart';

import '../controllers/license_type_controller.dart';

class LicenseTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LicenseTypeController>(
      () => LicenseTypeController(),
    );
  }
}
