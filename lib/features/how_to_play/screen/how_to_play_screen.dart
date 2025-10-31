import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/core/common/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';

import '../model/how_to_play_model.dart';

class HowToPlayScreen extends StatelessWidget {
  const HowToPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("How to play", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListView.builder(
              itemCount: howToPlayItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = howToPlayItems[index];
                return _stepCard(item);
              },
            ),
            const SizedBox(height: 20),
            _proTipsCard(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _stepCard(HowToPlayModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.howToPlayTextBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 13,
          bottom: 18,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              decoration: BoxDecoration(
                color: AppColors.howToPlayIconBackground,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(width: 20, height: 20, child: item.image),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _proTipsCard() {
    return Container(
      // padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3AFF),
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            AppColors.howToPlayTipBackground1,
            AppColors.howToPlayTipBackground2,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // color: AppColors.tipsBackground,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Image.asset(AppImages.proTips),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Pro Tips",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Imposter should listen carefully and try to blend in. Give clues that could fit the category!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
