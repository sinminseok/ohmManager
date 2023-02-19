import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/constants.dart';

class _LineChart extends StatelessWidget {

  //isShowingMainData true이면 시간 false이면 요일
  final List<double> time_data;

  final bool isShowingMainData;

  final double max_value;


  const _LineChart({required this.isShowingMainData,required this.time_data,required this.max_value});



  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? morning_chart : afternoon_chart,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  //오전시간별 데이터
  LineChartData get morning_chart => LineChartData(
    //라인터치
    lineTouchData: lineTouchData1,
    //실선
    gridData: gridData,

    titlesData: morning_side,

    borderData: borderData,

    lineBarsData: lineBarsData1,

    minX: 0.0,
    maxX: 12.h,
    maxY: max_value+7.h,
    minY: -4.h,
  );

  //오후시간별 데이터
  LineChartData get afternoon_chart => LineChartData(
    lineTouchData: lineTouchData2,
    gridData: gridData,
    titlesData: after_side,
    borderData: borderData,
    lineBarsData: lineBarsData2,
    minX: 0,
    maxX: 12.h,
    maxY: max_value+7.h,
    minY: -4.h,
  );


  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.1),
    ),
  );

  //x,y데이터
  FlTitlesData get morning_side => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    morning_value,
  ];

  LineTouchData get lineTouchData2 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get after_side => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles_afternoon,
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  List<LineChartBarData> get lineBarsData2 => [
    afternoon_value,
  ];



  Widget bottomTitleWidgets_time(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('', style: style);
        break;
      case 1:
        text = const Text('', style: style);
        break;
      case 2:
        text = const Text('1', style: style);
        break;
      case 3:
        text = const Text('2', style: style);
        break;
      case 4:
        text = const Text('3', style: style);
        break;
      case 5:
        text = const Text('4', style: style);
        break;
      case 6:
        text = const Text('5', style: style);
        break;
      case 7:
        text = const Text('6', style: style);
        break;
      case 8:
        text = const Text('7', style: style);
        break;
      case 9:
        text = const Text('8', style: style);
        break;
      case 10:
        text = const Text('9', style: style);
        break;
      case 11:
        text = const Text('10', style: style);
        break;
      case 12:
        text = const Text('11', style: style);
        break;

        break;


      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  Widget bottomTitleWidgets_date(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('', style: style);
        break;
      case 2:
        text = const Text('13', style: style);
        break;
      case 3:
        text = const Text('14', style: style);
        break;
      case 4:
        text = const Text('15', style: style);
        break;
      case 5:
        text = const Text('16', style: style);
        break;
      case 6:
        text = const Text('17', style: style);
        break;
      case 7:
        text = const Text('18', style: style);
        break;
      case 8:
        text = const Text('19', style: style);
        break;
      case 9:
        text = const Text('20', style: style);
        break;
      case 10:
        text = const Text('21', style: style);
        break;
      case 11:
        text = const Text('22', style: style);
        break;
      case 12:
        text = const Text('23', style: style);
        break;
      case 13:
        text = const Text('24', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets_time,
  );

  SideTitles get bottomTitles_afternoon => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets_date,
  );

  FlGridData get gridData => FlGridData(show: false);


  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(color: kPrimaryColor, width: 0),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  //오전 데이터
  LineChartBarData get morning_value => LineChartBarData(
    isCurved: true,
    color: kPrimaryColor,
    barWidth: 6,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots:  [
      FlSpot(2, time_data[1]),
      FlSpot(3, time_data[2]),
      FlSpot(4, time_data[3]),
      FlSpot(5, time_data[4]),
      FlSpot(6, time_data[5]),
      FlSpot(7, time_data[6]),
      FlSpot(8, time_data[7]),
      FlSpot(9, time_data[8]),
      FlSpot(10, time_data[9]),
      FlSpot(11, time_data[10]),
      FlSpot(12, time_data[11]),



    ],
  );

  //요일별 데이터
  LineChartBarData get afternoon_value => LineChartBarData(
    isCurved: true,
    color: kPrimaryColor,
    barWidth: 6,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots:  [
      FlSpot(2, time_data[13]),
      FlSpot(3, time_data[14]),
      FlSpot(4, time_data[15]),
      FlSpot(5, time_data[16]),
      FlSpot(6, time_data[17]),
      FlSpot(7, time_data[18]),
      FlSpot(8, time_data[19]),
      FlSpot(9, time_data[20]),
      FlSpot(10, time_data[21]),
      FlSpot(11, time_data[22]),
      FlSpot(12, time_data[23]),
      FlSpot(13, time_data[0]),


    ],
  );
}

//UI

class LineChartSample1 extends StatefulWidget {
  List<double> time_data;
  double max_value;
  LineChartSample1({required this.time_data,required this.max_value});


  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;



  @override
  void initState() {
    print("object");
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(),
              padding:
              const EdgeInsets.only(left: 20.0, bottom: 10,top: 10),
              child: isShowingMainData?
              Text(
                "오전 헬스장 인원수",
                style:
                TextStyle(fontFamily: "boldfont", fontSize: 18,fontWeight: FontWeight.bold),
              ):Text(
                "오후 헬스장 인원수",
                style:
                TextStyle(fontFamily: "boldfont", fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: kPrimaryColor,
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
        Container(
          width: 350.w,
          height: 180.h,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[



                  Expanded(

                    child: Container(

                      margin: EdgeInsets.only(left: 10.w,right: 10.w,),

                      decoration: BoxDecoration(
                          color: kBoxColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),

                      padding: const EdgeInsets.only(right: 16, left: 6,bottom: 10),
                      child: _LineChart(isShowingMainData: isShowingMainData, time_data: widget.time_data, max_value: widget.max_value,),
                    ),
                  ),

                ],
              ),

            ],
          ),

        ),
      ],
    );
  }
}