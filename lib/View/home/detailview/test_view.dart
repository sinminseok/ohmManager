import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'dart:ui' as ui;
import '../../../Utils/charts/chart_labels.dart';
import '../../../Utils/charts/laughing_data.dart';
import '../../../Utils/charts/slide_selector.dart';

class Dashboard extends StatefulWidget {
  List<double> time_avg;
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
  static const rightPadding = 60.0;


  double chartHeight = 240;
  late List<ChartDataPoint> chartData;

  @override
  void initState() {
    hourData = [
      //오전
      WeekData(
        days: [
          DayData(
            hour: 0,
            laughs: 0,
          ),
          DayData(
            hour: 1,
            laughs: widget.time_avg[1],
          ),
          DayData(
            hour: 2,
            laughs: widget.time_avg[3],
          ),
          DayData(
            hour: 3,
            laughs: widget.time_avg[4],
          ),
          DayData(
            hour: 4,
            laughs: widget.time_avg[5],
          ),
          DayData(
            hour: 5,
            laughs: widget.time_avg[6],
          ),
          DayData(
            hour: 6,
            laughs: widget.time_avg[7],
          ),
          DayData(
            hour: 6,
            laughs: widget.time_avg[8],
          ),
          DayData(
            hour: 7,
            laughs: widget.time_avg[9],
          ),

          DayData(
            hour: 8,
            laughs: widget.time_avg[10],
          ),
          DayData(
            hour: 9,
            laughs: widget.time_avg[11],
          ),
          DayData(
            hour: 10,
            laughs: widget.time_avg[12],
          ),
          DayData(
            hour: 11,
            laughs: widget.time_avg[13],
          ),

        ],
      ),


//오후
      WeekData(
        days: [
//12시
          DayData(
            hour: 0,
            laughs: 0,
          ),
          DayData(
            hour: 1,
            laughs: widget.time_avg[13],
          ),
          DayData(
            hour: 2,
            laughs: widget.time_avg[14],
          ),
          DayData(
            hour: 3,
            laughs: widget.time_avg[15],
          ),
          DayData(
            hour: 4,
            laughs: widget.time_avg[16],
          ),
          DayData(
            hour: 5,
            laughs: widget.time_avg[17],
          ),
          DayData(
            hour: 6,
            laughs: widget.time_avg[18],
          ),
          DayData(
            hour: 7,
            laughs: widget.time_avg[19],
          ),
          DayData(
            hour: 8,
            laughs: widget.time_avg[20],
          ),
          DayData(
            hour: 9,
            laughs: widget.time_avg[21],
          ),
          DayData(
            hour: 10,
            laughs: widget.time_avg[22],
          ),
          DayData(
            hour: 11,
            laughs: widget.time_avg[23],
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
    final width = MediaQuery.of(context).size.width;
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
          width: 360.w,
          height: 340.h,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 70,right: 70,top: 10),
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
                color: kBottomColor,
                child: Stack(
                  children: [
                    //아침데이터
                    // ChartLaughLabels(
                    //   chartHeight: chartHeight,
                    //   topPadding: 30,
                    //   leftPadding: leftPadding,
                    //   rightPadding: rightPadding,
                    //   weekData: hourData[activeWeek - 1],
                    // ),



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
                      top: 43.h,
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
            color: kBottomColor,
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
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawPath(path, paint);
    // paint the gradient fill
    paint.style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
      Offset.zero,
      Offset(0.0, size.height),
      [
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.85),
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