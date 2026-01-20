import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.titleTextStyle,
    required this.subTitleTextStyle,
    required this.icon,
  });
  final String imagePath;
  final String title;
  final String subTitle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagePath),
      title: Text(title, style: titleTextStyle),
      subtitle: Text(subTitle, style: subTitleTextStyle),
      trailing: Icon(icon),
    );
  }
}
