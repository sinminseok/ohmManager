
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/View/account/role_view.dart';
import 'package:ohmmanager/View/account/signup_trainer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class CodeView extends StatefulWidget {
  const CodeView({Key? key}) : super(key: key);

  @override
  _CodeView createState() => _CodeView();
}

class _CodeView extends State<CodeView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _onlineController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  String? code;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _codeController = TextEditingController();



    return Scaffold(
      appBar: AppBar(
        title: Text("가입코드",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: kPrimaryColor,
            body:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Center(
                  child: Container(
                    width:size.width*0.7,

                    child: PinCodeTextField(
                      cursorColor: kPrimaryColor,
                      backgroundColor: kPrimaryColor,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        activeColor: kPrimaryColor,
                        inactiveColor: kPrimaryColor,
                        disabledColor: kPrimaryColor,
                        selectedColor: kPrimaryColor,
                        inactiveFillColor: kContainerColor,
                        selectedFillColor: kContainerColor,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(20),
                        fieldHeight: 40,
                        fieldWidth: 40,
                        activeFillColor: kPrimaryColor,
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
                      var check_code =await ManagerApi().check_code(code!);
                      if(check_code == true){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: Role_View()));

                      }else{
                        return showtoast("유효하지 않은 코드 입니다.");
                      }
                    }



                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(


                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kContainerColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "다음",
                      style: TextStyle(color: kTextColor,fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
