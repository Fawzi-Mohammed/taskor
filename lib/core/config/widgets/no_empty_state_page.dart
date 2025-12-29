import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/widgets/app_dotted_button.dart';

class NoEmptyStatePage extends StatelessWidget {
  const NoEmptyStatePage({
    super.key,
    required this.appBarTitle,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.titleTextStyle,
    required this.subTitleTextStyle,
    required this.onTap,
  });
  final String appBarTitle;
  final String title;
  final String subTitle;
  final String buttonText;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: titleTextStyle),
          const SizedBox(height: AppSizes.s8),
          Text(subTitle, style: subTitleTextStyle, textAlign: TextAlign.center),
          const SizedBox(height: AppSizes.s16),
          AppDottedButton(buttonText: buttonText, onTap: onTap),
        ],
      ),
    );
  }
}
