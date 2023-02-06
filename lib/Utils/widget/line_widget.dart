

import 'package:flutter/material.dart';



class Gray_Line extends StatefulWidget {

  Size size;
  Gray_Line({required this.size});

  @override
  State<Gray_Line> createState() => _Gray_LineState();
}

class _Gray_LineState extends State<Gray_Line> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 1,
      height: widget.size.height * 0.001,
      decoration: BoxDecoration(color: Colors.grey),
    );
  }
}