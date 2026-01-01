import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.alignment = Alignment.center,
  });

  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style:
              textStyle ??
              const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
        ),
      ),
    );
  }
}
