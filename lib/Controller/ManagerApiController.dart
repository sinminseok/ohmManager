import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../Model/GymDto.dart';
import '../Utils/httpurls.dart';
import '../Utils/toast.dart';
import 'GymApiControllerr.dart';


class ManagerApiController with ChangeNotifier {


  //managerId로 Gym정보조회
  Future<GymDto?> gyminfo_byManager(String? id,String? token)async{

    var res = await http.get(Uri.parse(ManagerApi_Url().info_manager + "${id}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },);


    if (res.statusCode == 200) {

      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);


      GymDto? search_byId =await GymApiController().search_byId(data['gymDto']['id']);

      //    GymDto gymDto = GymDto.fromJson(data['gymDto']);

      return search_byId;
    }else{
      showtoast("ERROR");
      return null;
    }

  }




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
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      print(data['token']);

      return data['token'];
    } else {
      showtoast("ERROR");
      return null;
    }
  }


}