import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/gymDto.dart';
import '../Utils/httpurls.dart';
import '../Utils/toast.dart';
import 'gymApi.dart';


class ManagerApi with ChangeNotifier {


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


      GymDto? search_byId =await GymApi().search_byId(data['gymDto']['id']);

      //    GymDto gymDto = GymDto.fromJson(data['gymDto']);

      return search_byId;
    }else{
      showtoast("ERROR");
      return null;
    }

  }

  Future<String?> get_userinfo(String? token)async{

    var res = await http.get(Uri.parse(ManagerApi_Url().getinfo),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);


    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      print(data);
      return data['id'].toString();
    }else{
      showtoast("ERROR");
      return null;
    }

  }




  //manager 회원가입
  Future<int?> register_manager(
      String id, String password, String nickname, String code) async {
    var res = await http.post(Uri.parse(ManagerApi_Url().save_manager),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: json.encode({
          'password': password,
          'nickname': nickname,
          'code': code,
          'name': id,
        }));

    print(res.body);

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
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

    print(res.body);

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