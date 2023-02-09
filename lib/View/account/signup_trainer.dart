import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/constants.dart';
import '../../Utils/toast.dart';
import '../../Utils/widget/passwordinput_widget.dart';
import '../../Utils/widget/rouninput_widget.dart';

class SignupTrainer extends StatefulWidget {
  const SignupTrainer({Key? key}) : super(key: key);

  @override
  _SignupTrainer createState() => _SignupTrainer();
}

class _SignupTrainer extends State<SignupTrainer>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  late final int age;
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double defaultLoginSize = size.height - (size.height * 0.2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Scaffold(
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kBackgroundColor,
                width: size.width,
                height: size.height * 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.1),
                      Text(
                        '트레이너 회원가입',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: size.height * 0.05),
                      RoundedInput(
                          controller: _userIDController,
                          icon: Icons.mail,
                          hint: 'ID'),
                      RoundedPasswordInput(
                          controller: _passwordController, hint: 'Password'),
                      RoundedPasswordInput(
                          controller: _checkpasswordController,
                          hint: 'check pw'),
                      RoundedInput(
                          icon: Icons.person_outline,
                          controller: _nicknameController,
                          hint: '이름'),
                      RoundedInput(
                          controller: _codeController,
                          icon: Icons.numbers,
                          hint: '가입번호'),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          var gymId = await GymApi().check_code("1234");
                          if (gymId == null) {
                            showtoast("유효하지 않은 가입코드입니다.");
                          } else {
                            var userId = await ManagerApi().register_trainer(
                                _userIDController.text,
                                _passwordController.text,
                                _nicknameController.text,
                                gymId.toString());
                            if(userId == null){
                              showtoast("회원가입 오류 다시 시도해주세요");
                            }else{
                              showtoast("회원가입 성공");
                              return Navigator.pop(context);
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "가입 하기",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
