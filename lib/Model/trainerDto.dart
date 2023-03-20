import 'dart:ffi';


import 'package:ohmmanager/Model/authorityDto.dart';

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
   
   String? role;


  TrainerDto({required this.role,required this.position,required this.id,required this.name,required this.profile,required this.oneline_introduce,required this.introduce,required this.nickname,required this.age});

  factory TrainerDto.fromJson(Map<String, dynamic> json) {
    return TrainerDto(
      id: json['id'],
      position:json['position'],
      name: json['username'],
      profile: json['profile'],
      oneline_introduce: json['onelineIntroduce'],
      introduce: json['introduce'],
      nickname: json['nickname'],
        role:json['role'], age: null
    );
  }

}