import 'package:get/get.dart';

import '../controllers/wages_controller.dart';

class WagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WagesController>(
      () => WagesController(),
    );
  }
}
