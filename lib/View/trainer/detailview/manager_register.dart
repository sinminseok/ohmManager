import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/adminApi.dart';
import '../../../Utils/widget/buttom_container.dart';
import '../../../Utils/sundry/constants.dart';
import '../../../Utils/sundry/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class Manager_Register extends StatefulWidget {
  String role;

  Manager_Register({required this.role});

  @override
  State<Manager_Register> createState() => _Manager_RegisterState();
}

class _Manager_RegisterState extends State<Manager_Register> {
  final TextEditingController _positionContrtoller = TextEditingController();
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  bool goodToGo = true;

  void _doSomething() async {
    final prefs = await SharedPreferences.getInstance();
    goodToGo = true;
    int? id;
    if (_positionContrtoller.text == "" ||
        _userIDController.text == "" ||
        _passwordController.text == "" ||
        _nicknameController.text == "" ||
        _positionContrtoller.text == "") {
      showtoast("모든 정보를 입력해주세요");
      _btnController.stop();
    } else {
      if (_passwordController.text != _checkpasswordController.text) {
        showtoast("비밀번호가 일치하지 않습니다.");
        _btnController.stop();
      } else {
        if (widget.role == "manager") {
          id = await AdminApi().register_manager(
              _positionContrtoller.text,
              _userIDController.text,
              _passwordController.text,
              _nicknameController.text,
              prefs.getString("gymId").toString());
        } else {
          id = await AdminApi().register_trainer(
              _positionContrtoller.text,
              _userIDController.text,
              _passwordController.text,
              _nicknameController.text,
              prefs.getString("gymId").toString());
        }

        if (id == null) {
          _btnController.stop();
          return showtoast("이미 존재하는 아이디입니다.");
        } else {
          _btnController.success();
          showtoast("계정이 등록 되었습니다.");

          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: FrameView()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h),
          child: AppBar(
            iconTheme: IconThemeData(
              color: kTextBlackColor, //change your color here
            ),
            backgroundColor: kBackgroundColor,
            elevation: 0,
            title: Container(
              child: widget.role == "manager"?Container(

                  margin: EdgeInsets.only(left: 10.w,top: 5.h),
                  child: Text("직원 등록",style: TextStyle(color: kTextBlackColor,fontSize: 18.sp,fontFamily: "lightfont",fontWeight: FontWeight.bold),)):Text("트레이너 등록",style: TextStyle(color: kTextBlackColor,fontSize: 18.sp,fontFamily: "lightfont",fontWeight: FontWeight.bold),),
            ),
          ),
        ),
        body: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Container(
            margin: EdgeInsets.only(top: 15.h),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.3,color: Colors.grey)
              ),
            ),
            height: size.height * 1,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: SizedBox(height: size.height * 0.01)),
                  Center(
                    child: Container(
                      child: RoundedInput(
                        controller: _userIDController,
                        title: "아이디",
                        number_mode: false,
                      ),
                    ),
                  ),
                  Center(
                    child: RoundedPasswordInput(
                      controller: _passwordController,
                      hint: 'Password',
                      title: "비밀번호",
                    ),
                  ),
                  Center(
                    child: RoundedPasswordInput(
                      controller: _checkpasswordController,
                      hint: 'check pw',
                      title: "비밀번호 확인",
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 340.w,
                      height: 40.h,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showAlertDialog(context, "알림",
                                  "회원들에게 노출될 닉네임입니다.\n실명또는 닉네임을 기재해주세요");
                            },
                            child: Row(
                              children: [
                                Text(
                                  "닉네임",
                                  style: TextStyle(
                                      fontFamily: "lightfont",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: kTextBlackColor),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 8, bottom: 3),
                                    child: Icon(
                                      Icons.info,
                                      color: kPrimaryColor,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200.w,
                            child: TextFormField(
                              controller: _nicknameController,
                              textAlign: TextAlign.center,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.,
                                  hintText: "-",
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 340.w,
                      height: 40.h,
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "직책",
                            style: TextStyle(
                                fontFamily: "lightfont",
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: kTextBlackColor),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200.w,
                            child: TextFormField(
                              controller: _positionContrtoller,
                              textAlign: TextAlign.center,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.,
                                  hintText: widget.role=="manager"?"ex)일반직원": "ex)트레이너",
                                  border: InputBorder.none),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.3,
                  ),
                  InkWell(
                      onTap: () async {},
                      borderRadius: BorderRadius.circular(10),
                      child: RoundedLoadingButton(
                        controller: _btnController,
                        successColor: kTextBlackColor,
                        color: kTextBlackColor,
                        onPressed: _doSomething,
                        child: Container(
                          width: 330.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kButtonColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "다음",
                            style: TextStyle(
                                fontFamily: "lightfont",
                                color: kTextWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp),
                          ),
                        ),
                      )),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
