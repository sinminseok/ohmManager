

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/home/detailview/chart_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/date.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GymStatistics_View extends StatefulWidget {
  List<double> time_avg;
  String current_datetime;
  GymStatistics_View({required this.time_avg,required this.current_datetime});


  @override
  _GymStatistics_View createState() => _GymStatistics_View();
}

class _GymStatistics_View extends State<GymStatistics_View> {
  AnimateIconController controller = AnimateIconController();
  var current_count;


  refresh() async {
    // final prefs = await SharedPreferences.getInstance();
    // var gymId = prefs.getInt("gymId");
    // var r = await GymApi().curr(gymId.toString());
    // setState(() {
    //   widget.current_count = r;
    // });
  }

  @override
  Widget build(BuildContext context) {



    double  max_value(List<double> data){
      var v = [...data];
      v.sort();
      double max = v.last ;
      return max;

    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 360.w,
            height: 120 .h,
            decoration: BoxDecoration(
                color: kBottomColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0))),
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
                      Text(
                        "${widget.current_datetime}",
                        style: TextStyle(fontSize: 18,color: kTextWhiteColor),
                      ),

                      Container(
                        margin: EdgeInsets.all(15),
                        child: Text(
                          "14명",
                          style: TextStyle(fontSize: 50, fontFamily: "boldfont",color: kTextWhiteColor),
                        ),
                      ),

                    ],
                  ),
                ),

              ]
            )
          ),
          Stack(children: [
            Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 350.w,
                      height: 300.h,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          //kBackgroundColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Container(child: LineChartSample1(time_data: widget.time_avg, max_value: max_value(widget.time_avg),))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
          ),



        ],
      ),
    );
  }
}
