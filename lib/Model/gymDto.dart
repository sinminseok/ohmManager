import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'gymImgDto.dart';

class GymDto {
  int? id;
  String? name;
  String? address;

  int? current_count;
  String? introduce;
  String? oneline_introduce;

  int? trainer_count;
  int? code;

  //server == count
  int? count;
  List<GymImgDto> imgs;

  GymDto(
      {
        required this.id,
        required this.name,
      required this.address,
      required this.current_count,
      required this.introduce,
      required this.count,
      required this.code,
      required this.trainer_count,
      required this.oneline_introduce,
      required this.imgs});

  factory GymDto.fromJson(Map<String, dynamic> json, imgs) {
    return GymDto(
      id: json['id'],
        name: json['name'],
        address: json['address'],
        current_count: json['current_count'],
        count: json['count'],
        introduce: json['introduce'],
        oneline_introduce: json['oneline_introduce'],
        imgs: imgs,
        code: json['code'],
        trainer_count: json['trainer_count']);
  }
}
