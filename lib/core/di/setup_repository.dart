import 'package:danielyikorea/features/game_settings/data/repo/repo_impl.dart';
import 'package:danielyikorea/features/game_settings/domain/repo/repo.dart';
import 'package:get/get.dart';


void setupRepository() {
  Get.lazyPut<GameRepo>(() => GameRepoImplementation(apiClient: Get.find()), fenix: true);
}
