import 'dart:ffi';


import 'GymDto.dart';

class TrainerDto {

  late int id;

  late String name;

  late String profile;

  late String oneline_introduce;
  //자기소개
  late String introduce;

  late String nickname;

  late int age;

  late GymDto gym;

  TrainerDto({required this.gym,required this.id,required this.name,required this.profile,required this.oneline_introduce,required this.introduce,required this.nickname,required this.age});

  factory TrainerDto.fromJson(Map<String, dynamic> json) {
    return TrainerDto(
      gym: json['gym'],
      id: json['id'],
      name: json['name'],
      profile: json['profile'],
      oneline_introduce: json['oneline_introduce'],
      introduce: json['introduce'],
      nickname: json['nickname'],
      age: json['age'],
    );
  }

}