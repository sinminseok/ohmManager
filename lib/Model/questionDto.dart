import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Model/answerDto.dart';

import 'postImgDto.dart';

class QuestionDto {
  late int id;
  late String content;
   AnswerDto? answerDto;


  QuestionDto(
      {required this.id,required this.content,required this.answerDto});


  factory QuestionDto.fromJson(Map<String, dynamic> json,AnswerDto? answerDto) {
    return QuestionDto(
      id: json['id'],
      answerDto:answerDto,
      content: json['content'],
    );
  }




}