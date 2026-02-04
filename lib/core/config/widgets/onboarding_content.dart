import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';

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
        Expanded(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ).padSym(horizontal: AppSizes.s24),
        ),
        const SizedBox(height: AppSizes.s24),
        Text(title, textAlign: TextAlign.center, style: titleTextStyle),
        const SizedBox(height: AppSizes.s12),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: subTitleTextStyle,
        ).padSym(horizontal: AppSizes.s24),
      ],
    );
  }
}
