import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    super.key,
    required this.content,
    required this.backgroundColor,
  });
  final Widget content;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SnackBar(backgroundColor: backgroundColor, content: content);
  }
}
