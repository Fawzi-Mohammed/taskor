import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/extensions/text_style_extension.dart';

class AppSnackBar {
  AppSnackBar._();

  static void showError(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      accentColor: ColorManager.errorColor,
      icon: Icons.error_outline_rounded,
    );
  }

  static void showSuccess(BuildContext context, {required String message}) {
    _show(
      context,
      message: message,
      accentColor: ColorManager.doneColor,
      icon: Icons.check_circle_outline_rounded,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color accentColor,
    required IconData icon,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        content: _LiquidSnackBarContent(
          message: message,
          accentColor: accentColor,
          icon: icon,
        ),
      ),
    );
  }
}

class _LiquidSnackBarContent extends StatelessWidget {
  const _LiquidSnackBarContent({
    required this.message,
    required this.accentColor,
    required this.icon,
  });

  final String message;
  final Color accentColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.35),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.2),
                accentColor.withValues(alpha: 0.17),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withValues(alpha: 0.18),
                ),
                child: Icon(icon, size: 17, color: accentColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium12.withColor(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
