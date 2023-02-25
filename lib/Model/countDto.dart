import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Model/questionDto.dart';

import 'postImgDto.dart';

class CountDto {
  late int count;
  late String avgCount;



  CountDto(
      {required this.count,required this.avgCount});


  factory CountDto.fromJson(Map<String, dynamic> json) {
    return CountDto(
      count: json['count'],
      avgCount: json['avgCount'],
    );
  }




}