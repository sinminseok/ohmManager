import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Model/gymTimeDto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../../../Model/gymDto.dart';
import '../../../Model/gymImgDto.dart';
import 'package:http/http.dart' as http;
import '../Model/gymPriceDto.dart';
import '../Utils/httpurls.dart';
import '../Utils/toast.dart';

class GymApi with ChangeNotifier {
  String? _gym_name;

  String? get gym_name => _gym_name;

  Future<int?> check_code(String code) async {
    var res = await http.get(
      Uri.parse(GymApi_Url().check_code + "$code"),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      return data;
    } else {
      showtoast("ERROR");
      return null;
    }
  }

  Future<bool?> save_gymimg(
      String token, String gymId, List<XFile> imageFileList) async {
    FormData _formData;

    if (imageFileList.isNotEmpty) {
      final List<MultipartFile> _files = imageFileList
          .map((img) => MultipartFile.fromFileSync(img.path,
              contentType: MediaType("image", "jpg")))
          .toList();

      final baseOptions = BaseOptions(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'
        },
      );
      Dio dio = Dio(baseOptions);

      _formData = FormData.fromMap({
        "images": _files,
      });

      var res = await dio.post(GymApi_Url().registerimg_gym + "${gymId}",
          data: _formData);
      if (res.statusCode == 200) {
        return true;
      } else {
        showtoast("ERROR");
        return false;
      }
    }
  }

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
      print("dddadasdas");
      print(data);
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

  Future<bool> register_time(String? gymId, String? token, String? closeddays,
      String sunday, String saturday, String weekday, String holiday) async {
    var res = await http.post(
        Uri.parse(GymApi_Url().register_time + "${gymId.toString()}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(({
          "closeddays": closeddays,
          "sunday": sunday,
          "saturday": saturday,
          "weekday": weekday,
          "holiday": holiday
        })));

    if (res.statusCode == 200) {
      return true;
    } else {
      showtoast("ERROR");
      return false;
    }
  }

  Future<bool> update_time(int? gymTimeId,String? gymId, String? token, String? closeddays,
      String sunday, String saturday, String weekday, String holiday) async {
    var res = await http.patch(
        Uri.parse(GymApi_Url().register_time + "${gymId.toString()}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(({
          "id":gymTimeId,
          "closeddays": closeddays,
          "sunday": sunday,
          "saturday": saturday,
          "weekday": weekday,
          "holiday": holiday
        })));

    if (res.statusCode == 200) {
      return true;
    } else {
      showtoast("ERROR");
      return false;
    }
  }


  Future<bool> register_price(String? gymId,String? token,List<GymPriceDto> prices) async {


    for(int i=0;i<prices.length;i++){
      var res = await http.post(
          Uri.parse(GymApi_Url().register_price + "${gymId.toString()}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(({
            "during": prices[i].during,
            "price": prices[i].price
          })));
    }

    return true;

  }

  Future<bool> delete_price(String? gymId,String? token,List<int?> pricesIds) async {


    for(int i=0;i<pricesIds.length;i++){
      var res = await http.patch(
          Uri.parse(GymApi_Url().register_price + "${gymId.toString()}?priceIds=${pricesIds.toString().substring(1,pricesIds.toString().length-1)}"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

      print(res);
    }

    return true;

  }

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
  ) async {
    var res = await http.post(Uri.parse(GymApi_Url().register_gym),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "name": name,
          "address": address,
          "count": count,
          "oneline_introduce": oneline_introduce,
          "introduce":introduce,
          "code": code,
          "area": area,
          "trainer_count": trainer_count,
        }));
    print(res);

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      print("REGISTER GYM ID");
      print(data);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("gymId", data.toString());

      return data.toString();
    } else {
      showtoast("ERROR");
      return null;
    }
  }



  Future<List<double>?> get_timeavg(String gymId)async{

    List<double> values = [];
    var res = await http.get(
      Uri.parse(GymApi_Url().time_avg + "${gymId}"),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for(int i = 0 ;i<data.length;i++){
        values.add(double.parse(data[i]));
      }

      return values;
    } else {

      return null;
    }

  }

  Future<bool> update_gymInfo(int? id,String? name,String? address,int? count,String? oneline_introduce,String? introduce,int? trainer_count,int? code)async{
    final prfes = await SharedPreferences.getInstance();
    List<double> values = [];
    var res = await http.patch(
        Uri.parse(GymApi_Url().udpate_gymInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prfes.getString("token")}',
        },
        body: json.encode({
          'id':id,
          "name": name,
          "address": address,
          "count": count,
          "oneline_introduce": oneline_introduce,
          "introduce":introduce,
          "code": code,
          "trainer_count": trainer_count,
        }));

    if (res.statusCode == 200) {



      return true;
    } else {

      return false;
    }
  }

  Future<bool?> update_gymImgs(int? gymId,List<String?> delete_imgs,List<XFile> imageFileList)async{

    print(delete_imgs.toString().substring(1,delete_imgs.toString().length-1));
    print("delete_imgs");
    List<MultipartFile> _files=[];
    final prfes = await SharedPreferences.getInstance();
    FormData _formData;


  if(imageFileList.isNotEmpty){
    _files= imageFileList
        .map((img) => MultipartFile.fromFileSync(img.path,
        contentType: MediaType("image", "jpg")))
        .toList();
  }



      final baseOptions = BaseOptions(
        headers: {
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer ${prfes.getString("token")}'
        },
      );
      Dio dio = Dio(baseOptions);

      _formData = FormData.fromMap({
        "images": _files,
      });

      var res = await dio.post(GymApi_Url().registerimg_gym + "update/${gymId}"+"?imgIds=${delete_imgs.toString().substring(1,delete_imgs.toString().length-1)}",
          data: _formData);
      print(res);
      if (res.statusCode == 200) {
        return true;
      } else {
        showtoast("ERROR");
        return false;
      }


  }


  Future<List<GymPriceDto>?> getPrices(int? gymId)async{

    List<GymPriceDto> prices = [];

    var res = await http.get(
      Uri.parse(GymApi_Url().find_gymPrice + "${gymId}"),
      headers: {'Content-Type': 'application/json'},
    );

    print(res);
    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      for(int i = 0 ;i<data.length;i++){
        prices.add(GymPriceDto.fromJson(data[i]));
      }

      return prices;
    } else {

      return null;
    }
  }


  Future<GymTimeDto?> getTime(int? gymId)async{

    List<GymPriceDto> prices = [];

    var res = await http.get(
      Uri.parse(GymApi_Url().register_time + "${gymId}"),
      headers: {'Content-Type': 'application/json'},
    );

    print(res);
    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);
      var gymTimeDto =await GymTimeDto.fromJson(data);
      return gymTimeDto;

    } else {

      return null;
    }
  }
}
