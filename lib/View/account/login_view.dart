import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/View/account/code_view.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/buttom_container.dart';
import '../../Utils/constants.dart';
import '../../Utils/toast.dart';



class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool ischeck = false;
  String? colsedday;
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    get_logininfo();
    super.initState();
  }

  get_logininfo()async{
    final prefs = await SharedPreferences.getInstance();
    var disk_id = prefs.getString("loginId");
    var disk_pw = prefs.getString("loginPw");
    if(disk_id == null || disk_pw == null){
      return;
    }else{
      var token =await ManagerApi().login_manager(disk_id!, disk_pw!);
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
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          // Lets add some decorations
          // Login Form
          Container(

            width: size.width,

            child: Column(
              children: [

                // Text("오 헬 몇?",style: TextStyle(fontFamily: "boldfont",fontSize: 50,fontWeight: FontWeight.bold),),
                Container(
                  width:size.width*0.5,
                  height: size.height*0.14,
                  child: Image.asset("assets/images/main_logo.png",fit: BoxFit.fitWidth,),
                ),
                SizedBox(height: size.height * 0.27),

                Container(
                  decoration: BoxDecoration(
                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  width: 320.w,
                  child: TextFormField(
                    controller: _userIDController,
                    textAlign: TextAlign.start,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "ID",
                        border: InputBorder.none
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(

                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(15)

                  ),
                  width: 320.w,
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    textAlign: TextAlign.start,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "PW",
                        border: InputBorder.none
                    ),
                  ),
                ),



                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10,top: 20),
                    width: size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "자동로그인",

                          style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),
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

                      var token = await ManagerApi().login_manager(
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
                    child: Button("로그인")
                ),
                SizedBox(height: 30.h,),


                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: CodeView()));
                    },
                    child: Text(
                      "회원가입 하러가기",
                      style: TextStyle(
                          color: Colors.black,fontSize: 19),
                    ),
                  ),
                )
              ],
            ),
          )

          // buildRegisterContainer(size)
        ],
      ),
    );
  }
}
