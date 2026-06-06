import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureField;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureField,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),

      validator: (value) {
        if (value!.trim().isEmpty) {
          return "${hintText} is missing";
        }
        return null;
      },
    );
  }
}
