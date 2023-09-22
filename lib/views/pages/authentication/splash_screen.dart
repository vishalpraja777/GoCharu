import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/authentication/loginpage.dart';
import 'package:follow_dp/views/pages/onboarding_page.dart';
// import 'package:follow_dp/views/pages/authentication/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              // top: animate ? (size.height - 150) / 2 : 30,
              top: (size.height - 150) / 2,
              left: animate ? (size.width - 150) / 2 : (size.width - 50) / 2,
              duration: const Duration(milliseconds: 1600),
              width: animate ? 150.0 : 50.0,
              child: const Image(image: AssetImage(logo), width: 150))
        ],
      ),
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => animate = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()));
  }
}
