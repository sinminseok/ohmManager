import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../sundry/constants.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.title
  }) : super(key: key);

  final String title;
  final String hint;
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
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: kTextBlackColor,fontFamily: "lightfont"),),
          Container(
            decoration: BoxDecoration(

                color: kContainerColor,
                borderRadius: BorderRadius.circular(10)
            ),
            width: 200.w,
            child: TextFormField(
              obscureText: true,
              controller: controller,
              textAlign: TextAlign.center,
              cursorColor: kContainerColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
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
// controller: controller,
// cursorColor: kPrimaryColor,
// obscureText: true,
// decoration: InputDecoration(
// icon: Icon(Icons.lock, color: kPrimaryColor),
// hintText: hint,
// border: InputBorder.none
// ),
// ));