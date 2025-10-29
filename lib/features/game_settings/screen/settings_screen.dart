import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/how_to_play/screen/how_to_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/common/widgets/app_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildContainer(
              AppImages.howPlay,
              'How to play',
              'Learn the rules',
              () {
                Get.to(() => HowToPlayScreen());
              },
            ),

            SizedBox(height: 16),

            buildContainer(
              AppImages.star,
              'Rate App',
              'Love the game? Leave a review',
              () {},
            ),

            SizedBox(height: 16),

            buildContainer(
              AppImages.feedback,
              'Send Feedback',
              'Share ideas for improvement',
              () {},
            ),

            SizedBox(height: 32),
            Text(
              'App Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),

            SizedBox(height: 16),
            buildContainer(AppImages.version, 'App Version', '1.0.0', () {}),
          ],
        ),
      ),
    );
  }

  Container buildContainer(
    final String image,
    final String text1,
    final String text2,
    final VoidCallback? onTap,
  ) {
    return Container(
      //height: 100,
      decoration: BoxDecoration(
        color: AppColors.wordRevealBack1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.settingBack,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(image),
                      ),
                    ),
                  ),
                ),

                /// This stays as Expanded
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        text2,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 28.0, left: 5),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.settingBack,
                ),
                height: 23,
                width: 23,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(child: Image.asset(AppImages.forwardArrow)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
