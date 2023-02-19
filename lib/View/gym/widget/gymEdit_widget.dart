

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Utils/constants.dart';

Widget GymEdit_Widget(String? title,String? content,TextEditingController _controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.only(left: 20,bottom: 15,top: 20),
          child: Text(
            "$title",
            style: TextStyle(
                fontSize: 19, color: kPrimaryColor,fontWeight: FontWeight.bold),
          )),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20),

        decoration: BoxDecoration(
            color: kContainerColor,
            borderRadius:
            BorderRadius.all(Radius.circular(10))),
        child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20,left: 20,right: 20),
            child: Center(
              child:TextField(
                decoration: InputDecoration(
                  focusColor: kPrimaryColor,
                  hoverColor: kPrimaryColor,
                  border: InputBorder.none,
                ),
                controller: _controller,)
            )),
      ),
    ],
  );
}