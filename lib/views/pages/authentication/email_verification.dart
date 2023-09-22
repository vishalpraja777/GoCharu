import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/homepage.dart';
import 'package:get/get.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      authController.sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 2), (timer) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  Future checkEmailVerified() async {
    await firebaseAuth.currentUser!.reload();
    setState(() {
      isEmailVerified = firebaseAuth.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const Homepage()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verifying...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        authController.sendVerificationEmail();
                      },
                      child: Text("Resend Verification Mail")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "loginPage", (route) => false);
                      },
                      child: Text("Use different email"))
                ],
              ),
            ),
          );
  }
}
