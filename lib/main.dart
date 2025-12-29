import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart'
    show LinearProgressBar, ProgressType;
import 'package:taskor/core/config/constants/app_text_styles.dart';
import 'package:taskor/core/config/constants/color_manager.dart';
import 'package:taskor/core/config/widgets/app_custom_card.dart';
import 'package:taskor/core/config/widgets/app_dash_board_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: Scaffold(
        body: Center(

      )),
    );
  }
}
