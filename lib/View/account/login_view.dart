import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/View/account/role_view.dart';
import 'package:ohmmanager/View/account/widget/loading_widget.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/constants.dart';
import '../../Utils/toast.dart';
import 'ceo/ceo_code.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  bool ischeck = false;
  bool goodToGo = true;
  String? colsedday;
  Future? myfuture;
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {
    final prefs = await SharedPreferences.getInstance();

    var token = await AdminApi().login_manager(
        _userIDController.text, _passwordController.text);
    if (token == null) {
      _btnController.stop();
      return showtoast("아이디 혹은 비밀번호가 틀립니다.");
    } else {
      //자동 로그인 체크시 실행
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
        _btnController.success();
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
        _btnController.success();

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: FrameView()));
      }
    }
  }
  @override
  void initState() {
   // get_logininfo();
    myfuture = get_logininfo();
    super.initState();
  }

  Future<bool> get_logininfo() async {
    final prefs = await SharedPreferences.getInstance();
    var disk_id = prefs.getString("loginId");
    var disk_pw = prefs.getString("loginPw");
    if (disk_id == null || disk_pw == null) {
      return false;
    } else {
      var token = await AdminApi().login_manager(disk_id!, disk_pw!);
      if (prefs.getString("token") == null) {
        prefs.setString("token", token.toString());
      } else {
        prefs.remove("token");
        prefs.setString("token", token.toString());
      }

      return true;

      // Navigator.push(context,
      //     PageTransition(type: PageTransitionType.fade, child: FrameView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
      //resizeToAvoidBottomInset : false,
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
          future: myfuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
            if (snapshot.hasData == false) {
              return Loading_Widget();
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            }
            // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
            else {
              return snapshot.data == true?FrameView(): Center(
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

                              SizedBox(height: 220.h),

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
                                margin: EdgeInsets.only(top: 13),
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
                                  margin: EdgeInsets.only(bottom: 20, top: 10),
                                  width: size.width * 0.4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "자동로그인",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontFamily: "lightfont",
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
                              RoundedLoadingButton(
                                width: 100.w,
                                height: 40.h,
                                controller: _btnController,
                                successColor: kTextBlackColor,
                                color: kTextBlackColor,
                                onPressed: _doSomething,
                                child: Container(
                                  width: 260.w,
                                  height: 47.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kButtonColor,
                                  ),


                                  alignment: Alignment.center,
                                  child: Text(
                                    "로그인",
                                    style: TextStyle(
                                        fontFamily: "lightfont",
                                        color: kTextWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp
                                    ),
                                  ),
                                ),
                              ),


                              Container(
                                margin: EdgeInsets.only(top: 15.h),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: CEO_CodeView()));
                                  },
                                  child: Text(
                                    "회원가입 하러가기",
                                    style: TextStyle(fontFamily: "boldfont",color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
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
              );
            }
          })

    );
  }
}
