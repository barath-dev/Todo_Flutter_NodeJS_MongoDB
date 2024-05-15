// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPass;
  final double h_padding;
  final double v_padding;
  const TextInput(
      {super.key,
      required this.controller,
      required this.label,
      this.isPass = false,
      this.h_padding = 0.15,
      this.v_padding = 0.02});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * h_padding,
          vertical: MediaQuery.of(context).size.height * v_padding),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: label,
        ),
        obscureText: isPass,
        controller: controller,
      ),
    );
  }
}
