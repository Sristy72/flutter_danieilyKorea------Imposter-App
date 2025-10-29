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
    final cardWidth = (screenWidth - 48) / 2; // 16 padding + 16 spacing

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(AppImages.settings),
              ),
            ),
            onPressed: () => Get.to(() => SettingsScreen()),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ────── SCROLLABLE CONTENT ──────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Game Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ---------- Number cards ----------
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => _numberCard(
                              'Total players?',
                              controller.totalPlayers.value,
                              AppImages.playersSearch,
                              _openPickPlayers,
                              cardWidth,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Obx(
                            () => _numberCard(
                              'Total imposters?',
                              controller.totalImposters.value,
                              AppImages.impostersSearch,
                              null,
                              cardWidth,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // ---------- Game Mode ----------
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
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => GestureDetector(
                              onTap: () => controller.toggleGameMode(true),
                              child: _gameModeCard(
                                'Word Game',
                                'Find who doesn’t know the secret word',
                                controller.isWordGame.value,
                                AppImages.word,
                                AppImages.word2,
                                cardWidth,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(
                            () => GestureDetector(
                              onTap: () => controller.toggleGameMode(false),
                              child: _gameModeCard(
                                'Question Game',
                                'Find who got a different question',
                                !controller.isWordGame.value,
                                AppImages.question,
                                AppImages.question1,
                                cardWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 80,
                    ), // extra space before sticky button
                  ],
                ),
              ),
            ),

            // ────── STICKY BOTTOM BUTTON ──────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
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
                      'Start Game',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberCard(
    String title,
    int number,
    String image,
    VoidCallback? onTap,
    double cardWidth,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        width: cardWidth,
        decoration: BoxDecoration(
          color: AppColors.gameSettingBackground2,
          border: Border.all(
            width: 1,
            color: AppColors.gameSettingDiselectBorder,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.gameIconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(image),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$number',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gameModeCard(
    String title,
    String subtitle,
    bool isSelected,
    String image1,
    String image2,
    double cardWidth,
  ) {
    return Container(
      width: cardWidth,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.gameSettingBackground1
            : AppColors.gameSettingBackground2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppColors.border
              : AppColors.gameSettingDiselectBorder,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 35,
            width: 35,
            child: isSelected ? Image.asset(image1) : Image.asset(image2),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.border : AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
