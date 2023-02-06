import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'GymImgDto.dart';



class GymDto {

  String? name;
  String? address;
  int? count;
  String? introduce;
  String? oneline_introduce;
  List<GymImgDto> imgs;

  GymDto(
      {required this.name, required this.address, required this.count, required this.introduce, required this.oneline_introduce,required this.imgs});

  factory GymDto.fromJson(Map<String, dynamic> json,imgs) {
    return GymDto(
      name: json['name'],
      address: json['address'],
      count: json['count'],
      introduce: json['introduce'],
      oneline_introduce: json['oneline_introduce'],
      imgs: imgs,
    );
  }
}