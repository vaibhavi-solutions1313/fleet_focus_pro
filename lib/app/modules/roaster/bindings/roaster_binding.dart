import 'package:get/get.dart';

import '../controllers/roaster_controller.dart';

class RoasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoasterController>(
      () => RoasterController(),
    );
  }
}
