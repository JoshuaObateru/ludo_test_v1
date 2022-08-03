import 'package:get/get.dart';

import '../controllers/ludo_controller.dart';

class LudoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LudoController>(
      () => LudoController(),
    );
  }
}
