import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/game_settings/controller/game_controller.dart';
import 'package:danielyikorea/features/game_settings/screen/pick_player_screen.dart';
import 'package:danielyikorea/features/game_settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';

class GameSettingsScreen extends StatelessWidget {
  GameSettingsScreen({super.key});

  final GameController controller = Get.find<GameController>();

  Future<void> _openPickPlayers() async {
    final result = await Get.to(
          () => AddPlayerScreen(initialPlayers: controller.playerNames),
    );

    if (result != null && result is List<String>) {
      controller.updatePlayers(result);
    }
  }

  void _submit() {
    String type = controller.isWordGame.value ? 'word' : 'question';
    controller.gameStart(playerNames: controller.playerNames, type: type);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardWidth = (screenWidth - 48) / 2; // 16 padding + 16 spacing

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(AppImages.settings),
            ),
            onPressed: () {
              Get.to(() => SettingsScreen());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Game Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Number cards row
              Row(
                children: [
                  Expanded(
                    child: Obx(() => _numberCard(
                      'Total players?',
                      controller.totalPlayers.value,
                      AppImages.playersSearch,
                      _openPickPlayers,
                      cardWidth,
                    )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _numberCard(
                      'Total imposters?',
                      controller.totalImposters.value,
                      AppImages.impostersSearch,
                      null,
                      cardWidth,
                    )),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Game Mode title
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 30,
                    child: Image.asset(AppImages.gameMode),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Game Mode',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Game Mode cards row
              Row(
                children: [
                  Expanded(
                    child: Obx(() => GestureDetector(
                      onTap: () => controller.toggleGameMode(true),
                      child: _gameModeCard(
                        'Word Game',
                        'Find who doesn’t know the secret word',
                        controller.isWordGame.value,
                        AppImages.word,
                        cardWidth,
                      ),
                    )),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => GestureDetector(
                      onTap: () => controller.toggleGameMode(false),
                      child: _gameModeCard(
                        'Question Game',
                        'Find who got a different question',
                        !controller.isWordGame.value,
                        AppImages.question,
                        cardWidth,
                      ),
                    )),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Start Game button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.elevatedButton1,
                          AppColors.elevatedButton2
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Gap.bottomBarGap,
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberCard(String title, int number, String image,
      VoidCallback? onTap, double cardWidth) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.imageBackground1,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(height: 20, width: 20, child: Image.asset(image)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14, color: AppColors.black, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            Text('$number',
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _gameModeCard(
      String title, String subtitle, bool isSelected, String image, double cardWidth) {
    return Container(
      width: cardWidth,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.imageBackground1 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isSelected
                ? AppColors.primaryButtonBorderColor
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1),
      ),
      child: Column(
        children: [
          SizedBox(height: 35, width: 35, child: Image.asset(image)),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.primaryButtonBorderColor
                  : AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
