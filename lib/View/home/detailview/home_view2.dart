

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/constants.dart';
import '../../../Utils/date.dart';
import '../widget/bar_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Home_View2 extends StatefulWidget {
  Home_View2({required this.current_datetime});
  String current_datetime;

  @override
  _Home_View2State createState() => _Home_View2State();
}

class _Home_View2State extends State<Home_View2> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 360.w,
            height: 120 .h,
            decoration: BoxDecoration(
                color: kBottomColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 360.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: kBottomColor,
                    borderRadius: BorderRadius.only(

                        bottomRight: Radius.circular(10.0),

                        bottomLeft: Radius.circular(10.0)),
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

              ],
            ),
          ),
          Container(
            margin:  EdgeInsets.only(top: 30.h),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 350.w,
                    height: 200.h,
                    decoration: BoxDecoration(

                        color: Colors.grey.shade200,
                        //kBackgroundColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 200.0,bottom: 10),
                          child: Text(
                            "평균 시간별 분표도",
                            style: TextStyle(
                                fontFamily: "boldfont", fontSize: 16),
                          ),
                        ),
                        Center(
                          child: Container(

                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey.shade300)
                            ),
                            height: size.height * 0.2,
                            child: Container(
                              margin:EdgeInsets.all(8.0),
                              child: charts.BarChart(
                                Bar_Widget.time_data(),
                                animate: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


          Container(
            margin:  EdgeInsets.only(top: 10.h),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 350.w,
                    height: 200.h,
                    decoration: BoxDecoration(

                        color: Colors.grey.shade200,
                        //kBackgroundColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 200.0,bottom: 10),
                          child: Text(
                            "평균 시간별 분표도",
                            style: TextStyle(
                                fontFamily: "boldfont", fontSize: 16),
                          ),
                        ),
                        Center(
                          child: Container(

                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey.shade300)
                            ),
                            height: size.height * 0.2,
                            child: Container(
                              margin:EdgeInsets.all(8.0),
                              child: charts.BarChart(
                                Bar_Widget.time_data(),
                                animate: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),



        ],
      ),
    );
  }
}
