// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:follow_dp/controller/auth_controller.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

import '../../../constants/constants.dart';
import '../../widgets/textInputField.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  // static AuthController instance = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            // color: Colors.white,
            image:
                DecorationImage(image: AssetImage(login), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                // height: MediaQuery.of(context).size.width,
                // width: MediaQuery.of(context).size.width,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(logincrop), fit: BoxFit.cover)),
                padding: const EdgeInsets.only(left: 35, top: 130),
                child: const Text(
                  "Create\nAccount",
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      right: 35,
                      left: 35),
                  child: Column(children: [
                    TextInputField(
                      controller: _userNameController,
                      labelText: "Name",
                      icon: Icons.person,
                      isObscure: false,
                      signup: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextInputField(
                      controller: _emailController,
                      labelText: "Email",
                      icon: Icons.email,
                      isObscure: false,
                      signup: true,
                    ),
                    const SizedBox(height: 30),
                    TextInputField(
                      controller: _passwordController,
                      labelText: "Password",
                      icon: Icons.lock,
                      isObscure: true,
                      signup: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sign Up",
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
                                  context, 'loginPage', (route) => false);
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b)),
                            )),
                      ],
                    )
                  ]),
                ),
              )
            ],
          ),
        ));

    /*Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Image(image: AssetImage("assets/images/logo.png")),
              const Text(
                "Follow DP",
                style: TextStyle(
                    fontSize: 35,
                    color: primaryColor,
                    fontWeight: FontWeight.w900),
              ),

              const Text(
                "Register",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              // Stack(
              //   children: [
              //     const CircleAvatar(
              //       radius: 64,
              //       backgroundImage: AssetImage(avatar),
              //       // NetworkImage(
              //       //     "https://www.pngkit.com/png/detail/301-3012694_account-user-profile-avatar-comments-fa-user-circle.png"),
              //       backgroundColor: Colors.black,
              //     ),
              //     Positioned(
              //       bottom: -10,
              //       left: 80,
              //       child: IconButton(
              //         onPressed: () {
              //           authController.pickImage();
              //         },
              //         icon: const Icon(
              //           Icons.add_a_photo,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _userNameController,
                  labelText: "Name",
                  icon: Icons.person,
                ),
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
                  controller: _genderController,
                  labelText: "Gender",
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _phoneNumberController,
                  labelText: "Mobile Number",
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _dobController,
                  labelText: "DOB",
                  icon: Icons.person,
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
                    bool signup = await authController.registerUser(
                        _userNameController.text,
                        _emailController.text,
                        _passwordController.text,
                        // authController.profilePhoto,
                        _phoneNumberController.text,
                        _genderController.text,
                        _dobController.text);
                    if (signup) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, "emailVerification", (route) => false);
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("Navigating User");
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'loginPage',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    ));*/
  }
}
