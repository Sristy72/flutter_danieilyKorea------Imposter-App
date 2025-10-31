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
    final controller = Get.find<RevealedWordController>();
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
                child: Obx(() {
                  // This is the magic line
                  controller.revealed.length;

                  return GridView.builder(
                    itemCount: data.players.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.15,
                        ),
                    itemBuilder: (context, index) {
                      final player = data.players[index];
                      final isRevealed = controller.revealed.contains(
                        player.id,
                      );

                      return GestureDetector(
                        onTap: isRevealed
                            ? null
                            : () async {
                                if (gameController.gameType == "word") {
                                  await Get.to(
                                    () => WordRevealScreen(
                                      playerName: player.name,
                                      category: player.wordCategory,
                                      word: player.wordAssigned,
                                    ),
                                  );
                                } else if (gameController.gameType ==
                                    "question") {
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
                        child: _playerCard(
                          name: player.name,
                          index: index,
                          isRevealed: isRevealed,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playerCard({
    required String name,
    required int index,
    required bool isRevealed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isRevealed
            ? AppColors.votingBackground.withOpacity(0.5)
            : AppColors.votingBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isRevealed
              ? const Color.fromARGB(255, 50, 57, 102)
              : AppColors.primaryButtonBorderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isRevealed
                    ? [
                        const Color.fromARGB(255, 50, 57, 102),
                        const Color.fromARGB(255, 52, 23, 83),
                      ]
                    : [
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
              style: TextStyle(
                fontSize: 30,
                color: isRevealed ? Colors.white70 : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Player ${index + 1}",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: isRevealed ? Colors.grey : AppColors.background,
            ),
          ),
        ],
      ),
    );
  }
}
