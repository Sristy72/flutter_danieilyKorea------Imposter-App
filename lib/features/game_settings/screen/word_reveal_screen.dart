import 'package:danielyikorea/core/common/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/core/theme/gap.dart';
import 'package:get/get.dart';
import '../../../core/common/constants/app_colors.dart';
import '../../../core/common/constants/app_images.dart';

class WordRevealScreen extends StatefulWidget {
  final String playerName;
  final String category;
  final String word;

  const WordRevealScreen({
    super.key,
    required this.playerName,
    required this.category,
    required this.word,
  });

  @override
  State<WordRevealScreen> createState() => _WordRevealScreenState();
}

class _WordRevealScreenState extends State<WordRevealScreen> {
  bool revealed = false;

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
                  text: "The word for ",
                  style: const TextStyle(
                    color: Colors.white,
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
                  color: Colors.white,
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
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    // image: const DecorationImage(
                    //   image: AssetImage(AppImages.boxImage), // COMMON IMAGE
                    //   fit: BoxFit.cover,
                    // ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: revealed
                      ? Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.wordRevealBack,
                            borderRadius: BorderRadius.circular(4),
                            border: widget.word == 'Imposter'
                                ? Border.all(color: AppColors.red, width: 3)
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              widget.word,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: widget.word == 'Imposter'
                                    ? AppColors.red1
                                    : AppColors.proBackground,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: AppColors.imageBorder,
                            ),
                            // color: Colors.black,
                            image: const DecorationImage(
                              image: AssetImage(
                                AppImages.boxImage,
                              ), // COMMON IMAGE
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 14),

              revealed
                  ? (widget.word == "Imposter"
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
                                    color: AppColors.imageBorder1,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    disabledBackgroundColor: Colors.transparent,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF41194F),
                                          Color(0xFF271231),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Got it!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Gap.bottomBarGap,
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      disabledBackgroundColor:
                                          Colors.transparent,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF41194F),
                                            Color(0xFF271231),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Got it!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap.bottomBarGap,
                            ],
                          ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          child: Image.asset(AppImages.tapHere),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Tap the box to reveal",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryButtonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
