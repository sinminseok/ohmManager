import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ohmmanager/Model/message/answerDto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/message/questionDto.dart';
import '../Utils/sundry/httpurls.dart';

class QuestionApi with ChangeNotifier {
  //Gym에 종속된 Post 모두 조회
  Future<List<QuestionDto>> findall_question(String gymId) async {
    var res = await http.get(
      Uri.parse(QuestionApi_Url().findall_question + "${gymId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    List<QuestionDto> questions = [];

    if (res.statusCode == 200) {
      final decodeData = utf8.decode(res.bodyBytes);
      final data = jsonDecode(decodeData);

      for (int i = 0; i < data.length; i++) {
        questions.add(QuestionDto.fromJson(
            data[i],
            data[i]['answer'] == null
                ? null
                : AnswerDto.fromJson(data[i]['answer'])));
      }

      return questions;
    } else {
      return [];
    }
  }

  Future<bool> delete_question(int questionId) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.delete(
      Uri.parse(QuestionApi_Url().find_question + "${questionId}"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register_answer(int questionId, String content) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.post(
        Uri.parse(QuestionApi_Url().register_answer + "${questionId}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        },
        body: json.encode(({
          "content": content,
        })));

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> edit_answer(int answerId, String content) async {
    final prefs = await SharedPreferences.getInstance();

    var res = await http.patch(
        Uri.parse(QuestionApi_Url().register_answer + "${answerId}"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        },
        body: json.encode(({
          "content": content,
        })));

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
