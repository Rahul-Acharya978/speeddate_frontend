import 'package:get/get.dart';

import '../controllers/connection_profil_detail_controller.dart';

class ConnectionProfilDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionProfilDetailController>(
      () => ConnectionProfilDetailController(),
    );
  }
}
