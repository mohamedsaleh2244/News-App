import 'package:flutter/material.dart';
class OnBoardingScreen extends StatefulWidget {
  static String id = "OnBoardingScreen";
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("On Boarding"));
  }
}
