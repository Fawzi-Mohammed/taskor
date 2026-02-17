import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskor/core/config/constants/image_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width = 156, this.height = 155});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImagePath.logo,
      width: width,
      height: height,
      alignment: Alignment.center,
    );
  }
}
