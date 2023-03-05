import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Model/questionDto.dart';

import 'postImgDto.dart';

class StatisticsDto {
  late double one;
  late double two;
  late double three;
  late double four;
  late double five;
  late double six;
  late double seven;
  late double eight;
  late double nine;
  late double ten;
  late double eleven;
  late double twelve;
  late double thirteen;
  late double fourteen;
  late double fifteen;
  late double sixteen;
  late double seventeen;
  late double eighteen;
  late double nineteen;
  late double twenty;
  late double twenty_one;
  late double twenty_two;
  late double twenty_three;
  late double twenty_four;

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
    required this.twenty_one,
    required this.twenty_two,
    required this.twenty_three,
    required this.twenty_four});

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
        twenty_one:json['twenty_one'],
        twenty_two:json['twenty_two'],
        twenty_three:json['twenty_three'],
        twenty_four:json['twenty_four'],

    );
  }
}
