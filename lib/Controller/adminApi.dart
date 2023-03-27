import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Model/authorityDto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/gymDto.dart';
import '../Model/gymImgDto.dart';
import '../Utils/httpurls.dart';
import 'gymApi.dart';


class AdminApi with ChangeNotifier {

  Future<bool?> change_showProfile(String managerId)async{
    final prefs = await SharedPreferences.getInstance();
    var res = await http.post(Uri.parse(AdminApi_Url().showProfile+managerId),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}',

      },);

    print(res);
    if(res.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool?> check_code(String code)async{
    var res = await http.post(Uri.parse(AdminApi_Url().checkCode_ceo + "${code}"),
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

  //헬스장에 종속된 모든 관리자 정보 조회
  Future<List<TrainerDto>> findall_admin(String gymId)async{
    List<TrainerDto> trainers = [];
    var res = await http.get(Uri.parse(AdminApi_Url().findall_admin + "${gymId}"),
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


      return trainers;
    }else{
      return [];
    }
  }

  Future<bool> delete_account(String managerId,String token)async{
    var res = await http.delete(Uri.parse(AdminApi_Url().delete_account+managerId),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',

      },);


    if(res.statusCode == 200){

      return true;
    }else{
      return false;
    }
  }

  Future<List<GymDto>?> findgyms_byceo(String? id,String? token)async{


    print("findbygym");
    List<GymDto> gyms = [];
    var res = await http.get(Uri.parse(AdminApi_Url().gyms_byceo + "${int.parse(id!)}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    print(res.body);


    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for(int i = 0 ;i<data.length;i++){
        List<GymImgDto> imgs = [];
        for(int j = 0;j<data[i]["imgs"].length;j++){
          imgs.add(GymImgDto.fromJson(data[i]['imgs'][j]));
        }
        gyms.add(GymDto.fromJson(data[i], imgs));
      }



      return gyms;
    }else{

      return null;
    }

  }

  Future<GymDto?> gyminfo_byManager(String? id,String? token)async{


    var res = await http.get(Uri.parse(AdminApi_Url().getInfo_byId + "${int.parse(id!)}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);


    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      GymDto? searchById =await GymApi().search_byId(data['gymDto']['id']);
      final prefs = await SharedPreferences.getInstance();
      if(prefs.getString("gymId") == null){
        prefs.setString("gymId", searchById!.id.toString());
      }

      return searchById;
    }else{

      return null;
    }

  }

  Future<TrainerDto?> get_userinfo(String? token)async{

    var res = await http.get(Uri.parse(AdminApi_Url().getInfo),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);

    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      // AuthorityDto authorityDto = AuthorityDto.fromJson(data['authorities'][0]);

      print(data);
      TrainerDto trainerDto = TrainerDto.fromJson(data);
     
      return trainerDto;
    }else{
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

    var res = await dio.post(AdminApi_Url().update_profile + "${managerId}",
        data: _formData);



  }

  //프사변경
  Future<bool?> update_profile(String token,PickedFile profile,String managerId) async{
    FormData _formData;


    final MultipartFile _files = MultipartFile.fromFileSync(profile.path,
        contentType: MediaType("image", "jpg"));

    final baseOptions = BaseOptions(
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      },
    );
    Dio dio = Dio(baseOptions);

    _formData = FormData.fromMap({
      "images": _files,
    });

    var res = await dio.patch(AdminApi_Url().register_profile + "${managerId}",
        data: _formData);



  }


  //manager 회원가입
  Future<int?> register_ceo(
String position,String id, String password, String nickname) async {


    var res = await http.post(Uri.parse(AdminApi_Url().save_ceo),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'position' :position,
          'password': password,
          'nickname': nickname,


          'username': id,
        }));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("userId", data['id'].toString());
      return data['id'];
    } else {

      return null;
    }
  }

  //manager 회원가입
  Future<int?> register_manager(
      String position,String id, String password, String nickname,String gymId) async {
    final prfes = await SharedPreferences.getInstance();


    var res = await http.post(Uri.parse(AdminApi_Url().save_manager+"$gymId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prfes.getString("token")}',
        },
        body: json.encode({
          'position':position,
          'password': password,
          'nickname': nickname,

          'username': id,
        }));



    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString("userId", data['id'].toString());
      return data['id'];
    } else {

      return null;
    }
  }

  //manager 정보수정
  Future<bool?> update_admin(
      String position,String token,int? id,String nickname, String onelineIntroduce,String introduce,String name) async {


    var res = await http.patch(Uri.parse(AdminApi_Url().update_info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'id':id,
          'position':position,
          'username':name,
          'nickname': nickname,
          'onelineIntroduce':onelineIntroduce,
          'introduce':introduce,

        }));



    if (res.statusCode == 200) {
      return true;
    } else {

      return false;
    }
  }

  //trainer 회원가입
  Future<int?> register_trainer(
      String position,String id ,String password, String nickname,String gymId) async {
    final prfes = await SharedPreferences.getInstance();

    var res = await http.post(Uri.parse(AdminApi_Url().save_trainer+"$gymId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prfes.getString("token")}',
        },
        body: json.encode({
          'position':position,
          'username': id,
          'password': password,

          'nickname': nickname,
        }));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      return data['id'];
    } else {

      return null;
    }
  }

  //manager,trainer,ceo 로그인
  Future<String?> login_manager(
      String id, String password) async {

    var res = await http.post(Uri.parse(AdminApi_Url().login),
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
      TrainerDto? trainerDto =await get_userinfo(data['token']);
      // var userId = prefs.getString("userId");

      //초기 로그인시 userId(PK)저장
      // if(userId != trainerDto!.id.toString() || userId == null){
      //
      //   prefs.setString("userId", trainerDto!.id.toString());
      // }
      await prefs.remove("gymId");
      await prefs.setString("userId", trainerDto!.id.toString());
      print(prefs.getString("userId"));
      print("setUserId");
      return data['token'];
    } else {

      return null;
    }
  }


}