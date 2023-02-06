import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Controller/ManagerApiController.dart';
import 'package:ohmmanager/View/account/signup_view.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';
import '../../Utils/toast.dart';
import '../../Utils/widget/button_widget.dart';
import '../../Utils/widget/passwordinput_widget.dart';
import '../../Utils/widget/rouninput_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool ischeck = false;
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  get_logininfo()async{
    final prefs = await SharedPreferences.getInstance();
    var disk_id = prefs.getString("loginId");
    var disk_pw = prefs.getString("loginPw");
    if(disk_id == null || disk_pw == null){
      return;
    }else{
      var token =await ManagerApiController().login_manager(disk_id!, disk_pw!);
      if (prefs.getString("token") == null) {
        prefs.setString("token", token.toString());
      } else {
        prefs.remove("token");
        prefs.setString("token", token.toString());
      }

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: FrameView()));
    }


  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Lets add some decorations
            // Login Form
            Container(
              color: kBackgroundColor,
              width: size.width,
              height: size.height * 1,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  // Text("오 헬 몇?",style: TextStyle(fontFamily: "boldfont",fontSize: 50,fontWeight: FontWeight.bold),),
                  Container(
                    child: Image.asset("assets/images/main_text.png"),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "센터 관리자만 로그인 할수있습니다",
                      style: TextStyle(fontFamily: "boldfont", fontSize: 18),
                    ),
                  ),
                  RoundedInput(
                      controller: _userIDController,
                      icon: Icons.person,
                      hint: 'ID'),
                  RoundedPasswordInput(
                      controller: _passwordController, hint: 'Password'),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: size.width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "자동로그인",
                            style: TextStyle(fontSize: 14),
                          ),
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
                              value: ischeck,
                              onChanged: (value) {
                                setState(() {
                                  ischeck = value!;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      var token = await ManagerApiController().login_manager(
                          _userIDController.text, _passwordController.text);
                      if (token == null) {
                        return showtoast("로그인 실패");
                      } else {
                        if (ischeck == true) {
                          prefs.setString("loginId", _userIDController.text);
                          prefs.setString("loginPw", _passwordController.text);
                          if (prefs.getString("token") == null) {
                            prefs.setString("token", token.toString());
                          } else {
                            prefs.remove("token");
                            prefs.setString("token", token.toString());
                          }

                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FrameView()));
                        } else {
                          if (prefs.getString("token") == null) {
                            prefs.setString("token", token.toString());
                          } else {
                            prefs.remove("token");
                            prefs.setString("token", token.toString());
                          }

                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: FrameView()));
                        }
                      }
                    },
                    child: RoundedButton(
                      id_controller: _userIDController,
                      pw_controller: _passwordController,
                      title: 'LOGIN',
                      check_pw_controller: null,
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.045,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: SignupView()));
                      },
                      child: Text(
                        "회원가입 하러가기",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )

            // buildRegisterContainer(size)
          ],
        ),
      ),
    );
  }
}
