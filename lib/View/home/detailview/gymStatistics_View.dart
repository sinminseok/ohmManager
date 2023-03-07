import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/statisticsDto.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/home/popup/reset_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../detailview/chart_view.dart';
import '../../../Utils/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class GymStatistics_View extends StatefulWidget {
  StatisticsDto time_avg;

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
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: 360.w,
              height: 120.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), color: kBottomColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 360.w,
                      height: 120.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 0.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
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
                              InkWell(
                                onTap: () async {
                                  Reset_Popup().showDialog(context);

                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: 15.w, bottom: 10),
                                    child: Icon(
                                      Icons.power_settings_new,
                                      size: 30,
                                      color: Colors.red,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 75.h),
                                  child: Text(
                                    "현재 약",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "lightfont",
                                        color: kTextWhiteColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 23.h),
                                  child: Text(
                                    "${widget.current_count}",
                                    style: TextStyle(
                                        fontSize: 32.sp,
                                        fontFamily: "boldfont",
                                        color: kTextWhiteColor),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 30.h),
                                  child: Text(
                                    "명",
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontFamily: "boldfont",
                                        color: kTextWhiteColor),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ])),
          Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 15.h),
              width: 360.w,
              height: 370.h,
              child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Dashboard(
                    time_avg: widget.time_avg,
                  ))),
        ],
      ),
    );
  }
}
