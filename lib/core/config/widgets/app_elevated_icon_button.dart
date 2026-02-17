import 'package:flutter/material.dart';

class AppElevatedIconButton extends StatelessWidget {
  const AppElevatedIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48,
    this.backgroundColor = Colors.blue,
    this.borderRadius = 12,
    this.textStyle,
    this.iconSize = 20,
    this.spacing = 8,
    this.iconColor,
  });
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  final double width;
  final double height;
  final Color backgroundColor;
  final Color? iconColor;
  final double borderRadius;

  final TextStyle? textStyle;
  final double iconSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: iconSize, color: Colors.white),
            SizedBox(width: spacing),
            Text(
              label,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: iconColor ?? Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
