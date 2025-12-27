import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.backGroundColor,
    required this.borderRadius,
    required this.textStyle,
  });
  final String label;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backGroundColor;
  final double borderRadius;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(label, style: textStyle),
      ),
    );
  }
}
