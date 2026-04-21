import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';
import 'package:taskor/core/config/extensions/padding_extension.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.backGroundColor,
    required this.borderRadius,
    required this.textStyle,
    this.borderColor,
    this.borderWidth = 1,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color backGroundColor;
  final double borderRadius;
  final TextStyle textStyle;
  final Color? borderColor;
  final double borderWidth;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          disabledBackgroundColor: backGroundColor.withValues(alpha: 0.85),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
        ),
        child:
            (isLoading
                    ? SizedBox(
                        width: AppSizes.icon20,
                        height: AppSizes.icon20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            textStyle.color ?? Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        label,
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ))
                .padSym(vertical: AppSizes.s14),
      ),
    );
  }
}
