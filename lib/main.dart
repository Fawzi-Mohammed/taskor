import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/widgets/app_project_list_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppProjectListCard(
                numberOFFinishedTasks: 2,
                numberOfTotalTasks: 5,
                numberOFFinishedHours: 10,
                numberOfTotalHours: 40,
                numberOfTasksOrProjects: 5,
                currentTaskOrProjects: 3,
                projectTitle: 'Flutter',
                clientName: 'flutter.dev',
                projectTitleTextStyle: AppTextStyles.semiBold14.withColor(
                  ColorManager.primary,
                ),
                clientNameTextStyle: AppTextStyles.medium8.withColor(
                  ColorManager.subtitleAndToDoColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
