import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../../../Model/GymDto.dart';
import '../../../Model/GymImgDto.dart';
import 'package:http/http.dart' as http;

import '../Utils/httpurls.dart';
import '../Utils/toast.dart';

class GymApiController with ChangeNotifier {
  String? _gym_name;

  String? get gym_name => _gym_name;

  Future<String?> register_gym(
      String token,
      String name,
      String address,
      int count,
      String oneline_introduce,
      String code,
      String introduce,
      String area,
      String trainer_count,
      String CLOSEDDAYS,
      String SUNDAY,
      String SATURDAY,
      String WEEKDAY,
      String HOLIDAY) async {

    var res = await http.post(Uri.parse(GymApi_Url().register_gym),
        headers: {'Content-Type': 'application/json',  'Authorization': 'Bearer $token',},
        body: json.encode({

            "name":"테스트용name",
            "address":"테스트용ADDRess",
            "count":20,
            "oneline_introduce":"한줄소개",
            "code":1234,
            "area":"500평",
            "trainer_count":6,
            "CLOSEDDAYS":"6:00~7:00",
            "SUNDAY":"6:00~7:00",
            "SATURDAY":"6:00~7:00",
            "WEEKDAY":"6:00~7:00",
            "HOLIDAY":"6:00~7:00"

        }));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("gymId", data['id']);
      return data['id'].toString();
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  save_gymimg(String token,String gymId,List<XFile> imageFileList)async{


    FormData _formData;

    if(imageFileList.isNotEmpty){

      final List<MultipartFile> _files = imageFileList.map((img) => MultipartFile.fromFileSync(img.path,contentType: MediaType("image", "jpg"))).toList();

      final baseOptions = BaseOptions(

        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token' },

        // contentType = 'multipart/form-data' // 'Application/json'
      );
      Dio dio = Dio(baseOptions);



      // if(imgList.isNotEmpty){
      _formData = FormData.fromMap({
        "images": _files,

      });

      var res =await dio.post(GymApi_Url().registerimg_gym + "${gymId}", data :_formData);
      print(res.data);


    }}

  Future<List<GymDto>?> search_allgym() async {
    var res = await http.get(
      Uri.parse(GymApi_Url().findall),
      headers: {'Content-Type': 'application/json'},
    );

    List<GymDto> result = [];

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for (int i = 0; i < data.length; i++) {
        List<GymImgDto> imgs = [];
        for (int j = 0; j < data[i]['imgs'].length; j++) {
          imgs.add(GymImgDto.fromJson(data[i]['imgs'][j]));
        }

        result.add(GymDto.fromJson(data[i], imgs));
      }

      return result;
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  Future<GymDto?> search_byId(int gymId) async {
    var res = await http.get(
      Uri.parse(GymApi_Url().find_byId + "${gymId}"),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      List<GymImgDto> imgs = [];

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for (int i = 0; i < data['imgs'].length; i++) {
        imgs.add(GymImgDto.fromJson(data['imgs'][i]));
      }

      return GymDto.fromJson(data, imgs);
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  Future<List<GymDto>> search_byname(gym_name) async {
    //url 로 post(이메일 컨트롤러 , 패스워드 컨트롤러)
    var res = await http.get(
      Uri.parse(GymApi_Url().find_byName + "${gym_name}"),
      headers: {'Content-Type': 'application/json'},
    );
    print(res.statusCode);

    List<GymDto> result = [];

    var gymDto;
    //정상 로그인 http statuscode 200
    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for (int i = 0; i < data.length; i++) {
        List<GymImgDto> imgs = [];
        for (int j = 0; j < data[i]['imgs'].length; j++) {
          imgs.add(GymImgDto.fromJson(data[i]['imgs'][j]));
        }
        result.add(GymDto.fromJson(data[i], imgs));
      }
      print(result);
      return result;
    } else {
      showtoast("ERROR");
      return gymDto;
    }
  }
}
