import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.titleTextStyle,
    required this.subTitleTextStyle,
  });
  final String imagePath;
  final String title;
  final String subTitle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        const SizedBox(height: 40),
        Text(title, textAlign: TextAlign.center, style: titleTextStyle),
        const SizedBox(height: 20),
        Text(subTitle, textAlign: TextAlign.center, style: subTitleTextStyle),
      ],
    );
  }
}
