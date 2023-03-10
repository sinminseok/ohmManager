import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/account/manager/signup_manager2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class Signup_Manager extends StatefulWidget {
  String gymId;
  Signup_Manager({required this.gymId});

  @override
  _Signup_Manager createState() => _Signup_Manager();
}

class _Signup_Manager extends State<Signup_Manager>
    with SingleTickerProviderStateMixin {
  bool goodToGo = true;
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
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
        title: Text("",style: TextStyle(fontFamily: "boldfont",fontWeight: FontWeight.bold,color: kTextBlackColor),),
        backgroundColor:  Color(0xff2651f0).withAlpha(20),
        elevation: 0,
      ),
      body:  Scaffold(
        backgroundColor:  Colors.transparent,
        body: Container(
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: SizedBox(height: size.height * 0.01)),

                Container(

                  child: RoundedInput(
                    controller: _userIDController,

                    title: "?????????", number_mode: false,
                  ),
                ),
                RoundedPasswordInput(
                  controller: _passwordController, hint: 'Password',title: "????????????",),
                RoundedPasswordInput(
                  controller: _checkpasswordController,
                  hint: 'check pw',title: "???????????? ??????",),
                Container(
                  width: 340.w,
                  height: 40.h,
                  margin: EdgeInsets.only(top: 20),




                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          showAlertDialog(context, "??????", "??????????????? ????????? ??????????????????.\n???????????? ???????????? ??????????????????");
                        },
                        child: Row(
                          children: [
                            Text("?????????",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,fontFamily: "lightfont",color: kTextBlackColor),),
                            Container(
                                margin: EdgeInsets.only(left: 8,bottom: 3),
                                child: Icon(Icons.info,color: kPrimaryColor,))
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        width: 200.w,
                        child: TextFormField(
                          controller: _nicknameController,
                          textAlign: TextAlign.center,

                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.,
                              hintText: "-",
                              border: InputBorder.none
                          ),
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
                        "??????",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: "lightfont",
                            color: kTextBlackColor),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.circular(10)),
                        width: 200.w,
                        child: TextFormField(
                          controller: _positionController,
                          textAlign: TextAlign.center,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.,
                              hintText: "ex)?????? ??????",
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),


                SizedBox(
                  height: size.height * 0.33,
                ),

                InkWell(
                    onTap: () async {
                      if(_positionController.text == ""||_userIDController.text == "" || _passwordController.text == "" || _nicknameController.text == ""){
                        return showtoast("????????? ?????? ??????????????????");
                      }else{
                        if(_passwordController.text != _checkpasswordController.text){
                          showtoast("??????????????? ???????????? ????????????.");
                        }
                        else{
                          if(_passwordController.text.length <6){
                            return showtoast("??????????????? 6?????? ???????????? ??????????????????");
                          }else{
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: SignupView2(name: _userIDController.text, nickname: _nicknameController.text, password: _passwordController.text,gymId: widget.gymId, position: _positionController.text,)));
                          }

                        }

                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Button("??????")
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      )
    );
  }
}
