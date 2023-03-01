import 'dart:ffi';


import 'gymDto.dart';

class TrainerDto {

   int? id;

   String? name;

   String? profile;

   String? position;

   String? oneline_introduce;
  //자기소개
   String? introduce;

   String? nickname;

   int? age;


  TrainerDto({required this.position,required this.id,required this.name,required this.profile,required this.oneline_introduce,required this.introduce,required this.nickname,required this.age});

  factory TrainerDto.fromJson(Map<String, dynamic> json) {
    return TrainerDto(
      id: json['id'],
      position:json['position'],
      name: json['name'],
      profile: json['profile'],
      oneline_introduce: json['oneline_introduce'],
      introduce: json['introduce'],
      nickname: json['nickname'],
      age: json['age'],
    );
  }

}