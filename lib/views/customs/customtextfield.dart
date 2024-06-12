import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final IconButton? suffixicon;
  final Icon? prefixicon;
  final bool hideText;
  final bool isPassword;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.controller,
      this.hideText = false,
      this.hint,
      this.isPassword = false,
      this.prefixicon,
      this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: hideText,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              borderSide: BorderSide(color: whitecolor, width: 2),
            ),
            hintText: hint,
            // hintStyle: TextStyle(color: hintcolor),
            prefixIcon: prefixicon,
            suffixIcon: suffixicon,
            fillColor: whitecolor));
  }
}
