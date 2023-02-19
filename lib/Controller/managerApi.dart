import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/gymDto.dart';
import '../Utils/httpurls.dart';
import '../Utils/toast.dart';
import 'gymApi.dart';


class ManagerApi with ChangeNotifier {

  Future<bool?> check_code(String code)async{
    var res = await http.post(Uri.parse(ManagerApi_Url().check_code + "${code}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },);

    if(res.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

// Future<List<TrainerDto>>
  Future<List<TrainerDto>> findall_trainer(String gymId)async{
    List<TrainerDto> trainers = [];
    var res = await http.get(Uri.parse(ManagerApi_Url().finall_trainer + "${gymId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

      },);


    if(res.statusCode == 200){
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      for(int i = 0 ; i<data.length;i++){

        trainers.add(TrainerDto.fromJson(data[i]));

      }
      print("trainers = ");
      print(trainers.length);

      return trainers;
    }else{
      return [];
    }
  }

  //managerId로 Gym정보조회
  Future<GymDto?> gyminfo_byManager(String? id,String? token)async{


    var res = await http.get(Uri.parse(ManagerApi_Url().info_gym_byId + "${id}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);



    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      print("datadatadata");
      print(data);



      GymDto? search_byId =await GymApi().search_byId(data['gymDto']['id']);


      return search_byId;
    }else{

      return null;
    }

  }

  Future<TrainerDto?> get_userinfo(String? token)async{

    var res = await http.get(Uri.parse(ManagerApi_Url().getinfo),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);


    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      TrainerDto trainerDto = TrainerDto.fromJson(data);
      return trainerDto;
    }else{
      showtoast("ERROR");
      return null;
    }

  }

  Future<bool?> register_profile(PickedFile profile,String managerId) async{
    FormData _formData;


      final MultipartFile _files = MultipartFile.fromFileSync(profile.path,
          contentType: MediaType("image", "jpg"));

      final baseOptions = BaseOptions(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );
      Dio dio = Dio(baseOptions);

      _formData = FormData.fromMap({
        "images": _files,
      });

      var res = await dio.post(ManagerApi_Url().save_img + "${managerId}",
          data: _formData);

      print(res.statusCode);
      print(res.data);


      // if (res.statusCode == 200) {
      //   return true;
      // } else {
      //   showtoast("ERROR");
      //   return false;
      // }

  }

  //manager 회원가입
  Future<int?> register_manager(
      String id, String password, String nickname, String oneline_introduce,String introduce) async {


    var res = await http.post(Uri.parse(ManagerApi_Url().save_manager),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'password': password,
          'nickname': nickname,
          'oneline_introduce':oneline_introduce,
          'introduce':introduce,
          'name': id,
        }));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", data['id'].toString());
      return data['id'];
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  //trainer 회원가입
  Future<int?> register_trainer(
      String id, String password, String nickname,String gymId) async {
    var res = await http.post(Uri.parse(ManagerApi_Url().save_trainer+"$gymId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'name': id,
          'password': password,
          'nickname': nickname,
        }));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      return data['id'];
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  //manager,trainer 로그인
  Future<String?> login_manager(
      String id, String password) async {

    var res = await http.post(Uri.parse(ManagerApi_Url().login_manager),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'name': id,
          'password': password,

        }));

    if (res.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      var userId = prefs.getString("userId");

      //초기 로그인시 userId(PK)저장
      if(userId == null){
        print("set userId");
        var userId =await get_userinfo(data['token']);
        prefs.setString("userId", userId.toString());
      }

      return data['token'];
    } else {
      showtoast("ERROR");
      return null;
    }
  }


}