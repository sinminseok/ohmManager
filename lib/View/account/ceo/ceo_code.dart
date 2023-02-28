
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/account/ceo/signup_ceo.dart';
import 'package:ohmmanager/View/account/manager/signup_manager.dart';
import 'package:ohmmanager/View/account/role_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/toast.dart';
import '../../../../Utils/widget/passwordinput_widget.dart';
import '../../../../Utils/widget/rouninput_widget.dart';

class CEO_CodeView extends StatefulWidget {
  const CEO_CodeView({Key? key}) : super(key: key);

  @override
  _CEO_CodeView createState() => _CEO_CodeView();
}

class _CEO_CodeView extends State<CEO_CodeView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _onlineController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  String? code;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _codeController = TextEditingController();



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kIconColor, //change your color here
        ),
        title: Text("가입코드",style: TextStyle(fontFamily: "boldfont",fontWeight: FontWeight.bold,color: kTextBlackColor),),
        backgroundColor:     Color(0xff2651f0).withAlpha(20),
        elevation: 0,

      ),

      body:    Container(

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Center(
              child: Container(
                width:size.width*0.7,
                child: PinCodeTextField(
                  cursorColor: kBackgroundColor,
                  backgroundColor: Colors.transparent,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                    disabledColor: kBackgroundColor,
                    selectedColor: Colors.transparent,
                    inactiveFillColor: kBoxColor,
                    selectedFillColor: kBoxColor,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(20),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    activeFillColor: Colors.transparent,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: _codeController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {

                    setState(() {
                      code = value;
                    });
                  },
                  beforeTextPaste: (text) {

                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  }, appContext: context,
                ),
              ),
            ),
            SizedBox(height: size.height*0.4,),

            InkWell(
                onTap: () async {
                  if(code?.length != 4){
                    showtoast("4자리를 모두 입력해주세요");

                  }else{
                    var check_code =await AdminApi().check_code(code!);
                    if(check_code == true){
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Signup_Ceo()));

                    }else{
                      return showtoast("유효하지 않은 코드 입니다.");
                    }
                  }



                },
                borderRadius: BorderRadius.circular(10),
                child: Button( "다음")
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
