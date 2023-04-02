import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class StatisticsDto {
  late int zero;
  late int one;
  late int two;
  late int three;
  late int four;
  late int five;
  late int six;
  late int seven;
  late int eight;
  late int nine;
  late int ten;
  late int eleven;
  late int twelve;
  late int thirteen;
  late int fourteen;
  late int fifteen;
  late int sixteen;
  late int seventeen;
  late int eighteen;
  late int nineteen;
  late int twenty;
  late int twentyOne;
  late int twentyTwo;
  late int twentyThree;


  StatisticsDto({required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.six,
    required this.seven,
    required this.eight,
    required this.nine,
    required this.ten,
    required this.eleven,
    required this.twelve,
    required this.thirteen,
    required this.fourteen,
    required this.fifteen,
    required this.sixteen,
    required this.seventeen,
    required this.eighteen,
    required this.nineteen,
    required this.twenty,
    required this.twentyOne,
    required this.twentyTwo,
    required this.twentyThree,
    required this.zero});

  factory StatisticsDto.fromJson(Map<String, dynamic> json) {
    return StatisticsDto(


        one :json['one'],
        two :json['two'],
        three:json['three'],
        four:json['four'],
        five:json['five'],
        six:json['six'],
        seven:json['seven'],
        eight:json['eight'],
        nine:json['nine'],
        ten:json['ten'],
        eleven:json['eleven'],
        twelve:json['twelve'],
        thirteen:json['thirteen'],
        fourteen:json['fourteen'],
        fifteen:json['fifteen'],
        sixteen:json['sixteen'],
        seventeen:json['seventeen'],
        eighteen:json['eighteen'],
        nineteen:json['nineteen'],
        twenty:json['twenty'],
      twentyOne:json['twentyOne'],
      twentyTwo:json['twentyTwo'],
      twentyThree:json['twentyThree'],
      zero:json['zero'],
    );
  }
}
