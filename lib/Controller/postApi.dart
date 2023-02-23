import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/postDto.dart';
import '../Model/postImgDto.dart';
import '../Utils/httpurls.dart';
import '../Utils/toast.dart';

class PostApi with ChangeNotifier {
  Future<bool?> delete_post(int postId) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.delete(Uri.parse(PostApi_Url().save_post+"${postId}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        },
        );

    if (res.statusCode == 200) {
      return true;
    } else {
      showtoast("ERRORR");
      return null;
    }
  }

  Future<bool?> update_post(int postId, String title, String content) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.patch(Uri.parse(PostApi_Url().update_post),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        },
        body: json.encode({'id': postId, 'title': title, 'content': content}));




    if (res.statusCode == 200) {
      return true;
    } else {
      showtoast("ERRORR");
      return null;
    }
  }

  Future<String?> save_post(
      String title, String content, String gymId, String token) async {
    var res = await http.post(
        Uri.parse(PostApi_Url().save_post + "${int.parse(gymId)}"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'title': title, 'content': content}));


    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      return data.toString();
    } else {
      showtoast("ERRORR");
      return null;
    }
  }

  save_postimg(String postId, List<XFile> imageFileList, String token) async {
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

        // contentType = 'multipart/form-data' // 'Application/json'
      );
      Dio dio = Dio(baseOptions);

      // if(imgList.isNotEmpty){
      _formData = FormData.fromMap({
        "images": _files,
      });

      var res = await dio.post(PostApi_Url().save_postimgs + "${postId}",
          data: _formData);
    }
  }

  //Gym에 종속된 Post 모두 조회
  Future<List<PostDto>?> findall_posts(String gymId) async {
    var res = await http.get(
      Uri.parse(PostApi_Url().findall_bygymId + "${gymId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    List<PostDto> posts = [];

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      for (int i = 0; i < data.length; i++) {
        List<PostImgDto> imgs = [];

        for (int j = 0; j < data[i]['imgs'].length; j++) {
          imgs.add(PostImgDto.fromJson(data[i]['imgs'][j]));
        }
        posts.add(PostDto.fromJson(data[i], imgs));
      }

      return posts;
    } else {
      return null;
    }
  }

  //Gym에 종속된 Post 모두 조회
  Future<List<PostDto>?> find_post(String postId) async {
    var res = await http.get(
      Uri.parse(PostApi_Url().find_byId + "${postId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    List<PostDto> posts = [];

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      for (int i = 0; i < data.length; i++) {
        List<PostImgDto> imgs = [];

        for (int j = 0; j < data[i]['imgs'].length; j++) {
          imgs.add(PostImgDto.fromJson(data[i]['imgs'][j]));
        }
        posts.add(PostDto.fromJson(data[i], imgs));
      }

      return posts;
    } else {
      return null;
    }
  }
}
