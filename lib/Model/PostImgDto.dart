

import 'dart:ffi';

class PostImgDto{

  late int id;
  late String origFileName;
  late String filePath;


  PostImgDto(
      {required this.id, required this.origFileName, required this.filePath});

  factory PostImgDto.fromJson(Map<String, dynamic> json) {
    return PostImgDto(

      id: json['id'],
      origFileName: json['origFileName'],
      filePath: json['filePath'],
    );
  }



}