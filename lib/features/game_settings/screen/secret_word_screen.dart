import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/features/game_settings/screen/game_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/game_controller.dart';
import '../data/models/game_start_response_model.dart';

class SecretWordScreen extends StatelessWidget {
  final List<Player> players;

  const SecretWordScreen(this.players, {super.key});

  @override
  Widget build(BuildContext context) {

    final imposter = players.firstWhere((p) => p.isImposter == true);
    final secretWord = players.firstWhere((p) => p.isImposter == false).wordAssigned;

    return Scaffold(
      body: Container(
        color: AppColors.votingBackground,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                child: Text(
                  'THE IMPOSTER WAS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.proBackground,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Center(
                child: Text(
                  imposter.name, //Imposter Name
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.proBackground,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(
                'SECRET WORD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.resultWord,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                secretWord, //Secret Word
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppColors.resultWord,
                ),
              ),

              const SizedBox(height: 160),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButtonColor,
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                  ),),
                    onPressed: () {
                      final gameController = Get.find<GameController>();
                      gameController.resetGame(); // reset variables
                      Get.offAll(() => GameSettingsScreen());
                    },
                    child: const Text('Play Again', style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
