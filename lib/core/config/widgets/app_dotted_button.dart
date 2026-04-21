import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';

class AppDottedButton extends StatelessWidget {
  const AppDottedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });
  final String buttonText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DottedBorder(
        options: RectDottedBorderOptions(
          dashPattern: const [2, 2],
          strokeWidth: 1,
          color: ColorManager.primary,
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: 8.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SvgPicture.asset(IconPath.addIcon),
                const SizedBox(width: 1.5),
                Text(buttonText, style: AppTextStyles.semiBold10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
