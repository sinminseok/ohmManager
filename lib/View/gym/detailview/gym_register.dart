

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/gyminput.dart';
import '../../../Utils/widget/rouninput_widget.dart';
import 'gym_register2.dart';
import 'gym_register3.dart';

class GymRegisterView extends StatefulWidget {
  const GymRegisterView({Key? key}) : super(key: key);

  @override
  _GymRegisterViewState createState() => _GymRegisterViewState();
}

class _GymRegisterViewState extends State<GymRegisterView> {

  final _valueList = ['없음','월요일', '화요일', '수요일','목요일','금요일','토요일','일요일'];
  var _selectedValue = '없음';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _onlineintroduceController = TextEditingController();
  TextEditingController _introduceController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _trainerCountController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _countController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: kBackgroundColor,
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
                controller: _addressController,
                hint: '주소'),
            GymInput(
                controller: _areaController,
                hint: '면적수'),
            GymInput(
                controller: _onlineintroduceController,
                hint: '한줄소개'),
            GymInput(
                controller: _introduceController,
                hint: '소개(글자수 제한 없음)'),
            GymInput(
                controller: _countController,
                hint: '센터 인원수'),
            GymInput(
                controller: _codeController,
                hint: '트레이너 가입코드(4자리)'),
            GymInput(
                controller: _trainerCountController,
                hint: '트레이너 인원'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("휴관일",style: TextStyle(fontSize: 23,),),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                      width: 100.w,
                      height: 50.h,
                      child: DropdownButton(
                        isExpanded: true, //make true to take width of parent widget
                        underline: Container(), //empty line
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        dropdownColor: Colors.green,
                        iconEnabledColor: Colors.black, //Icon color
                        value: _selectedValue,
                        items: _valueList.map(
                              (value) {
                            return DropdownMenuItem (
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 100,),


            InkWell(
                onTap: ()async{
                  final prefs = await SharedPreferences.getInstance();
                  GymApi().register_gym(prefs.getString("token").toString(),_nameController.text, _addressController.text, int.parse(_countController.text), _onlineintroduceController.text, _codeController.text, _introduceController.text, _areaController.text, _trainerCountController.text,);
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: GymRegisterView2(closedday: _selectedValue,)));
                  },
                child: Text("다음",style: TextStyle(fontSize: 23),)),
          ],
        ),
      ),
    );
  }
}
