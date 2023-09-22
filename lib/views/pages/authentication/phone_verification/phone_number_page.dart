// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_dp/constants/constants.dart';
// import 'package:follow_dp/views/pages/authentication/otp_verification.dart';
// import 'package:get/get_utils/get_utils.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  static String verify = '';

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  TextEditingController countryCode = TextEditingController();
  var phoneNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode.text = "+91";
  }

  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage(phoneLogo),
                    width: 150,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Phone Verification",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your mobile number for verification",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 45,
                            child: TextField(
                              controller: countryCode,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: "+91"),
                            )),
                        Text(
                          '|',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Phone"),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          // print(countryCode.text + phoneNumber);
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: countryCode.text + phoneNumber,
                            timeout: const Duration(seconds: 60),
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              setState(() {
                                loading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "Invalid Phone Number");
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              PhoneNumberPage.verify = verificationId;
                              Navigator.pushNamed(context, "otp");
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {
                              Fluttertoast.showToast(msg: "Timeout for OTP");
                            },
                          );
                        },
                        child: loading
                            ? Text(
                                'Loading',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(
                                'Send a code',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
