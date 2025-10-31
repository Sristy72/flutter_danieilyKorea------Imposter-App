import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/game_settings/screen/game_setting_screen.dart';
import 'package:danielyikorea/features/how_to_play/screen/how_to_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';

import '../../core/common/widgets/app_scaffold.dart';

class WordGameScreen extends StatelessWidget {
  const WordGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // ────── TOP CONTENT (logo + texts) ──────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Gap.bottomBarGap,
                          Image.asset(
                            AppImages.logWhite,
                            height: 130,
                            width: 130,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Word Game',
                            style: TextStyle(
                              color: AppColors.votingBorder4,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'A game with many hidden clues',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),

                // ────── BOTTOM BUTTON SECTION ──────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    // optional: subtle background for the sticky area
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── GET STARTED (GRADIENT) ──
                      _gradientButton(
                        onTap: () => Get.to(() => GameSettingsScreen()),
                        label: 'Get Started',
                      ),
                      const SizedBox(height: 12),

                      // ── HOW TO PLAY (BORDERED) ──
                      _borderedButton(
                        onPressed: () => Get.to(() => const HowToPlayScreen()),
                        label: 'How to play',
                      ),

                      // Gap.bottomBarGap, // your existing gap
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ────────────────── GRADIENT BUTTON ──────────────────
  Widget _gradientButton({required VoidCallback onTap, required String label}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
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
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // ────────────────── BORDERED BUTTON ──────────────────
  Widget _borderedButton({
    required VoidCallback onPressed,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          side: const BorderSide(color: AppColors.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
