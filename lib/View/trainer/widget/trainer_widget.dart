

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/View/trainer/detailview/trainer_detail.dart';
import 'package:page_transition/page_transition.dart';

Widget Trainer_Widget(Size size,context,TrainerDto trainerDto) {
  return InkWell(

    onTap: (){
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Trainer_Detail(trainerDto: trainerDto,)));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
            color: kContainerColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            //  assets/images/img1.jpeg

            Container(
              width: 120.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Image.asset(
                    "assets/images/teacher.jpeg",
                    fit: BoxFit.cover,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 20.h),
                  child: Text(
                    "${trainerDto.nickname} ${trainerDto.position}",
                    style: TextStyle(fontSize: 18, fontFamily: "boldfont"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, top: 10.h),
                  width: 210.w,
                  child: Text(
                    "${trainerDto.oneline_introduce}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(fontFamily: "boldfont", color: Colors.grey),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}