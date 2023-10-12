import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  TextEditingController controller;
  TextInputType type;
  bool obscureText;
  String labelText;
  IconData icon;
  final ValueChanged<String> setIsVisible;

  // ignore: use_key_in_widget_constructors
  Field(
      {required this.setIsVisible,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.obscureText = false,
      this.type = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        onChanged: setIsVisible,
        keyboardType: type,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.green,
            ),
            labelText: labelText),
      ),
    );
  }
}
