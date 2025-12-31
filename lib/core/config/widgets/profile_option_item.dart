import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/widgets/app_custom_card.dart';

class ProfileOptionItem extends StatelessWidget {
  const ProfileOptionItem({super.key, required this.options});

  final List<ProfileOptionData> options;

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < options.length; i++) ...[
            if (i != 0) const SizedBox(width: AppSizes.s6),
            ProfileOptionTile(option: options[i]),
          ],
        ],
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  const ProfileOptionTile({super.key, required this.option});

  final ProfileOptionData option;

  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s12,
          horizontal: AppSizes.s14,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              option.iconPath,
              width: AppSizes.icon20,
              height: AppSizes.icon20,
            ),
            const SizedBox(height: AppSizes.s4),
            Text(option.value, style: AppTextStyles.bold12),
            Text(option.label, style: AppTextStyles.medium12),
          ],
        ),
      ),
    );
  }
}

class ProfileOptionData {
  const ProfileOptionData({
    required this.iconPath,
    required this.value,
    required this.label,
  });

  final String iconPath;
  final String value;
  final String label;
}
