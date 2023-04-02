import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/gym/gymDto.dart';
import 'package:ohmmanager/Model/statistics/statisticsDto.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:ohmmanager/View/home/popup/reset_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Utils/sundry/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../widget/chart_bottom.dart';

class GymStatistics_View extends StatefulWidget {
  StatisticsDto time_avg;
  GymDto? gymDto;
  String? current_count;
  String current_datetime;

  GymStatistics_View(
      {
        required this.gymDto,
        required this.time_avg,
      required this.current_datetime,
      required this.current_count});

  @override
  _GymStatistics_View createState() => _GymStatistics_View();
}

class _GymStatistics_View extends State<GymStatistics_View> {
  AnimateIconController controller = AnimateIconController();
  String? current_count;


  refresh() async {
    final prefs = await SharedPreferences.getInstance();
    var gymId = prefs.getString("gymId");
    String? r = await GymApi().current_count(gymId.toString());
    setState(() {
      widget.current_count = r;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    current_count = widget.current_count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = [
      widget.time_avg.one.toDouble(),
      widget.time_avg.two.toDouble(),
      widget.time_avg.three.toDouble(),
      widget.time_avg.four.toDouble(),
      widget.time_avg.five.toDouble(),
      widget.time_avg.six.toDouble(),
      widget.time_avg.seven.toDouble(),
      widget.time_avg.eight.toDouble(),
      widget.time_avg.nine.toDouble(),
      widget.time_avg.ten.toDouble(),
      widget.time_avg.eleven.toDouble(),
      widget.time_avg.twelve.toDouble(),
      widget.time_avg.thirteen.toDouble(),
      widget.time_avg.fourteen.toDouble(),
      widget.time_avg.fifteen.toDouble(),
      widget.time_avg.sixteen.toDouble(),
      widget.time_avg.seventeen.toDouble(),
      widget.time_avg.eighteen.toDouble(),
      widget.time_avg.nineteen.toDouble(),
      widget.time_avg.twenty.toDouble(),
      widget.time_avg.twentyOne.toDouble(),
      widget.time_avg.twentyTwo.toDouble(),
      widget.time_avg.twentyThree.toDouble(),
      widget.time_avg.zero.toDouble(),
    ];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
              width: 360.w,
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: kBottomColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 360.w,
                      height: 80.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [



                          Container(
                            margin: EdgeInsets.only(top: 15.h,right: 15.w),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(

                                    child: Text(
                                      "현재 약",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "lightfont",
                                          color: kTextWhiteColor),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15.h),
                                    child: Text(
                                      "${widget.current_count}",
                                      style: TextStyle(
                                          fontSize: 33.sp,
                                          fontFamily: "boldfont2",
                                          color: kTextWhiteColor),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 15.h,bottom: 5.h,top: 5.h),
                                      child: Text(
                                        "명",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "lightfont",
                                            color: kTextWhiteColor),
                                      ),
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                    ),
                  ])),
          // Container(
          //     margin: EdgeInsets.only(left: 13.w, top: 15.h),
          //     child: Text(
          //       "${widget.gymDto?.name}",
          //       style: TextStyle(fontSize: 17.sp, fontFamily: "boldfont"),
          //     )),
          Container(
              margin: EdgeInsets.only(left: 13.w, top: 15.h),
              child: Text(
                "시간별 평균 인원 ",
                style: TextStyle(fontSize: 17.sp, fontFamily: "boldfont"),
              )),
          Container(
            width: 360.w,
            margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 15.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey, width: 0.5)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5.w, bottom: 7.h),
                  width: 45.w,
                  height: 160.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${data.reduce(max).ceil()} 명",style: TextStyle(fontSize: 13.sp)),
                      Text("${((data.reduce(max) + data.reduce(min)) / 2).ceil()} 명",style: TextStyle(fontSize: 13.sp)),
                      Text("${data.reduce(min).ceil()} 명",style: TextStyle(fontSize: 13.sp),),
                    ],
                  ),
                ),
                Container(
                  width: 265.w,
                  margin: EdgeInsets.only(left: 10.w, right: 0.w, bottom: 20.h),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.w, right: 10.w, bottom: 20.h),
                                child: Sparkline(
                                  enableGridLines: true,
                                  max: data.reduce(max)+12,
                                  pointsMode: PointsMode.all,
                                  pointSize: 8.0,
                                  fallbackHeight: 200.h,
                                  pointColor: kPrimaryColor,
                                  lineWidth: 2.0,
                                  fallbackWidth: 700.w,
                                  sharpCorners: true,
                                  data: data,
                                ),
                              ),
                              Positioned(
                                  left: 686.w,
                                  child: Container(
                                    width: 40.w,
                                    height: 300.h,
                                    color: kBackgroundColor,
                                  ))
                            ],
                          ),
                          Chart_Bottom()
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            child: Container(
              width: 340.w,
              height: 50.h,
              decoration: BoxDecoration(
                  color: kTextBlackColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(left: 10.w),
              child: AnimateIcons(
                startIcon: Icons.refresh,
                endIcon: Icons.refresh,

                controller: controller,

                startTooltip: 'Icons.refresh',
                // add this tooltip for the end icon
                endTooltip: 'Icons.add_circle_outline',
                size: 36.0,
                onStartIconPress: () {
                  refresh();
                  return true;
                },
                onEndIconPress: () {
                  refresh();
                  return true;
                },

                duration: Duration(milliseconds: 500),
                startIconColor: kPrimaryColor,
                endIconColor: kPrimaryColor,
                clockwise: false,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          InkWell(
            onTap: () async {
              Reset_Popup().showDialog(context);
            },
            child: Center(
              child: Container(
                width: 340.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: kTextBlackColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Icon(
                  Icons.power_settings_new,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
