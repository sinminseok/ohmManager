

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/GymApiControllerr.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/gyminput.dart';
import '../../../Utils/widget/rouninput_widget.dart';
import 'gym_register2.dart';

class GymRegisterView extends StatefulWidget {
  const GymRegisterView({Key? key}) : super(key: key);

  @override
  _GymRegisterViewState createState() => _GymRegisterViewState();
}

class _GymRegisterViewState extends State<GymRegisterView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _onlineintroduceController = TextEditingController();
  TextEditingController _introduceController = TextEditingController();
  TextEditingController _areaController = TextEditingController();

  //휴관일
  TextEditingController _closeddaysController = TextEditingController();
  //공휴일 운영시간
  TextEditingController _holidayController = TextEditingController();
  //평일 운영시간
  TextEditingController _weekdaysController = TextEditingController();
  //일요일 운영시간
  TextEditingController _sundayController = TextEditingController();
  //토요일 운영시간
  TextEditingController _saturdayController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70.h),
              child: Center(
                child: GymInput(
                    controller: _nameController,
                    hint: '센터 이름'),
              ),
            ),

            GymInput(
                controller: _nameController,
                hint: '주소'),
            GymInput(
                controller: _areaController,
                hint: '면적수'),
            GymInput(
                controller: _onlineintroduceController,
                hint: '한줄소개'),
            GymInput(
                controller: _areaController,
                hint: '소개(글자수 제한 없음)'),

            InkWell(
                onTap: ()async{
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: GymRegisterView2()));
                },
                child: Text("센터 사진등록 페이지")),
            InkWell(
                onTap: ()async{
                  final prefs = await SharedPreferences.getInstance();
                  GymApiController().register_gym(prefs.getString("token").toString(),_nameController.text, _addressController.text, 100, _onlineintroduceController.text, "1234", _introduceController.text, _areaController.text, "10", "10:20", "10:20", "10:20", "10:20", "10:20");
                },
                child: Text("센터 등록")),
          ],
        ),
      ),
    );
  }
}
