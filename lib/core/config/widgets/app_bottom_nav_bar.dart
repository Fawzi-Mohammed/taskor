import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/constants/app_strings.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    this.horizontalPadding = 68,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: AppSizes.s20,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: AppSizes.r16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.s16,
              vertical: AppSizes.s12,
            ),
            child: GNav(
              selectedIndex: currentIndex,
              onTabChange: onChanged,

              gap: AppSizes.s8,
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s14),
              tabBorderRadius: 999,
              tabBackgroundColor: Colors.white,
              backgroundColor: Colors.transparent,

              textStyle: AppTextStyles.semiBold10,
              color: Colors.white,
              activeColor: ColorManager.primary,

              tabs: [
                _svgTab(
                  isActive: currentIndex == 0,
                  text: AppStrings.homeString,
                  activeIconPath: IconPath.activeHome,
                  inactiveIconPath: IconPath.home,
                ),
                _svgTab(
                  isActive: currentIndex == 1,
                  text: AppStrings.projectsString,
                  activeIconPath: IconPath.activeProject,
                  inactiveIconPath: IconPath.project,
                ),
                _svgTab(
                  isActive: currentIndex == 2,
                  text: AppStrings.profileString,
                  activeIconPath: IconPath.activeProfile,
                  inactiveIconPath: IconPath.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GButton _svgTab({
    required bool isActive,
    required String text,
    required String activeIconPath,
    required String inactiveIconPath,
  }) {
    return GButton(
      text: text,

      // Keep icon slot but hide it (because we use leading)
      icon: Icons.circle,
      iconColor: Colors.transparent,

      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.s10),
        child: SvgPicture.asset(isActive ? activeIconPath : inactiveIconPath),
      ),
    );
  }
}
