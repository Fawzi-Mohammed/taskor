import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.firstText,
    required this.actionText,
    required this.onTap,
    this.firstTextStyle,
    this.actionTextStyle,
    required this.textAlign,
  });
  final String firstText;
  final String actionText;
  final VoidCallback onTap;
  final TextStyle? firstTextStyle;
  final TextStyle? actionTextStyle;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style:
                firstTextStyle ??
                const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          TextSpan(
            text: actionText,
            style:
                actionTextStyle ??
                const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
