import 'package:flutter/material.dart';
import 'package:taskor/core/config/widgets/app_dotted_button.dart';

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
          child: AppDottedButton(
            buttonText: 'Add Task',
            onTap: () {
              // Handle button tap
            },
          ),
      )),
    );
  }
}
