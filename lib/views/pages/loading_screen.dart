import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingAnimationWidget.horizontalRotatingDots(
          size: 75,
          // leftDotColor: Colors.black, rightDotColor: Colors.green,
          color: primaryColor,
        ),
      ),
    );
  }
}
