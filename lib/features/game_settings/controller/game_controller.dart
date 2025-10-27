import 'dart:developer' as DPrint;
import 'package:danielyikorea/features/game_settings/controller/revealed_word_controller.dart';
import 'package:danielyikorea/features/game_settings/data/models/game_start_request_model.dart';
import 'package:danielyikorea/features/game_settings/data/models/game_start_response_model.dart';
import 'package:danielyikorea/features/game_settings/domain/repo/repo.dart';
import '../../../core/base/base_controller.dart';
import 'package:get/get.dart';

import '../screen/players_screen.dart';

class GameController extends BaseController {
  final GameRepo _gameRepo;

  GameController(this._gameRepo);

  late String gameType = '';

  // Reactive variables for GetX
  RxInt totalPlayers = 3.obs;
  RxInt totalImposters = 1.obs;
  RxBool isWordGame = true.obs;
  RxBool showCategoryToImposter = true.obs;
  RxBool showHintToImposter = true.obs;
  RxList<String> playerNames = ['a', 'b', 'c'].obs;

  RxList<Player> players = <Player>[].obs;

  void resetGame() {
    players.clear();
    gameType = '';
    if (Get.isRegistered<RevealedWordController>()) {
      Get.delete<RevealedWordController>();
    }
  }


  // Update players from AddPlayerScreen
  void updatePlayers(List<String> players) {
    playerNames.assignAll(players);
    totalPlayers.value = players.length;
  }

  // Toggle game mode
  void toggleGameMode(bool isWord) {
    isWordGame.value = isWord;
  }

  void saveAnswer(String playerName, String answer) {
    final index = players.indexWhere((p) => p.name == playerName);
    if (index != -1) {
      players[index].answer = answer;
      players.refresh();
    }
  }


  // Game start function
  Future<void> gameStart({
    required List<String> playerNames,
    required String type,
  }) async {
    setLoading(true);
    setError('');

    gameType = type;

    final request = GameRequest(playerNames: playerNames, type: type);
    final result = await _gameRepo.gameStart(request);

    result.fold(
          (fail) {
        setError(fail.message);
        DPrint.log("Register failed: ${fail.message}");
        setLoading(false);
      },
          (success) {
        // Reset old data
        players.clear();

        // Assign new players
        players.assignAll(success.data.players);

        DPrint.log("Register success: ${success.data}");
        setLoading(false);

        // Delete old RevealedWordController if exists
        if (Get.isRegistered<RevealedWordController>()) {
          Get.delete<RevealedWordController>();
        }

        // Navigate to PlayersScreen
        Get.to(() => PlayersScreen(data: success.data));
      },
    );
  }
}
