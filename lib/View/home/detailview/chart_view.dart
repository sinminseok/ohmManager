import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/statisticsDto.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'dart:ui' as ui;
import '../../../Utils/charts/chart_labels.dart';
import '../../../Utils/charts/laughing_data.dart';
import '../../../Utils/charts/slide_selector.dart';

class Dashboard extends StatefulWidget {
  StatisticsDto time_avg;
  Dashboard({required this.time_avg});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  List<WeekData> hourData = [


  ];

  int activeWeek = 2;
  static const leftPadding = 10.0;
  static const rightPadding = 9.0;


  double chartHeight = 240;
  late List<ChartDataPoint> chartData;

  @override
  void initState() {

    hourData = [
      //오전
      WeekData(
        days: [

          DayData(
            hour: 1,
            laughs: widget.time_avg.one.toInt(),
          ),
          DayData(
            hour: 2,
            laughs: widget.time_avg.two.toInt()
          ),
          DayData(
            hour: 3,
            laughs: widget.time_avg.three.toInt(),
          ),
          DayData(
            hour: 4,
            laughs: widget.time_avg.four.toInt(),
          ),
          DayData(
            hour: 5,
            laughs: widget.time_avg.five.toInt(),
          ),
          DayData(
            hour: 6,
            laughs: widget.time_avg.six.toInt(),
          ),
          DayData(
            hour: 7,
            laughs: widget.time_avg.seven.toInt(),
          ),
          DayData(
            hour: 8,
            laughs: widget.time_avg.eight.toInt(),
          ),

          DayData(
            hour: 9,
            laughs: widget.time_avg.nine.toInt(),
          ),
          DayData(
            hour: 10,
            laughs: widget.time_avg.ten.toInt(),
          ),
          DayData(
            hour: 11,
            laughs: widget.time_avg.eleven.toInt(),
          ),
          DayData(
            hour: 12,
            laughs: widget.time_avg.twelve.toInt(),
          ),
          DayData(
            hour: 13,
            laughs: widget.time_avg.twelve.toInt(),
          ),


        ],
      ),


//오후
      WeekData(
        days: [
//12시
          DayData(
            hour: 0,
            laughs: widget.time_avg.thirteen.floor(),
          ),
          DayData(
            hour: 1,
            laughs: widget.time_avg.thirteen.floor(),
          ),
          DayData(
            hour: 2,
            laughs: widget.time_avg.fourteen.floor(),
          ),
          DayData(
            hour: 3,
            laughs: widget.time_avg.fifteen.floor(),
          ),
          DayData(
            hour: 4,
            laughs: widget.time_avg.sixteen.floor(),
          ),
          DayData(
            hour: 5,
            laughs: widget.time_avg.seventeen.floor(),
          ),
          DayData(
            hour: 6,
            laughs: widget.time_avg.eighteen.floor(),
          ),
          DayData(
            hour: 7,
            laughs: widget.time_avg.nineteen.floor(),
          ),
          DayData(
            hour: 8,
            laughs: widget.time_avg.twenty.floor(),
          ),
          DayData(
            hour: 9,
            laughs: widget.time_avg.twenty_one.floor(),
          ),
          DayData(
            hour: 10,
            laughs: widget.time_avg.twenty_two.floor(),
          ),
          DayData(
            hour: 11,
            laughs: widget.time_avg.twenty_three.floor(),
          ),
          DayData(
            hour: 12,
            laughs: widget.time_avg.twenty_four.floor(),
          ),
          DayData(
            hour: 13,
            laughs: widget.time_avg.twenty_four.floor(),
          ),

        ],
      ),

    ];
    super.initState();
    setState(() {
      chartData = normalizeData(hourData[activeWeek - 2]);
    });
  }

  List<ChartDataPoint> normalizeData(WeekData weekData) {
    final maxDay = weekData.days.reduce((DayData dayA, DayData dayB) {
      return dayA.laughs > dayB.laughs ? dayA : dayB;
    });
    final normalizedList = <ChartDataPoint>[];
    weekData.days.forEach((element) {
      normalizedList.add(ChartDataPoint(
          value: maxDay.laughs == 0 ? 0 : element.laughs / maxDay.laughs));
    });
    return normalizedList;
  }

  void changeWeek(int week) {
    setState(() {
      activeWeek = week;
      chartData = normalizeData(hourData[week - 1]);

    });
  }

  Path drawPath(bool closePath) {
    final width = 280.w;
    final height = chartHeight;
    final path = Path();
    final segmentWidth =
        (width - leftPadding - rightPadding) / ((chartData.length - 1) * 3);

    path.moveTo(0, height - chartData[0].value * height);
    path.lineTo(leftPadding, height - chartData[0].value * height);
// curved line
    for (var i = 1; i < chartData.length; i++) {
      path.cubicTo(
          (3 * (i - 1) + 1) * segmentWidth + leftPadding,
          height - chartData[i - 1].value * height,
          (3 * (i - 1) + 2) * segmentWidth + leftPadding,
          height - chartData[i].value * height,
          (3 * (i - 1) + 3) * segmentWidth + leftPadding,
          height - chartData[i].value * height);
    }
    path.lineTo(width, height - chartData[chartData.length - 1].value * height);
// for the gradient fill, we want to close the path
    if (closePath) {
      path.lineTo(width, height);
      path.lineTo(0, height);
    }

    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DashboardBackground(),
        Container(
          margin: EdgeInsets.only(left: 1.w,right: 1.w),
          width: 350.w,
          height: 350.h,
          child: SingleChildScrollView(
            child: Column(

              children: [


                Padding(
                  padding: const EdgeInsets.only(left: 90,right:90,top: 15,bottom: 20),
                  child: SlideSelector(
                    defaultSelectedIndex: activeWeek - 2,
                    items: <SlideSelectorItem>[
                      SlideSelectorItem(
                        text: '오전',

                        onTap: () {
                          changeWeek(1);
                        },
                      ),
                      SlideSelectorItem(
                        text: '오후',
                        onTap: () {
                          changeWeek(2);
                        },
                      ),

                    ],
                  ),
                ),

                Container(
                  height: chartHeight + 83,
                  color: kBackgroundColor,
                  child: Stack(
                    children: [
                      ChartLaughLabels(
                        chartHeight: chartHeight,
                        topPadding: 30.h,
                        leftPadding: leftPadding,
                        rightPadding: rightPadding,
                        weekData: hourData[activeWeek -1],
                      ),

                      const Positioned(
                        bottom:-12,
                        left: 0,
                        right: 0,
                        child: ChartDayLabels(
                          leftPadding: leftPadding,
                          rightPadding: rightPadding,
                        ),
                      ),
                      Positioned(
                        top: 33.h,
                        left: 55.w,

                        child: CustomPaint(
                            size: Size(
                                MediaQuery.of(context).size.width, chartHeight),
                            painter: PathPainter(
                              path: drawPath(false),
                              fillPath: drawPath(true),
                            )),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}

class DashboardBackground extends StatelessWidget {
  const DashboardBackground({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey,width: 0.6),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: kBackgroundColor,
            ),

          ),
        ),

      ],
    );
  }
}

class PathPainter extends CustomPainter {
  Path path;
  Path fillPath;
  PathPainter({required this.path, required this.fillPath});

  @override
  void paint(Canvas canvas, Size size) {
    // paint the line
    final paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawPath(path, paint);
    // paint the gradient fill
    paint.style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
      Offset.zero,
      Offset(0.0, size.height),
      [
        Colors.transparent,
        Colors.transparent,
      ],
    );
    canvas.drawPath(fillPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ChartDataPoint {
  double value;
  ChartDataPoint({required this.value});
}