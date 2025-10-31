import 'package:danielyikorea/features/game_settings/screen/game_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';
import '../controller/game_controller.dart';
import '../data/models/game_start_response_model.dart';

class DiscussionPhaseScreen2 extends StatelessWidget {
  final List<Player> players;
  final String question;

  const DiscussionPhaseScreen2({
    super.key,
    required this.players,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Get.offAll(GameSettingsScreen())),
        title: const Text("Discussion Phase"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Question Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.votingBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: AppColors.votingBorder4),
              ),
              child: Text(
                question,
                textAlign: TextAlign.center,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Player Answers as options
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  final String serial = (index + 1).toString();

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.votingBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: player.isImposter
                            ? AppColors.imposterBorder
                            : AppColors.staticTextBackground,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Serial Box
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: player.isImposter
                                ? AppColors.imposterSerialBack
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 1,
                              color: player.isImposter
                                  ? AppColors.imposterSerialBorder
                                  : Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              serial,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: player.isImposter
                                    ? AppColors.imposterSerial
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Text Section (FIXED with Expanded)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              player.isImposter
                                  ? Row(
                                      children: [
                                        Text(
                                          player.name,
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.imposterSerial,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            color: AppColors.imposterSerialBack,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 3,
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              'Imposter',
                                              style: TextStyle(
                                                color: AppColors.imposterSerial,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      player.name,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),

                              const SizedBox(height: 8),

                              Text(
                                player.answer.isEmpty
                                    ? "No answer"
                                    : player.answer,
                                softWrap: true,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),

                              if (player.isImposter) ...[
                                const SizedBox(height: 18),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.imposterSerialBack,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColors.imposterSerialBorder,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      player.questions,
                                      softWrap: true,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Start Round / Find Imposter Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final gameController = Get.find<GameController>();
                    gameController.resetGame();
                    Get.offAll(() => GameSettingsScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF41194F), Color(0xFF271231)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Play Again",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
