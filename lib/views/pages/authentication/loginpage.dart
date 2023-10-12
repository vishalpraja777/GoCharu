import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';
import 'package:follow_dp/views/pages/loading_screen.dart';
import 'package:follow_dp/views/widgets/textInputField.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  bool isLoadingButton = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : Container(
            decoration: const BoxDecoration(color: primaryColor),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [_buildTop(), _buildBottom()],
                )
                // Stack(
                //   children: [
                //     Positioned(top: 80, child: _buildTop()),
                //     Align(
                //       alignment: Alignment.bottomCenter,
                //       child: SingleChildScrollView(child: _buildBottom()),
                //     ),
                //   ],
                // ),
                ),
          );
  }

  Widget _buildTop() {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 50, bottom: 20),
      child: Column(
        children: [
          Image(
            image: const AssetImage(applogo),
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          const SizedBox(height: 20),
          const Text(
            "Go Charu",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            _buildGreyText("Please login with your credentials"),
            const SizedBox(
              height: 40,
            ),
            // Email input
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
            // Password Input
            TextInputField(
              controller: _passwordController,
              labelText: "Password",
              icon: Icons.lock,
              signup: false,
              isObscure: true,
            ),
            const SizedBox(
              height: 10,
            ),
            // Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "forgotPasswordScreen");
                    },
                    child: _buildGreyText("Forgot Password?")),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            // Login Button
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoadingButton = true;
                    });
                    bool login = await authController.loginUser(
                        _emailController.text, _passwordController.text);
                    if (login) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, "emailVerification", (route) => false);
                    }
                    setState(() {
                      isLoadingButton = false;
                    });
                  },
                  // style: ElevatedButton.styleFrom(),
                  child: isLoadingButton
                      ? LoadingAnimationWidget.horizontalRotatingDots(
                          color: Colors.white, size: 30)
                      : const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildGreyText("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    print("Navigating User");
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'signuppage', (route) => false);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            Center(child: _buildGreyText("Or Login with")),
            const SizedBox(height: 10),
            Center(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var res = await authController.googleSignIn();
                    if (res != null) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, "homepage", (route) => false);
                      // print("res: " + res.toString());
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  icon: Image.asset(googlelogo)),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }
  /* Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // image: DecorationImage(image: AssetImage(login), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(logincrop), fit: BoxFit.cover)),
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                "Welcome\nBack",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(children: [
                  TextInputField(
                    controller: _emailController,
                    labelText: "Email",
                    icon: Icons.email,
                    isObscure: false,
                    signup: false,
                  ),
                  const SizedBox(height: 30),
                  TextInputField(
                    controller: _passwordController,
                    labelText: "Password",
                    icon: Icons.lock,
                    isObscure: true,
                    signup: false,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Color(0xff4c505b),
                            fontSize: 27,
                            fontWeight: FontWeight.w700),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'signuppage', (route) => false);
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)),
                          ))
                    ],
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
    */

  /*   body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Image(image: AssetImage("assets/images/logo.png")),
            Text(
              "Follow DP",
              style: TextStyle(
                  fontSize: 35,
                  color: primaryColor,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                labelText: "Email",
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: "Password",
                icon: Icons.lock,
                isObscure: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () async {
                  // print("Login User");
                  bool login = await authController.loginUser(
                      _emailController.text, _passwordController.text);
                  if (login) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, "emailVerification", (route) => false);
                  }
                },
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("Navigating User");
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'signuppage', (route) => false);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 20, color: primaryColor),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    )*/
}
