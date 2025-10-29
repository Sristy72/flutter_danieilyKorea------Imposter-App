import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/game_settings/screen/game_setting_screen.dart';
import 'package:danielyikorea/features/how_to_play/screen/how_to_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';

import '../../core/common/widgets/app_scaffold.dart';

class WordGameScreen extends StatefulWidget {
  const WordGameScreen({super.key});

  @override
  State<WordGameScreen> createState() => _WordGameScreenState();
}

class _WordGameScreenState extends State<WordGameScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(AppImages.logWhite, height: 130, width: 130),
                  ),

                  SizedBox(height: 24),
                  Text(
                    'Word Game',
                    style: TextStyle(color: Colors.white,fontSize: 24, fontWeight: FontWeight.w700),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'A game with many hidden clues',
                    style: TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.w500),
                  ),

                  SizedBox(height: 110),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => GameSettingsScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 12,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {Get.to(() => HowToPlayScreen());},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(
                          color: AppColors.primaryButtonBorderColor, // Border color
                          width: 1,           // Border width
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4), // Rounded corners
                        ),
                      ),
                      child: Text(
                        'How to play',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  Gap.bottomBarGap
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
