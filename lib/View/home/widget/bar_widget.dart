


import 'package:flutter/material.dart';
import 'package:ohmmanager/Utils/constants.dart';

import '../../../Model/barDto.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class Bar_Widget{


  static List<charts.Series<BarMmodel, String>> time_data() {
    final data = [
      BarMmodel("6", 20),
      BarMmodel("7", 23),
      BarMmodel("8", 29),
      BarMmodel("9", 30),
      BarMmodel("10", 29),
      BarMmodel("11", 23),
      BarMmodel("12", 20),
      BarMmodel("13", 20),
      BarMmodel("14", 40),
      BarMmodel("15", 30),
      BarMmodel("16", 10),
      BarMmodel("17", 5),
      BarMmodel("18", 60),
      BarMmodel("19", 20),
      BarMmodel("20", 40),
      BarMmodel("21", 20),
      BarMmodel("22", 70),
      BarMmodel("23", 20),
      BarMmodel("24", 20),
    ];
    return [
      charts.Series<BarMmodel, String>(
        data: data,
        id: 'sales',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(kTextColor),
        domainFn: (BarMmodel barModeel, _) => barModeel.year,
        measureFn: (BarMmodel barModeel, _) => barModeel.value,
      )
    ];
  }

  static List<charts.Series<BarMmodel, String>> date_data() {
    final data = [
      BarMmodel("월", 20),
      BarMmodel("화", 23),
      BarMmodel("수", 29),
      BarMmodel("목", 30),
      BarMmodel("금", 29),
      BarMmodel("토", 23),
      BarMmodel("일", 20),

    ];
    return [
      charts.Series<BarMmodel, String>(
        data: data,
        id: 'sales',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.green.shade600),
        domainFn: (BarMmodel barModeel, _) => barModeel.year,
        measureFn: (BarMmodel barModeel, _) => barModeel.value,
      )
    ];
  }

}