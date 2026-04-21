import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.projectName,
    required this.onDelete,
    required this.content,
  });
  final String projectName;
  final VoidCallback onDelete;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: AppSizes.s14,
        horizontal: AppSizes.s8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r6),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
        child: Text(
          'Are You Sure?',
          style: AppTextStyles.semiBold14.withColor(ColorManager.primary),
          textAlign: TextAlign.center,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
        child: content,
      ),
       
      actions: [
        Row(
          children: [
            Expanded(
              child: AppElevatedButton(
                label: AppStrings.deleteString,
                borderColor: ColorManager.errorColor,

                onPressed: () {
                  Navigator.pop(context);
                  onDelete();
                },
                backGroundColor: Colors.white,
                borderRadius: AppSizes.s4,
                textStyle: AppTextStyles.bold15.withColor(
                  ColorManager.errorColor,
                ),
              ),
            ),
            SizedBox(width: AppSizes.s12),
            Expanded(
              child: AppElevatedButton(
                label: AppStrings.cancelString,
                onPressed: () {
                  Navigator.pop(context);
                },
                backGroundColor: ColorManager.primary,
                borderRadius: AppSizes.s4,
                textStyle: AppTextStyles.bold15.withColor(Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
