import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/widgets/app_custom_card.dart';

class AppDashBoardCard extends StatelessWidget {
  const AppDashBoardCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.titleTextStyle,
    required this.subTitleTextStyle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: AppSizes.r8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: titleTextStyle),
              SizedBox(height: AppSizes.s3),
              Text(subtitle, style: subTitleTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
