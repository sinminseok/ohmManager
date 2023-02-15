

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';
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
  bool holyday = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _trainerCountController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _countController = TextEditingController();

  TextEditingController _onelineController = TextEditingController();
  TextEditingController _introduceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kIconColor, //change your color here
        ),
        shape: Border(
            bottom: BorderSide(
                color: Colors.black26,
                width: 0.3
            )
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(left: 15,top: 20,bottom: 10),
                child: Text("헬스장 소개",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),)),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 340.w,
                child: TextFormField(
                  controller: _onelineController,
                  textAlign: TextAlign.center,
                  cursorColor: kContainerColor,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.,
                      hintText: "한줄소개",
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 340.w,
                height: 100.h,
                child: TextFormField(
                  maxLines: null,
                  controller: _introduceController,
                  textAlign: TextAlign.center,
                  cursorColor: kContainerColor,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.,
                      hintText: "헬스장 소개",
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
            Center(child: RoundedInput(title: "헬스장이름", controller: _nameController, number_mode: false,)),

            Center(child: RoundedInput(title: "주소", controller: _addressController, number_mode: false)),
            Center(child: RoundedInput(title: "면적 (평수)", controller: _areaController, number_mode: true)),

            Center(child: RoundedInput(title: "회원수", controller: _countController, number_mode: true)),
            Center(child: RoundedInput(title: "가입코드(4자리)", controller: _codeController, number_mode: true)),
            Center(child: RoundedInput(title: "트레이너 인원", controller: _trainerCountController, number_mode: true)),
            Center(
              child: Container(
                width: 340.w,
                height: 40.h,
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("휴관일",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: kTextBlackColor),),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(

                          width: 100.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: DropdownButton(
                            isExpanded: true, //make true to take width of parent widget
                            underline: Container(), //empty line
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            dropdownColor: kContainerColor,
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
              ),
            ),
            Center(
              child: Container(
                width: 340.w,
                height: 40.h,
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("공휴일 휴무 여부",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: kTextBlackColor),),
                    Checkbox(
                        focusColor: kPrimaryColor,
                        checkColor: kPrimaryColor,
                        fillColor:
                        MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.orange.withOpacity(.32);
                              }
                              return Colors.grey;
                            }),
                        value: holyday,
                        onChanged: (value) {
                          setState(() {
                            holyday = value!;
                          });
                        }),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height*0.07,),


            InkWell(
                onTap: ()async{
                  if(_nameController.text == "" || _addressController.text =="" ||_areaController.text =="" ||_countController.text ==""|| _codeController.text=="" || _trainerCountController.text ==""){
                    return showtoast("정보를 모두 입력해주세요");
                  }else{
                    if(_codeController.text.length != 4){
                      return showtoast("가입코드는 숫자4자리로 입력해주세요");
                    }else{
                      final prefs = await SharedPreferences.getInstance();
                      var token = prefs.getString("token");
                      var register_gym =await GymApi().register_gym(token.toString(), _nameController.text, _addressController.text, int.parse(_countController.text), _onelineController.text, _codeController.text, _introduceController.text, _areaController.text, _trainerCountController.text);

                      if(register_gym == null){
                        return showtoast("헬스장 등록 실패");
                      }else{
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: GymRegisterView2(closedday: _selectedValue, holyday_bool: holyday,)));
                      }

                    }
                  }

                },
                child: Center(
                  child: Button("다음")
                )),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
