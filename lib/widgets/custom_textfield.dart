import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomeTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(0, 0, 0, 1),
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
