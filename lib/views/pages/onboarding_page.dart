// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/authentication/loginpage.dart';
import 'package:follow_dp/views/pages/authentication/splash_screen.dart';
import 'package:follow_dp/views/pages/homepage.dart';
// import 'package:follow_dp/views/pages/authentication/phone_verification/phone_number_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  Future<void> checkIflogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted && user.emailVerified) {
        isLogin = true;
        Navigator.pushNamedAndRemoveUntil(
            context, "homepage", (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "loginPage", (route) => false);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIflogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
