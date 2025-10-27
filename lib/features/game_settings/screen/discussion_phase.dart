import 'package:danielyikorea/features/game_settings/screen/discussion_phase1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';
import '../data/models/game_start_response_model.dart';

class DiscussionPhaseScreen extends StatelessWidget {
  final List<Player> players;
  final String question;

  const DiscussionPhaseScreen({
    super.key,
    required this.players,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Discussion Phase")),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Question Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.votingBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 2, color: AppColors.votingBorder4)
              ),
              child: Text(
                question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
        
            const SizedBox(height: 24),
        
            // Player Answers as options
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  final String serial = (index+1).toString();
                  //final optionLetter = String.fromCharCode(65 + index); // A, B, C, etc.
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.votingBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1, color: AppColors.staticTextBackground)
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 40, width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(serial,
                                style: const TextStyle( fontSize: 20,
                                    fontWeight: FontWeight.bold, color: Colors.black)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(player.name, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: Colors.white),),
        
                            Text(
                              player.answer.isEmpty ? "No answer" : player.answer,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        
            // Start Round / Find Imposter Button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => DiscussionPhaseScreen2(players: players, question: question));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.revealButton,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: const Text(
                    "Find Imposter",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
