import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';

class ErrorStatePage extends StatelessWidget {
  const ErrorStatePage({
    super.key,
    required this.errorImage,
    required this.errorTitle,
    required this.errorSubTitle,
    required this.errorTitleTextStyle,
    required this.errorSubTitleTextStyle,
    required this.button1Text,
    required this.button1TextStyle,
    required this.button1OnPressed,
    required this.button1BackGroundColor,
    required this.button1BorderRadius,
    required this.button2Text,
    required this.button2TextStyle,
    required this.button2OnPressed,
    required this.button2BackGroundColor,
    required this.button2BorderRadius,
  });
  final String errorImage;
  final String errorTitle;
  final String errorSubTitle;
  final TextStyle errorTitleTextStyle;
  final TextStyle errorSubTitleTextStyle;
  final String button1Text;
  final TextStyle button1TextStyle;
  final VoidCallback button1OnPressed;
  final Color button1BackGroundColor;
  final double button1BorderRadius;
  final String button2Text;
  final TextStyle button2TextStyle;
  final VoidCallback button2OnPressed;
  final Color button2BackGroundColor;
  final double button2BorderRadius;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(errorImage, fit: BoxFit.cover),
              const SizedBox(height: 31),
              Text(errorTitle, style: errorTitleTextStyle),
              const SizedBox(height: AppSizes.s3),
              Text(
                errorSubTitle,
                style: errorSubTitleTextStyle,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 41),
              AppElevatedButton(
                label: button1Text,
                onPressed: button1OnPressed,
                backGroundColor: button1BackGroundColor,
                borderRadius: button1BorderRadius,
                textStyle: button1TextStyle,
              ),
              const SizedBox(height: 10),

              AppElevatedButton(
                label: button2Text,
                onPressed: button2OnPressed,
                backGroundColor: button2BackGroundColor,
                borderRadius: button2BorderRadius,
                textStyle: button2TextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
