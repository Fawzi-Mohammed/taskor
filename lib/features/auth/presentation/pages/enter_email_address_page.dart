import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/constants/icon_path.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/extensions/validation_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/app_header.dart';
import 'package:taskor/core/config/widgets/app_text_field.dart';

class EnterEmailAddressPage extends StatefulWidget {
  const EnterEmailAddressPage({super.key});

  @override
  State<EnterEmailAddressPage> createState() => _EnterEmailAddressPageState();
}

class _EnterEmailAddressPageState extends State<EnterEmailAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.go(RoutesName.verifyCode);
  }

  void _handleCancel() {
    FocusScope.of(context).unfocus();
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.s12),
              const AppHeader(title: AppStrings.enterEmailAddressTitleString),
              const SizedBox(height: AppSizes.s16),
              Text(
                AppStrings.enterYourEmailSubtitleString,
                style: AppTextStyles.regular13,
              ),
              const SizedBox(height: AppSizes.s24),
              Form(
                key: _formKey,
                child: AppTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: Text(
                    AppStrings.enterYourEmailHintString,
                    style: AppTextStyles.regular11,
                  ),
                  errorStyle: AppTextStyles.medium11.withColor(
                    ColorManager.errorColor,
                  ),
                  errorMaxLines: 3,
                  errorSpacing: AppSizes.s12,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s6,
                    ),
                    child: SvgPicture.asset(
                      IconPath.emailIcon,
                      width: AppSizes.icon16,
                      height: AppSizes.icon16,
                      fit: BoxFit.cover,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  validator: (value) {
                    final error = value.validateEmail();
                    if (error != null) {
                      return AppStrings.enterYourAddressCorrectlyString;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: AppSizes.s32),
              AppElevatedButton(
                label: AppStrings.continueString,
                onPressed: _handleContinue,
                backGroundColor: ColorManager.primary,
                borderRadius: AppSizes.s4,
                textStyle: AppTextStyles.bold15.withColor(Colors.white),
              ),
              const SizedBox(height: AppSizes.s12),
              AppElevatedButton(
                label: AppStrings.cancelString,
                onPressed: _handleCancel,
                backGroundColor: Colors.white,
                borderRadius: AppSizes.s4,
                borderColor: ColorManager.primary,
                textStyle: AppTextStyles.semiBold15,
              ),
              const SizedBox(height: AppSizes.s24),
            ],
          ).padSym(horizontal: AppSizes.icon20),
        ),
      ),
    );
  }
}
