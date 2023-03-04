

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/trainerDto.dart';

import '../../../Utils/constants.dart';

class Trainer_Detail extends StatefulWidget {

  TrainerDto trainerDto;
  Trainer_Detail({required this.trainerDto});

  @override
  _Trainer_Detail createState() => _Trainer_Detail();
}

class _Trainer_Detail extends State<Trainer_Detail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade200,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              widget.trainerDto.profile == null?
          Container(
            height: 290.h,
            width: 360.w,
            child:ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: Image.asset(
                  "assets/images/user.jpg",
                  fit: BoxFit.cover,
                )
            ),
          )
                  :Container(
                height: 370.h,
                width: 360.w,
                child:ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      awsimg_endpoint+widget.trainerDto.profile!,
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                width: 360.w,


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20,top: 10)
                        ,
                        child: Text("${widget.trainerDto.nickname} ${widget.trainerDto.position}",style: TextStyle(fontSize: 22.sp,fontFamily: "boldfont"),)),

                    Container(
                      margin: EdgeInsets.only(left: 20,top: 20,right: 20)
                      ,
                      child: Text("${widget.trainerDto.introduce}",style: TextStyle(fontSize: 18.sp,fontFamily: "lightfont",fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
            ],
          ),
        )


    );
  }
}