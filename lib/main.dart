import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:trily/pages/onboarding.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget splash = SplashScreenView(
      navigateRoute: OnBoarding(),
      duration: 5000,
      imageSize: 130,
      imageSrc: "assets/images/logo-splash.jpeg",
      text: "TRILY",
      textType: TextType.ColorizeAnimationText,
      textStyle: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      colors: [
        Colors.black,
        Colors.blue.shade100,
        Colors.black,
      ],
      backgroundColor: Colors.white,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash,
    );
  }
}