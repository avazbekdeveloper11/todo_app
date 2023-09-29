import 'package:flutter/material.dart';
import 'package:todo_app/presentation/styles/style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Style.white,
      body: Center(
        child: Text(
          'splash screen',
        ),
      ),
    );
  }
}
