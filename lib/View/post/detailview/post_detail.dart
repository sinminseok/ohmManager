

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Model/postDto.dart';
import '../../../Utils/constants.dart';


class Post_Detail extends StatefulWidget {


  PostDto postDto;

  Post_Detail({required this.postDto});

  @override
  _Post_Detail createState() => _Post_Detail();
}

class _Post_Detail extends State<Post_Detail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240.h,
              width: 360.w,
              child:ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    "assets/images/gym_img.png",
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              width: size.width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                      child: Text("${widget.postDto.title}",style: TextStyle(fontSize: 30),)),
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 50),
                      child: Text("${widget.postDto.content}",style: TextStyle(fontSize: 30),)),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}