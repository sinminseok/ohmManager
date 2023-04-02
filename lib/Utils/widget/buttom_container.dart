

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sundry/constants.dart';

Widget Button(String title){
  return Container(
    width: 330.w,
    height: 47.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: kButtonColor,
    ),


    alignment: Alignment.center,
    child: Text(
      "$title",
      style: TextStyle(
        fontFamily: "lightfont",
          color: kTextWhiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp
      ),
    ),
  );
}