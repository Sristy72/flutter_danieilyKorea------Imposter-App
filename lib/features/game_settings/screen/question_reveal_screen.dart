import 'package:danielyikorea/core/common/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';
import '../../../core/common/constants/app_images.dart';
import '../controller/game_controller.dart';

class QuestionRevealScreen extends StatefulWidget {
  final String playerName;
  final String category;
  final String question;
  final String answer;
  final bool isImposter;

  const QuestionRevealScreen({
    super.key,
    required this.playerName,
    required this.category,
    required this.question,
    required this.isImposter,
    required this.answer
  });

  @override
  State<QuestionRevealScreen> createState() => _QuestionRevealScreenState();
}

class _QuestionRevealScreenState extends State<QuestionRevealScreen> {
  final TextEditingController _answerTextEditingController =
      TextEditingController();

  final gameController = Get.find<GameController>();

  late final submittedCount = gameController.players
      .where((p) => p.answer.isNotEmpty)
      .length;
  late final totalPlayers = gameController.players.length;

  bool revealed = false;
  @override
  void initState() {
    _setValue();
    super.initState();
  }

  _setValue(){
    _answerTextEditingController.text = widget.answer ?? '';
  }


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "The question for ",
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: widget.playerName,
                      style: const TextStyle(
                        color: AppColors.primaryButtonColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Category: ${widget.category}",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
          
              /// TAP BOX
              GestureDetector(
                onTap: () {
                  setState(() => revealed = true);
                },
                child: Container(
                  height: 190,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: revealed
                      ? Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.wordRevealBack1,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: AppColors.votingBorder4,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              widget.question,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.wordRevealBack1,
                            border: Border.all(
                              width:2,
                              color: AppColors.elevatedButton3
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                child: Image.asset(AppImages.lock1),
                              ),
                              SizedBox(height: 9),
                              Text(
                                "Tap the box to reveal",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
          
              const SizedBox(height: 14),
          
              revealed
                  ? (widget.question == "Imposter"
                        ? Column(
                            children: [
                              ///Clue Container
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: AppColors.wordRevealBack,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(AppImages.proTips),
                                        ),
                                        SizedBox(width: 6),
                                        const Text(
                                          "Your Clue",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
          
                                    Text(
                                      'C R O W D',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
          
                                    const Text(
                                      "Use this in this round to blend in!",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
          
                              const SizedBox(height: 269),
          
                              /// Got it Button below clue
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final answer = _answerTextEditingController.text.trim();
          
                                    if (answer.isEmpty) {
                                      Get.snackbar(
                                        "Error",
                                        "Please write an answer before submitting",
                                      );
                                      return;
                                    }
          
                                    final gameController =
                                        Get.find<GameController>();
                                    gameController.saveAnswer(
                                      widget.playerName,
                                      answer,
                                    );
          
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    backgroundColor: AppColors.primaryButtonColor,
                                  ),
                                  child: const Text(
                                    'Submit Answer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.wordRevealBack1,
                                    border: Border.all(
                                      color: AppColors.primaryButtonColor,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
          
                                  child: TextField(
                                    style: const TextStyle(color: Colors.white),
                                    controller: _answerTextEditingController,
                                    cursorColor: Colors.white,
                                    maxLines: 8,
                                    minLines: 5,
                                    decoration: InputDecoration(
                                      hintText:  'Type your answer here...',
                                      hintStyle: TextStyle(
                                        color: AppColors.hintStyle,
                                      ),
                                      fillColor: AppColors.wordRevealBack1,
                                      filled: true,
                                    ),
                                  ),
                                ),
          
                                SizedBox(height: 202),
          
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final answer = _answerTextEditingController
                                          .text
                                          .trim();
          
                                      if (answer.isEmpty) {
                                        Get.snackbar(
                                          "Error",
                                          "Please write an answer before submitting",
                                        );
                                        return;
                                      }
          
                                      final gameController =
                                          Get.find<GameController>();
                                      gameController.saveAnswer(
                                        widget.playerName,
                                        answer,
                                      );
          
                                      Get.back();
                                    },
          
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      backgroundColor: AppColors.primaryButtonColor,
                                    ),
                                    child: const Text(
                                      'Submit Answer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
          
                                SizedBox(height: 26),
          
                                Text(
                                  "$submittedCount / $totalPlayers answers submitted",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primaryButtonColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                Gap.bottomBarGap
                              ],
                            ),
                          ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 420),
          
                        Text(
                          "$submittedCount / $totalPlayers answers submitted",
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryButtonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap.bottomBarGap
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
