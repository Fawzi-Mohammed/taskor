import 'package:flutter/material.dart';

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
  });

  final String label;
  final VoidCallback onPressed;
  final Color backGroundColor;
  final double borderRadius;
  final TextStyle textStyle;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(label, style: textStyle),
        ),
      ),
    );
  }
}
