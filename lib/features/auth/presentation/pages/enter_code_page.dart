import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';
import 'package:taskor/core/config/extensions/validation_extension.dart';
import 'package:taskor/core/config/router/routers_name.dart';
import 'package:taskor/core/config/widgets/app_elevated_button.dart';
import 'package:taskor/core/config/widgets/app_header.dart';
import 'package:taskor/core/config/widgets/otp_field.dart';

class EnterCodePage extends StatefulWidget {
  const EnterCodePage({super.key});

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  String _code = '';
  bool? _isCodeValid;

  void _handleCodeChanged(String value) {
    setState(() {
      _code = value;
      _isCodeValid = null;
    });
  }

  void _handleVerify() {
    final error = _code.validateCode(length: 4);
    setState(() {
      _isCodeValid = error == null;
    });
    if (error == null) {
      FocusScope.of(context).unfocus();
      context.go(RoutesName.resetPassword);
    }
  }

  Color _currentBorderColor() {
    if (_isCodeValid == null) {
      return ColorManager.subtitleAndToDoColor;
    }
    return _isCodeValid! ? ColorManager.doneColor : ColorManager.errorColor;
  }

  @override
  Widget build(BuildContext context) {
    final errorTextStyle = AppTextStyles.medium11.withColor(
      ColorManager.errorColor,
    );
    final validTextStyle = AppTextStyles.medium11.withColor(
      ColorManager.doneColor,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.s12),
              const AppHeader(title: AppStrings.enterCodeTitleString),
              const SizedBox(height: AppSizes.s16),
              Text(
                AppStrings.enterCodeSubtitleString,
                style: AppTextStyles.regular13,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.s24),
              OtpFieldWidget(
                borderColor: _currentBorderColor(),
                focusedBorderColor: _currentBorderColor(),
                onChanged: _handleCodeChanged,
                onCompleted: _handleCodeChanged,
              ),
              if (_isCodeValid != null) ...[
                const SizedBox(height: AppSizes.s12),
                Text(
                  _isCodeValid!
                      ? AppStrings.correctCodeString
                      : AppStrings.verifyCodeErrorString,
                  style: _isCodeValid! ? validTextStyle : errorTextStyle,
                ),
              ],
              const SizedBox(height: AppSizes.s48),
              Text(
                AppStrings.dontReceiveCodeString,
                style: AppTextStyles.regular10,
              ),
              const SizedBox(height: AppSizes.s10),
              GestureDetector(
                onTap: () {},
                child: Text(
                  AppStrings.resendCodeString,
                  style: AppTextStyles.regular10.withColor(
                    ColorManager.primary,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.s24),
              AppElevatedButton(
                label: AppStrings.verifyEmailString,
                onPressed: _handleVerify,
                backGroundColor: ColorManager.primary,
                borderRadius: AppSizes.s4,
                textStyle: AppTextStyles.bold15.withColor(Colors.white),
              ),
              const SizedBox(height: AppSizes.s24),
            ],
          ),
        ),
      ),
    );
  }
}
