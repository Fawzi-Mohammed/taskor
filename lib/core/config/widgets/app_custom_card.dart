import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/color_manager.dart';

class AppCustomCard extends StatelessWidget {
  const AppCustomCard({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r6),
        border: BoxBorder.all(
          width: AppSizes.s0_5,
          color: ColorManager.subtitleAndToDoColor,
        ),
      ),
      child: child,
    );
  }
}
