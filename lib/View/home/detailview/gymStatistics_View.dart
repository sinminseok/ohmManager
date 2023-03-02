import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/countDto.dart';
import 'package:ohmmanager/View/home/detailview/chart_view.dart';
import 'package:ohmmanager/View/home/detailview/test_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/date.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GymStatistics_View extends StatefulWidget {
  List<double> time_avg;
  String? current_count;
  String current_datetime;

  GymStatistics_View(
      {required this.time_avg,
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
    // double max_value(List<double> data) {
    //   var v = [...data];
    //   v.sort();
    //   double max = v.last;
    //   return max;
    // }

    return SingleChildScrollView(
      child: Column(

        children: [
          Container(
              width: 360.w,
              height: 120.h,

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 360.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: kBottomColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(0.0),
                            bottomLeft: Radius.circular(0.0)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child: Text(
                              "${widget.current_datetime}",
                              style:
                                  TextStyle(fontSize: 18, color: kTextWhiteColor),
                            ),
                          ),
                          Row(children: [
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(left: 60.w),
                                child: AnimateIcons(
                                  startIcon: Icons.refresh,
                                  endIcon: Icons.refresh,

                                  controller: controller,

                                  startTooltip: 'Icons.refresh',
                                  // add this tooltip for the end icon
                                  endTooltip: 'Icons.add_circle_outline',
                                  size: 50.0,
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
                            Container(
                                margin: EdgeInsets.only(left: 35.h),
                                child: Text(
                                  "${widget.current_count}",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontFamily: "boldfont",
                                      color: kTextWhiteColor),
                                ),),
                            Container(
                              margin: EdgeInsets.only(left: 38.h),
                              child: Text("명",style: TextStyle(
                                  fontSize: 29,
                                  fontFamily: "boldfont",
                                  color: kTextWhiteColor),),
                            )

                          ])
                        ],
                      ),
                    ),
                  ])),
          Container(
              width: 360.w,
              height:350.h,
              child: Dashboard(time_avg: widget.time_avg,))
        ],
      ),
    );
  }
}
