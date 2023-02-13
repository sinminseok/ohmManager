import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import 'input_widget.dart';


class RoundedInput extends StatelessWidget {
  const RoundedInput({
    Key? key,
    required this.title,
    required this.controller,

  }) : super(key: key);

  final String title;


  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      height: 40.h,
      margin: EdgeInsets.only(top: 20),


      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
          Container(
            decoration: BoxDecoration(
                color: kContainerColor,
                borderRadius: BorderRadius.circular(10)
            ),
            width: 200.w,
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              cursorColor: kContainerColor,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.,
                hintText: "-",
                  border: InputBorder.none
              ),
            ),
          )

        ],
      ),
    );
  }
}

// InputContainer(
// child: TextFormField(


// ));