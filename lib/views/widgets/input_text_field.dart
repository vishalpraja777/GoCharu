import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key, this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            hintText: 'Email',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))));
  }
}
