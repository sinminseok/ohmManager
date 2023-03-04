import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Model/postDto.dart';
import '../detailview/post_detail.dart';



Widget Post_Widget(Size size,context,PostDto postDto) {

  return InkWell(
    onTap: ()async{
      // print(postDto.imgs[0].filePath);

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Post_Detail(postDto:postDto)));

    },
    child:Padding(
      padding: const EdgeInsets.only(bottom: 10.0,top: 10),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [

            ],
            color: kContainerColor,
            borderRadius: BorderRadius.all(Radius.circular(1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            postDto.imgs.length == 0?Container():Container(
              height: 340.h,
              width: 360.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1.0),
                  child: Image.network(

                    awsimg_endpoint+postDto.imgs[0].filePath,
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              width: 350.w,
              margin: EdgeInsets.only(left: 20.w,top: 20.h,right: 20.w),
              child: Text("${postDto.title}",style: TextStyle(fontFamily: "boldfont",fontSize: 21),),
            ),
            Container(
              width: 350.w,
              height: 20.h,
              margin: EdgeInsets.only(left: 20.w,top: 10.h,right: 20.w,bottom: 30.h),
              child: Text("더보기", overflow: TextOverflow.clip,style: TextStyle(fontFamily: "lightfont",fontSize: 21),),
            ),
          ],
        ),
      ),
    ),

  );
}

Widget Gym_Trainer_Item(Size size,context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: size.height * 0.2,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          //  assets/images/img1.jpeg

          Container(
            width: size.width*0.4,
            child: ClipRRect(

                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset("assets/images/teacher.jpeg",fit: BoxFit.cover,)),
          ),
          Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("신민석 선생님",style: TextStyle(fontSize: 18,fontFamily: "boldfont"),),
              ),
              Text("비나이더 안산점",style: TextStyle(color: Colors.grey,fontFamily: "boldfont"),),
              SizedBox(height: size.height*0.06,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("근세포 하나하나 자극을",style: TextStyle(fontFamily: "boldfont"),),
              )
            ],
          )
        ],
      ),
    ),
  );
}