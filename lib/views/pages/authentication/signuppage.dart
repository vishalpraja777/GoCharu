// import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:follow_dp/controller/auth_controller.dart';
import 'package:follow_dp/views/pages/loading_screen.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:table_calendar/table_calendar.dart';
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

  String genderValue = "Male";
  List<String> genderList = <String>["Male", "Female", "Other"];

  DateTime dateTime = DateTime.now();
  String strDateTime = '--/--/----';

  bool isLoading = false;
  bool isLoadingButton = false;

  // static AuthController instance = Get.find();

  @override
  Widget build(BuildContext context) {
    // strDateTime = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

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
                //       child: _buildBottom(),
                //     ),
                //   ],
                // ),
                ),
          );
  }

  Widget _buildTop() {
    return Container(
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
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Create an Account",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            _buildGreyText("Please login with your credentials"),
            const SizedBox(
              height: 40,
            ),
            // Name Input
            TextInputField(
              controller: _userNameController,
              labelText: "Name",
              icon: Icons.person,
              signup: false,
              isObscure: false,
            ),
            const SizedBox(
              height: 20,
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
            // gender input
            _dropDownList(),
            const SizedBox(
              height: 20,
            ),
            // Phone Input
            TextInputField(
              controller: _phoneNumberController,
              labelText: "Phone Number",
              icon: Icons.phone,
              signup: false,
              numberic: true,
              isObscure: false,
            ),
            const SizedBox(height: 20),
            // DOB Input
            _datePicker(context),
            const SizedBox(height: 20),
            // DOB Input
            // TextInputField(
            //   controller: _dobController,
            //   labelText: "DOB",
            //   icon: Icons.cake,
            //   signup: false,
            //   isObscure: false,
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Password Input
            TextInputField(
              controller: _passwordController,
              labelText: "Password",
              icon: Icons.lock,
              signup: false,
              isObscure: true,
            ),
            const SizedBox(
              height: 20,
            ),
            // Forgot Password
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //         onPressed: () {}, child: _buildGreyText("Forgot Password")),
            //   ],
            // ),
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
                    _genderController.text = genderValue;
                    bool signup = await authController.registerUser(
                        _userNameController.text,
                        _emailController.text,
                        _passwordController.text,
                        // authController.profilePhoto,
                        _phoneNumberController.text,
                        _genderController.text,
                        _dobController.text);
                    setState(() {
                      isLoadingButton = false;
                    });
                    if (signup) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, "emailVerification", (route) => false);
                    }
                  },
                  // style: ElevatedButton.styleFrom(),
                  child: isLoadingButton
                      ? LoadingAnimationWidget.horizontalRotatingDots(
                          color: Colors.white, size: 30)
                      : const Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildGreyText("Already have an account?"),
                TextButton(
                  onPressed: () {
                    print("Navigating User");
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'loginPage', (route) => false);
                  },
                  child: const Text(
                    "Sign In",
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

  Widget _dropDownList() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16), // Remove internal padding
        border: OutlineInputBorder(
          // Customize the border
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      isExpanded: true,
      value: genderValue,
      items: genderList
          .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
          .toList(),
      onChanged: (String? value) {
        setState(() {
          genderValue = value!;
        });
      },
    );
  }

  Widget _datePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("DOB: $strDateTime"),
          SizedBox(
              child: ElevatedButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) => showCupertinoDatePicker(context));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: const Text("Choose DOB"))))
        ],
      ),
    );
  }

  showCupertinoDatePicker(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Colors.white),
      height: 250,
      child: CupertinoDatePicker(
        // backgroundColor: Colors.white,
        initialDateTime: dateTime,
        maximumDate: DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (DateTime newTime) {
          setState(() {
            dateTime = newTime;
            strDateTime = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
            _dobController.text = strDateTime;
          });
        },
      ),
    );
  }

  /* Container(
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
        ));*/

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
