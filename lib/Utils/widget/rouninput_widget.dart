import 'package:flutter/material.dart';

import '../constants.dart';
import 'input_widget.dart';


class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hint
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextFormField(
          controller: controller,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
              icon: Icon(icon, color: kPrimaryColor),
              hintText: hint,
              border: InputBorder.none
          ),
        ));
  }
}