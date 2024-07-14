import 'package:get/get.dart';
import 'package:assignment_2/networkcontroller/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);


    Get.find<NetworkController>().initialize();
  }
}
