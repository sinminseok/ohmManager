import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../Utils/sundry/constants.dart';
import '../../../Utils/sundry/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';
import '../login_view.dart';

class Signup_Ceo extends StatefulWidget {
  const Signup_Ceo({Key? key}) : super(key: key);

  @override
  _Signup_Ceo createState() => _Signup_Ceo();
}

class _Signup_Ceo extends State<Signup_Ceo>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _positionContrtoller = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  bool goodToGo = true;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    if (_userIDController.text == "" ||
        _passwordController.text == "" ||
        _positionContrtoller.text == "" ||
        _checkpasswordController.text == "" ||
        _nicknameController.text == "") {
      _btnController.stop();
      showtoast("모든 정보를 입력해주세요");
    } else {
      if (_passwordController.text != _checkpasswordController.text) {
        showtoast("비밀번호가 일치하지 않습니다.");
        _btnController.stop();
      } else {
        int? id = await AdminApi().register_ceo(
            _positionContrtoller.text,
            _userIDController.text,
            _passwordController.text,
            _nicknameController.text);

        if (id == null) {
          _btnController.stop();
          return showtoast("이미 존재하는 아이디입니다.");
        } else {
          _btnController.success();
          showtoast("회원가입 완료 로그인을 진행해주세요");
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: LoginView()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kTextBlackColor, //change your color here
          ),
          title: Text(
            "정보입력",
            style: TextStyle(
                fontFamily: "boldfont",
                fontWeight: FontWeight.bold,
                color: kTextBlackColor),
          ),
          backgroundColor: Color(0xff2651f0).withAlpha(20),
          elevation: 0,
        ),
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: size.height * 1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.2,
                  0.4,
                  0.2,
                  0.7
                ],
                    colors: [
                  Color(0xff2651f0).withAlpha(20),
                  Color(0xff2651f0).withAlpha(20),
                  Color(0xff2651f0).withAlpha(100),
                  Color(0xff2651f0).withAlpha(200),
                ])),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: SizedBox(height: size.height * 0.01)),
                  Container(
                    child: RoundedInput(
                      controller: _userIDController,
                      title: "아이디",
                      number_mode: false,
                    ),
                  ),
                  RoundedPasswordInput(
                    controller: _passwordController,
                    hint: 'Password',
                    title: "비밀번호",
                  ),
                  RoundedPasswordInput(
                    controller: _checkpasswordController,
                    hint: 'check pw',
                    title: "비밀번호 확인",
                  ),
                  Container(
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: kTextBlackColor,
                                    fontFamily: "lightfont"),
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
                  Container(
                    width: 340.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "직책",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: kTextBlackColor,
                              fontFamily: "lightfont"),
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
                                hintText: "ex)지점장",
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.345,
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
                          height: 47.h,
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
