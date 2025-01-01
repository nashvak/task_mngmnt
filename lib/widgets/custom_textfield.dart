import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final String text;
  const CustomTextfield(
      {super.key,
      required this.text,
      required this.controller,
      required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Null value";
          }
          return null;
        },
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: text),
      ),
    );
  }
}
