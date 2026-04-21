import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/image_path.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/app_header.dart';

class LoginFailedPage extends StatelessWidget {
  const LoginFailedPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSizes.s12),
            const AppHeader(),
            const Spacer(),
            Image.asset(ImagePath.loginImage),
            const SizedBox(height: AppSizes.s32),
            Text(
              AppStrings.loginFailedString,
              style: AppTextStyles.bold18.withColor(ColorManager.primary),
            ),
            const SizedBox(height: AppSizes.s6),
            Text(
             AppStrings.loginFailedSubtitleString,
              style: AppTextStyles.regular13,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.s40),
            AppElevatedButton(
              label: AppStrings.tryAgainString,
              onPressed: () => context.go(RoutesName.login),
              backGroundColor: ColorManager.primary,
              borderRadius: AppSizes.s4,
              textStyle: AppTextStyles.bold15.withColor(Colors.white),
            ),
            const SizedBox(height: AppSizes.s10),
            AppElevatedButton(
              label: AppStrings.forgetPasswordString,
              onPressed: () => context.go(RoutesName.forgotEmail),
              backGroundColor: Colors.white,
              borderRadius: AppSizes.s4,
              borderColor: ColorManager.primary,
              textStyle: AppTextStyles.semiBold15,
            ),
            const Spacer(),
            const SizedBox(height: AppSizes.s24),
          ],
        ).padSym(horizontal: AppSizes.s20),
      ),
    );
  }
}
