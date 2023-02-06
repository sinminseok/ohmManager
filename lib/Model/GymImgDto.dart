
import 'dart:ffi';

class GymImgDto{

  late int id;
  late String origFileName;
  late String filePath;

  GymImgDto(
      {required this.id, required this.origFileName, required this.filePath});

  factory GymImgDto.fromJson(Map<String, dynamic> json) {
    return GymImgDto(

      id: json['id'],
      origFileName: json['origFileName'],
      filePath: json['filePath'],

    );
  }


}