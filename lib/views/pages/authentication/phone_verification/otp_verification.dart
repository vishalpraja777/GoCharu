import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/authentication/phone_verification/phone_number_page.dart';
// import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var smsCode = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).shadowColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Theme.of(context).indicatorColor,
        ),
      ),
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
                    "Enter the OTP received on your phone number",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Pinput(
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    onChanged: (value) async {
                      smsCode = value.toString();
                    },
                    // validator: (s) {
                    //   return s == '2222' ? null : 'Pin is incorrect';
                    // },
                    // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    // showCursor: true,
                    // onCompleted: (pin) => print(pin),
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
                          try {
                            // Create a PhoneAuthCredential with the code
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: PhoneNumberPage.verify,
                                    smsCode: smsCode);
                            // Sign the user in (or link) with the credential
                            await auth.signInWithCredential(credential);

                            // ignore: use_build_context_synchronously
                            Navigator.pushNamedAndRemoveUntil(
                                context, "homepage", (route) => false);
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(msg: "Wrong OTP");
                          }
                        },
                        child: loading
                            ? Text(
                                'loading',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : Text(
                                'Verify Phone Number',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamedAndRemoveUntil(
                          //     context, 'phone', (route) => false);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Edit Phone Number?",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
