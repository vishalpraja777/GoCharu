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

      timer = Timer.periodic(const Duration(seconds: 2), (timer) {
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
                  const Text(
                    "A verification link",
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "has been sent to your mail",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Check and verify your Email:",
                  ),
                  const SizedBox(height: 10),
                  Text(firebaseAuth.currentUser!.email!),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                        onPressed: () {
                          authController.sendVerificationEmail();
                        },
                        child: const Text("Resend Verification Mail")),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "loginPage", (route) => false);
                        },
                        child: const Text("Use different email")),
                  )
                ],
              ),
            ),
          );
  }
}
