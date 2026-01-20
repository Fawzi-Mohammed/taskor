import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/color_manager.dart';

class AppLinearProgressBar extends StatelessWidget {
  const AppLinearProgressBar({
    super.key,
    required this.numberOfTasksOrProjects,
    required this.currentTaskOrProjects,
  });
  final int numberOfTasksOrProjects;
  final int currentTaskOrProjects;
  @override
  Widget build(BuildContext context) {
    return LinearProgressBar(
      maxSteps: numberOfTasksOrProjects,
      progressType: ProgressType.linear,
      currentStep: currentTaskOrProjects,
      progressColor: ColorManager.primary,
      backgroundColor: const Color(0XFFE2E8F0),
      animateProgress: true,
      animationDuration: Duration(milliseconds: 500),
      animationCurve: Curves.easeInOut,
      borderRadius: BorderRadiusGeometry.circular(AppSizes.s4),
    );
  }
}
