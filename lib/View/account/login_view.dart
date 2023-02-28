import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/View/account/manager/manager_code.dart';
import 'package:ohmmanager/View/account/role_view.dart';
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

  get_logininfo() async {
    final prefs = await SharedPreferences.getInstance();
    var disk_id = prefs.getString("loginId");
    var disk_pw = prefs.getString("loginPw");
    if (disk_id == null || disk_pw == null) {
      return;
    } else {
      var token = await AdminApi().login_manager(disk_id!, disk_pw!);
      if (prefs.getString("token") == null) {
        prefs.setString("token", token.toString());
      } else {
        prefs.remove("token");
        prefs.setString("token", token.toString());
      }

      Navigator.push(context,
          PageTransition(type: PageTransitionType.fade, child: FrameView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      //resizeToAvoidBottomInset : false,
      backgroundColor: kBackgroundColor,
      body: Center(
        child: Container(
          height: size.height*1,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lets add some decorations
                // Login Form

                Container(
                    margin: EdgeInsets.only(left: 10.w,top: 80.h),
                    child: Text("오헬몇? 관리자용 어플입니다.",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 21.sp,fontFamily: "boldfont"),)),
                Container(
                    margin: EdgeInsets.only(left: 10.w,top: 5.h),
                    child: Text("제휴센터가 아니라면 상담을 신청해주세요!",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15.sp,fontFamily: "lightfont"),)),
                InkWell(
                  onTap: ()async{
                    const number = '01083131764'; //set the number here
                    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 12.w,top: 10.h),
                          child: Text("제휴 상담 신청하기 ",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 19.sp,color: kPrimaryColor,fontFamily: "boldfont"),)),
                      Container(
                        margin: EdgeInsets.only(left: 10.w,top: 13.h),
                        child: Icon(Icons.east,color: kPrimaryColor,),
                      )
                    ],
                  ),
                ),
                Container(

                  width: size.width,
                  child: Column(
                    children: [
                      // Text("오 헬 몇?",style: TextStyle(fontFamily: "boldfont",fontSize: 50,fontWeight: FontWeight.bold),),

                      SizedBox(height: 200.h),

                      Container(


                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: 250.w,
                        height: 40.h,
                        child: TextFormField(
                          controller: _userIDController,
                          textAlign: TextAlign.start,
                          cursorColor: kContainerColor,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: "ID",
                              border: InputBorder.none),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: 250.w,
                        height: 40.h,
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          textAlign: TextAlign.start,
                          cursorColor: kContainerColor,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: "PW",
                              border: InputBorder.none),
                        ),
                      ),

                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10, top: 20),
                          width: size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "자동로그인",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kTextWhiteColor),
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

                            var token = await AdminApi().login_manager(
                                _userIDController.text, _passwordController.text);
                            if (token == null) {
                              return showtoast("아이디 혹은 비밀번호가 틀립니다.");
                            } else {
                              if (ischeck == true) {
                                prefs.setString("loginId", _userIDController.text);
                                prefs.setString(
                                    "loginPw", _passwordController.text);
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
                          child: Container(
                            width: 250.w,
                            height: 37.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kButtonColor
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "로그인",
                              style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )),
                      SizedBox(
                        height: 30.h,
                      ),

                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Role_View()));
                          },
                          child: Text(
                            "회원가입 하러가기",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
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
        ),
      ),
    );
  }
}
