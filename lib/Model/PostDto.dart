import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'PostImgDto.dart';

class PostDto {
  late int id;
  late String title;
  late String content;
  late List<PostImgDto> imgs;


  PostDto(
      {required this.id,required this.title, required this.content, required this.imgs});

  PostDto.makeDto(String title,String content):
        this.title = title,
        this.content = content;


  factory PostDto.fromJson(Map<String, dynamic> json,List<PostImgDto> imgs) {
    return PostDto(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imgs: imgs,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'content': content,
      };



}