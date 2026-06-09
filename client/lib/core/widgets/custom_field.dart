import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isObscureField;
  final bool readOnly;
  final VoidCallback? onTap;
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureField = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      obscureText: isObscureField,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      onTap: onTap,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "${hintText} is missing";
        }
        return null;
      },
    );
  }
}
