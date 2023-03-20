import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Model/questionDto.dart';

import 'postImgDto.dart';

class AuthorityDto {
  late String authorityName;



  AuthorityDto(
      {required this.authorityName});


  factory AuthorityDto.fromJson(Map<String, dynamic> json) {
    return AuthorityDto(
      authorityName: json['authorityName'],
    );
  }




}