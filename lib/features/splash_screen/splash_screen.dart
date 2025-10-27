import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/word_game/word_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/common/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds and then navigate
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => WordGameScreen()); // <-- change route name if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.splashScreenColor1,
              AppColors.splashScreenColor2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.appLogo,
            height: 220,
            width: 220,
          ),
        ),
      ),
    );
  }
}
