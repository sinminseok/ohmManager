

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohmmanager/Utils/constants.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key}) : super(key: key);

  @override
  _MypageViewState createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 50,),
            Center(child: Text("이름")),
            Text("프로필사진"),
            Text("한줄소개"),
            Text("소개"),

            Container(height: 50,),
            Text("프로필 수정 버튼")
            
            
          ],
        ),
      ),
    );
  }
}
