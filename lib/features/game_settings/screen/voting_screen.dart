import 'package:danielyikorea/core/common/constants/app_colors.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';
import 'package:danielyikorea/features/game_settings/screen/secret_word_screen.dart';
import 'package:flutter/material.dart';
import 'package:danielyikorea/core/common/widgets/app_scaffold.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';

import '../data/models/game_start_response_model.dart';

class VotingPhaseScreen extends StatelessWidget {
  final List<Player> players;

  const VotingPhaseScreen( this.players,{super.key,});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Voting Phase",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
          
              /// Header
              const Text(
                "Time to discuss and vote for the imposter!",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 20),
          
              /// Section title
              const Text(
                "How to vote",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 16),
          
              /// PHASE CARDS
              _phaseCard(
                images: AppImages.person,
                title: "Starting Player",
                description: "c starts the round",
                color1: AppColors.votingBackground,
                color2: AppColors.votingBorder1,
                color3: AppColors.votingNotificationBack,
                color4: AppColors.votingImageback1
              ),
              const SizedBox(height: 12),
              _phaseCard(
                images: AppImages.persons,
                title: "Group Discussion",
                description: "go clockwise",
                color1: AppColors.votingBackground,
                color2: AppColors.votingBorder4,
                color3: AppColors.votingBorder4,
                  color4: AppColors.votingImageback2
              ),
              const SizedBox(height: 12),
              _phaseCard(
                images: AppImages.votingTime,
                title: "Vote Time",
                description:
                    "Each player says a word related to the secret.\nGo around two or three times.",
                color1: AppColors.votingBackground,
                color2: AppColors.votingBorder2,
                color3: AppColors.votingBorder2,
                color4: AppColors.votingImageback3
              ),
              const SizedBox(height: 12),
              _phaseCard(
                images: AppImages.revealFace,
                title: "Reveal Phase",
                description:
                    "Vote for the player you think is the imposter, then tap to reveal the results.",
                color1: AppColors.votingBackground,
                color2: AppColors.votingBorder3,
                color3: AppColors.votingBorder3,
                color4: AppColors.votingImageback4
              ),
          
              SizedBox(height: 40,),
          
              /// REVEAL RESULTS BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
        
                    // Get.snackbar(
                    //   "Voting Complete",
                    //   "Revealing results...",
                    //   backgroundColor: Colors.white,
                    //   colorText: Colors.black,
                    // );
                    Get.to(() => SecretWordScreen(players));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.revealButton,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Reveal Results",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
        
              Gap.bottomBarGap
            ],
          ),
        ),
      ),
    );
  }

  /// Phase Card Widget
  Widget _phaseCard({
    required String images,
    required String title,
    required String description,
    required Color color1,
    required Color color2,
    required Color color3,
    required Color color4,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color1,
        border: Border.all(width: 1, color: color2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8, bottom: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: color4,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Container(height:35, width: 35, child: Image.asset(images))),
                    ),
                    Positioned(right: 0, top: -2,
                        child: Container(
                            decoration: BoxDecoration(
                              color: color3,
                              shape: BoxShape.circle,

                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('2'),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      //height: 1.3,
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
}
