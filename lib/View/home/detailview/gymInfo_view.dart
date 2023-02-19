

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/gymDto.dart';

import '../../../Utils/constants.dart';
import '../widget/gymInfo_widget.dart';

class GymInfo_View extends StatefulWidget {
  GymDto? gymDto;

  GymInfo_View({required this.gymDto});

  @override
  _GymInfo_ViewState createState() => _GymInfo_ViewState();
}

class _GymInfo_ViewState extends State<GymInfo_View> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 360.w,
            height: 120.h,
            decoration: BoxDecoration(
                color: kBottomColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 10,right: 20),
                      child: Icon(Icons.fitness_center,color: Colors.white,size: 55,),
                    ),
                    Container(
                      width: 230.w,
                        margin: EdgeInsets.only(
                            left: 10, top: 30,right: 20),
                        child: Text(
                          "${widget.gymDto?.name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextWhiteColor,
                              fontSize: 28),
                        )),
                  ],
                ),
              ],
            ),
          ),
          GymInfo_Widget("주소", "${widget.gymDto?.address}"),
          GymInfo_Widget("한줄소개", "${widget.gymDto?.oneline_introduce}"),
          GymInfo_Widget("헬스장 소개", "${widget.gymDto?.introduce}"),

          Container(
            width: 320.w,

            margin: EdgeInsets.only(top: 30),
            height: 100.h,

            decoration: BoxDecoration(
                color: kBoxColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 22.w,right: 20,top: 30.h),
                        child: Text("현재 헬스장 인원수를 알려주는",style: TextStyle(fontSize: 18,color: kPrimaryColor,fontWeight: FontWeight.bold),)),
                    Container(
                        margin: EdgeInsets.only(left: 22.w,right: 20),
                        child: Text("오헬몇",style: TextStyle(fontSize: 25,color: kPrimaryColor,fontWeight: FontWeight.bold),)),
                  ],
                ),

                Icon(Icons.emergency_share,color: kPrimaryColor,size: 50,)
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
