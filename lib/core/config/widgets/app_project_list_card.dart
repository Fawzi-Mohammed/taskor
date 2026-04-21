import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/widgets/app_custom_card.dart';
import 'package:taskor/core/config/widgets/app_linear_progress_bar.dart';

class AppProjectListCard extends StatelessWidget {
  const AppProjectListCard({
    super.key,
    required this.projectTitle,
    required this.clientName,
    required this.projectTitleTextStyle,
    required this.clientNameTextStyle,
    required this.numberOfTasksOrProjects,
    required this.currentTaskOrProjects,
    required this.numberOFFinishedHours,
    required this.numberOfTotalHours,
    required this.numberOFFinishedTasks,
    required this.numberOfTotalTasks,
  });
  final String projectTitle;
  final String clientName;
  final TextStyle projectTitleTextStyle;
  final TextStyle clientNameTextStyle;
  final int numberOfTasksOrProjects;
  final int currentTaskOrProjects;
  final int numberOFFinishedHours;
  final int numberOfTotalHours;
  final int numberOFFinishedTasks;
  final int numberOfTotalTasks;
  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.s10,
          vertical: AppSizes.s10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppProjectListCardHeader(
              projectTitle: projectTitle,
              clientName: clientName,
              projectTitleTextStyle: projectTitleTextStyle,
              clientNameTextStyle: clientNameTextStyle,
            ),
            const SizedBox(height: AppSizes.s12),
            AppProjectListCardProgressPart(
              numberOFFinishedHours: numberOFFinishedHours,
              numberOfTotalHours: numberOfTotalHours,
              numberOfTasksOrProjects: numberOfTasksOrProjects,
              currentTaskOrProjects: currentTaskOrProjects,
              numberOFFinishedTasks: numberOFFinishedTasks,
              numberOfTotalTasks: numberOfTotalTasks,
            ),
          ],
        ),
      ),
    );
  }
}

class AppProjectListCardHeader extends StatelessWidget {
  const AppProjectListCardHeader({
    super.key,
    required this.projectTitle,
    required this.clientName,
    required this.projectTitleTextStyle,
    required this.clientNameTextStyle,
  });
  final String projectTitle;
  final String clientName;
  final TextStyle projectTitleTextStyle;
  final TextStyle clientNameTextStyle;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(projectTitle, style: projectTitleTextStyle),
        const SizedBox(height: AppSizes.s2),
        Row(
          children: [
            Text(
              AppStrings.clientString,
              style: AppTextStyles.medium8.withColor(
                ColorManager.subtitleAndToDoColor,
              ),
            ),

            Text(clientName, style: clientNameTextStyle),
          ],
        ),
      ],
    );
  }
}

class AppProjectListCardProgressPart extends StatelessWidget {
  const AppProjectListCardProgressPart({
    super.key,
    required this.numberOfTasksOrProjects,
    required this.currentTaskOrProjects,
    required this.numberOFFinishedHours,
    required this.numberOfTotalHours,
    required this.numberOFFinishedTasks,
    required this.numberOfTotalTasks,
  });
  final int numberOfTasksOrProjects;
  final int currentTaskOrProjects;
  final int numberOFFinishedHours;
  final int numberOfTotalHours;
  final int numberOFFinishedTasks;
  final int numberOfTotalTasks;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.progressString,
              style: AppTextStyles.medium8.withColor(
                ColorManager.subtitleAndToDoColor,
              ),
            ),
            const SizedBox(height: AppSizes.s2),
            AppProjectListProgressIndicator(
              numberOfTasksOrProjects: numberOfTasksOrProjects,
              currentTaskOrProjects: currentTaskOrProjects,
            ),
          ],
        ),
        const SizedBox(height: AppSizes.s2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppProjectListCardIcon(
                iconPath: IconPath.remainingTime,

                text:
                    '$numberOFFinishedHours / $numberOfTotalHours ${AppStrings.hoursString}',
              ),

              const SizedBox(width: AppSizes.s40),
              AppProjectListCardIcon(
                iconPath: IconPath.remainingTasksInProject,

                text:
                    '$numberOFFinishedTasks/$numberOfTotalTasks ${AppStrings.tasksString.toLowerCase()}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppProjectListProgressIndicator extends StatelessWidget {
  const AppProjectListProgressIndicator({
    super.key,
    required this.numberOfTasksOrProjects,
    required this.currentTaskOrProjects,
  });

  final int numberOfTasksOrProjects;
  final int currentTaskOrProjects;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AppLinearProgressBar(
            numberOfTasksOrProjects: numberOfTasksOrProjects,
            currentTaskOrProjects: currentTaskOrProjects,
          ),
        ),
        const SizedBox(width: AppSizes.s16),
        Text(
          '${(currentTaskOrProjects / numberOfTasksOrProjects) * 100}${AppStrings.percentageString}',
          style: AppTextStyles.bold12,
        ),
      ],
    );
  }
}

class AppProjectListCardIcon extends StatelessWidget {
  const AppProjectListCardIcon({
    super.key,
    required this.iconPath,
    required this.text,
  });
  final String iconPath;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, fit: BoxFit.cover),
        const SizedBox(width: AppSizes.s4),
        Text(text, style: AppTextStyles.medium8),
      ],
    );
  }
}
