import 'package:get/get.dart';

import '../controllers/visa_controller.dart';

class VisaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisaController>(
      () => VisaController(),
    );
  }
}
