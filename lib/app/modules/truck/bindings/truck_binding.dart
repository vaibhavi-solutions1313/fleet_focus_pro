import 'package:get/get.dart';

import '../controllers/truck_controller.dart';

class TruckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TruckController>(
      () => TruckController(),
    );
  }
}
