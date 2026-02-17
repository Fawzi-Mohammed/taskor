import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/widgets/app_custom_card.dart';
import 'package:taskor/core/config/widgets/app_status_badge.dart';

class AppTaskListTile extends StatelessWidget {
  const AppTaskListTile({
    super.key,
    required this.taskTitle,
    required this.taskSubTitle,
    required this.taskTitleTextStyle,
    required this.taskSubTileTextStyle,
    required this.appStatusBadge,
    required this.stateColor,
  });
  final String taskTitle;
  final String taskSubTitle;
  final TextStyle taskTitleTextStyle;
  final TextStyle taskSubTileTextStyle;
  final AppStatusBadge appStatusBadge;
  final Color stateColor;
  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.directional(
              bottom: 14,
              top: 14,
              start: 12,
              end: 34,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(taskTitle, style: taskTitleTextStyle),
                Text(taskSubTitle, style: taskSubTileTextStyle),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.fromLTRB(0, 21, 25, 21),
            child: appStatusBadge,
          ),

          Container(
            decoration: BoxDecoration(
              color: stateColor,
              borderRadius: BorderRadius.circular(AppSizes.r6),
            ),
          ),
        ],
      ),
    );
  }
}
