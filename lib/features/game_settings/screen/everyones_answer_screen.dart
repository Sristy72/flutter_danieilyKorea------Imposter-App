import 'package:danielyikorea/features/game_settings/screen/discussion_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';
import '../../../core/common/constants/app_images.dart';
import '../../../core/common/widgets/app_scaffold.dart';
import '../data/models/game_start_response_model.dart';

class EveryonesAnswerScreen extends StatefulWidget {
  final String question;
  final List<Player> players;

  const EveryonesAnswerScreen({
    super.key,
    required this.question,
    required this.players,
  });

  @override
  State<EveryonesAnswerScreen> createState() => _EveryonesAnswerScreenState();
}

class _EveryonesAnswerScreenState extends State<EveryonesAnswerScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Text('Everyone’s Answers'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.wordRevealBack,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.votingBorder4,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Question from data
                      Text(
                        widget.question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 156),

                Text(
                  'This is the question. Soon you will see all answers and then discuss who is lying about their answer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                SizedBox(height: 32),

                //Start Round Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => DiscussionPhaseScreen(players: widget.players, question: widget.question));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Start Round',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
      ),
    );
  }
}
