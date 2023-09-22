import 'package:flutter/material.dart';
import 'package:follow_dp/constants/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  final bool signup;

  const TextInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isObscure = false,
      required this.icon,
      required this.signup});

  @override
  Widget build(BuildContext context) {
    return signup
        ? TextField(
            controller: controller,
            decoration: InputDecoration(
                // fillColor: Colors.grey.shade100,
                filled: true,
                hintText: labelText,
                // labelText: labelText,
                prefixIcon: Icon(icon),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18))),
            obscureText: isObscure,
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: labelText,
                // labelText: labelText,
                prefixIcon: Icon(icon),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18))),
            obscureText: isObscure,
          );
    //   InputDecoration(
    //       labelText: labelText,
    //       prefixIcon: Icon(icon),
    //       labelStyle: const TextStyle(fontSize: 20),
    //       enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: const BorderSide(
    //             color: borderColor,
    //           )),
    //       focusedBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(5),
    //           borderSide: const BorderSide(
    //             color: borderColor,
    //           ))),
    //   obscureText: isObscure,
    // );
  }
}
