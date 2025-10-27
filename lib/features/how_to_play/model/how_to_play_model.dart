import 'package:flutter/material.dart';
import 'package:danielyikorea/core/common/constants/app_images.dart';

class HowToPlayModel {
  final String title;
  final String description;
  final Image image;

  HowToPlayModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

final List<HowToPlayModel> howToPlayItems = [
  HowToPlayModel(
    title: "Setup Game",
    description:
    "Choose players and pick word categories. One player will be the secret imposter!",
    image: Image.asset(AppImages.setupGame),
  ),
  HowToPlayModel(
    title: "Reveal Words",
    description:
    "Everyone sees their word except the imposter – they only see the category.",
    image: Image.asset(AppImages.revealWords), // <-- replace with your image asset
  ),
  HowToPlayModel(
    title: "Give Clues",
    description:
    "Take turns saying words related to your secret. Try not to be too obvious!",
    image: Image.asset(AppImages.giveClues),
  ),
  HowToPlayModel(
    title: "Find the Imposter",
    description:
    "Discuss and vote on who doesn’t know the word. If you’re wrong, imposter wins!",
    image: Image.asset(AppImages.findTheImposter),
  ),
];
