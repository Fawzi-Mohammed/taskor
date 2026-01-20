import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/app_sizes.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
    required this.activeColor,
    required this.inActiveColor,
    this.activeWidth = AppSizes.s29,
    this.inActiveWidth = AppSizes.s6,
    this.height = AppSizes.s6,
    this.spacing = AppSizes.s2,
    this.borderRadius = AppSizes.r100,
  });
  final int currentIndex;
  final int totalDots;
  final Color activeColor;
  final Color inActiveColor;
  final double activeWidth;
  final double inActiveWidth;
  final double height;
  final double spacing;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: spacing),
          duration: Duration(milliseconds: 250),
          width: isActive ? activeWidth : inActiveWidth,
          height: height,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inActiveColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      }),
    );
  }
}
