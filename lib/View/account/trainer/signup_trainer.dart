import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/account/trainer/signup_trainer2.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class Signup_Trainer extends StatefulWidget {
  String gymId;

  Signup_Trainer({required this.gymId});

  @override
  _Signup_Trainer createState() => _Signup_Trainer();
}

class _Signup_Trainer extends State<Signup_Trainer>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

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
            style:
                TextStyle(fontWeight: FontWeight.bold, color: kTextBlackColor),
          ),
          backgroundColor: Color(0xff2651f0).withAlpha(20),
          elevation: 0,
        ),
        body: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
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
            height: size.height * 1,
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
                    child: RoundedInput(
                      controller: _nicknameController,
                      number_mode: false,
                      title: "이름",
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.4,
                  ),
                  InkWell(
                      onTap: () async {
                        if (_userIDController.text == "" ||
                            _passwordController.text == "" ||
                            _nicknameController.text == "") {
                          return showtoast("정보를 모두 입력해주세요");
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Signup_Trainer2(
                                    name: _userIDController.text,
                                    nickname: _nicknameController.text,
                                    password: _passwordController.text,
                                    gymId: widget.gymId,
                                  )));
                        }
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Button("다음")),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ));
  }
}
