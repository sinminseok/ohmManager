import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.id_controller,
    required this.pw_controller,
    required this.check_pw_controller,
    required this.title,
  }) : super(key: key);

  final String title;
  final TextEditingController id_controller;
  final TextEditingController pw_controller;
  final TextEditingController? check_pw_controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
      ),

      padding: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 18
        ),
      ),
    );
  }
}