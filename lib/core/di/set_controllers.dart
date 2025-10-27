import 'package:danielyikorea/features/game_settings/controller/game_controller.dart';
import 'package:get/get.dart';


void setupController() {
  if (!Get.isRegistered<GameController>()) {
    Get.put<GameController>(GameController(Get.find()), permanent: true);
  }
}
