import 'package:danielyikorea/features/game_settings/controller/game_controller.dart';
import 'package:danielyikorea/features/game_settings/screen/everyones_answer_screen.dart';
import 'package:danielyikorea/features/game_settings/screen/voting_screen.dart';
import 'package:get/get.dart';
import 'package:danielyikorea/features/game_settings/data/models/game_start_response_model.dart';

class RevealedWordController extends GetxController {
  final GameResponse data;
  final GameController gameController = Get.find<GameController>();

  RevealedWordController(this.data);

  // Track revealed players
  final revealed = <String>[].obs;

  void markRevealed(String id) {
    if (!revealed.contains(id)) {
      revealed.add(id);

      // Word game → after all revealed, go to Voting
      if (gameController.gameType == 'word' && revealed.length == data.players.length) {
        Get.to(() => VotingPhaseScreen(data.players));
      }

      // Question game → after all answered, go to Everyone's Answers
      if (gameController.gameType == 'question' && revealed.length == data.players.length) {
        final nonImposter = data.players.firstWhere((p) => !p.isImposter);

        // Use their question
        final actualQuestion = nonImposter.questions;

        Get.to(() => EveryonesAnswerScreen(
          players: data.players,
          question: actualQuestion,
        ));
      }
    }
  }
}
