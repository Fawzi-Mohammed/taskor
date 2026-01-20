import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.childe,
    required this.backGroundColor,
    required this.borderColor,
  });
  final Widget childe;
  final Color backGroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.s1_5,
        horizontal: AppSizes.r15,
      ),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(AppSizes.r15),
        border: BoxBorder.all(width: AppSizes.s0_5, color: borderColor),
      ),
      child: childe,
    );
  }
}
