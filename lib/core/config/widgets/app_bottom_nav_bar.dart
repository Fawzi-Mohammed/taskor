import 'package:flutter/material.dart';
import 'package:taskor/core/config/constants/color_manager.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,

    // required this.currentIndex,
    // required this.onTap,
  });

  // final int currentIndex;
  // final ValueChanged<int> onTap;
  // final Color selectedColor;
  // final Color unSelectedItemColor;
  // final Color backGroundColor;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: (value) {},

      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Projects',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
