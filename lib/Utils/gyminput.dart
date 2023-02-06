import 'package:flutter/material.dart';
import 'package:ohmmanager/Utils/widget/input_widget.dart';

import 'constants.dart';

class GymInput extends StatelessWidget {
  const GymInput({Key? key, required this.controller, required this.hint})
      : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        child: TextFormField(
      controller: controller,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(hintText: hint, border: InputBorder.none),
    ));
  }
}
