import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/loading_screen.dart';
import 'package:follow_dp/views/widgets/textInputField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Enter your Email to Reset Password"),
                    const SizedBox(height: 20),
                    TextInputField(
                      controller: _emailController,
                      labelText: "Email",
                      icon: Icons.email,
                      signup: false,
                      isObscure: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_emailController.text != "") {
                            setState(() {
                              isLoading = true;
                            });
                            var res = await authController
                                .resetPassword(_emailController.text);
                            if (res) {
                              Navigator.pushNamed(context, "loginPage");
                            }
                            setState(() {
                              isLoading = false;
                            });
                            // print("object");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please enter a the email");
                          }
                        },
                        // style: ElevatedButton.styleFrom(),
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
