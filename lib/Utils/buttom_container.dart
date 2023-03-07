

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

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

// InkWell(
// onTap: () async {
//
//
// },
// borderRadius: BorderRadius.circular(10),
// child: RoundedLoadingButton(
// controller: _btnController,
// successColor: kTextBlackColor,
// color: kTextBlackColor,
// onPressed: _doSomething,
// child: Container(
// width: 330.w,
// height: 47.h,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: kButtonColor,
// ),
//
//
// alignment: Alignment.center,
// child: Text(
// "다음",
// style: TextStyle(
// fontFamily: "lightfont",
// color: kTextWhiteColor,
// fontWeight: FontWeight.bold,
// fontSize: 16.sp
// ),
// ),
// ),
// )
// ),