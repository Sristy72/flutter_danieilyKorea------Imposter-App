import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/features/game_settings/controller/game_controller.dart';
import 'package:danielyikorea/features/game_settings/controller/revealed_word_controller.dart';
import 'package:danielyikorea/features/game_settings/data/models/game_start_response_model.dart';
import 'package:danielyikorea/features/game_settings/screen/question_reveal_screen.dart';
import 'package:danielyikorea/features/game_settings/screen/word_reveal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayersScreen extends StatelessWidget {
  final GameResponse data;
  const PlayersScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(RevealedWordController(data));
    // final GameController gameController = Get.find<GameController>();

    // // Delete old controller if exists
    // if (Get.isRegistered<RevealedWordController>()) {
    //   Get.delete<RevealedWordController>();
    // }

    // Create a fresh controller for new game
    final controller = Get.put(RevealedWordController(data));
    final GameController gameController = Get.find<GameController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Players",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tap your name to reveal your word, then pass the device to the next player.",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.builder(
                  itemCount: data.players.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (context, index) {
                    final player = data.players[index];
                    return GestureDetector(
                      onTap: () async {
                        if (gameController.gameType == "word") {
                          await Get.to(
                            () => WordRevealScreen(
                              playerName: player.name,
                              category: player.wordCategory,
                              word: player.wordAssigned,
                            ),
                          );
                        } else if (gameController.gameType == "question") {
                          await Get.to(
                            () => QuestionRevealScreen(
                              playerName: player.name,
                              category: player.wordCategory,
                              question: player.questions,
                              isImposter: player.isImposter,
                              answer: player.answer,
                            ),
                          );
                        }
                        controller.markRevealed(player.id);
                      },
                      child: _playerCard(player.name, index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playerCard(String name, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.votingBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryButtonBorderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryButtonBorderColor,
                  AppColors.primaryButtonColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              "P",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Player ${index + 1}",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.background,
            ),
          ),
        ],
      ),
    );
  }
}
