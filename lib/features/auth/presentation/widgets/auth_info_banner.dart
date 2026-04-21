import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';

class AuthInfoBanner extends StatelessWidget {
  const AuthInfoBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.s12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppSizes.s6),
      ),
      child: Text(message, textAlign: TextAlign.center),
    );
  }
}
