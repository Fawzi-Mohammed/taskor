import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';

class OtpFieldWidget extends StatelessWidget {
  const OtpFieldWidget({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.borderColor,
    this.focusedBorderColor,
  });

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final Color? borderColor;
  final Color? focusedBorderColor;

  @override
  Widget build(BuildContext context) {
    final resolvedBorderColor =
        borderColor ?? ColorManager.subtitleAndToDoColor;
    final resolvedFocusedColor = focusedBorderColor ?? ColorManager.primary;
    return OtpTextField(
      numberOfFields: 4,
      fieldWidth: AppSizes.s48,
      fieldHeight: AppSizes.s48,
      borderColor: resolvedBorderColor,
      enabledBorderColor: resolvedBorderColor,
      focusedBorderColor: resolvedFocusedColor,
      disabledBorderColor: resolvedBorderColor,
      showFieldAsBox: true,
      borderRadius: BorderRadius.circular(AppSizes.r8),
      margin: const EdgeInsets.symmetric(horizontal: AppSizes.s6),
      textStyle: AppTextStyles.regular16,
      mainAxisAlignment: MainAxisAlignment.center,
      onCodeChanged: onChanged,
      onSubmit: onCompleted,
    );
  }
}
