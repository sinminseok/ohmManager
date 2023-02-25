import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/account/login_view.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Signup_Trainer2 extends StatefulWidget {
  Signup_Trainer2(
      {required this.gymId,required this.name, required this.nickname, required this.password});

  String gymId;
  String name;
  String password;
  String nickname;

  @override
  _Signup_Trainer2 createState() => _Signup_Trainer2();
}

class _Signup_Trainer2 extends State<Signup_Trainer2>
    with SingleTickerProviderStateMixin {
  final TextEditingController _onlineController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();

  PickedFile? _image;
  var image_picked;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double defaultLoginSize = size.height - (size.height * 0.2);

    Future getImageFromGallery() async {
      // for gallery
      image_picked =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      print(image_picked);
      if (mounted) {
        setState(() {
          _image = image_picked!;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kTextBlackColor, //change your color here
        ),
        title: Text(
          "프로필 정보",
          style: TextStyle(fontWeight: FontWeight.bold,color: kTextBlackColor),
        ),
        backgroundColor:   Color(0xff2651f0).withAlpha(20),
        elevation: 0,
      ),
      body: Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: SizedBox(height: size.height * 0.01)),
                _image != null
                    ? CircleAvatar(backgroundImage: new FileImage(File(image_picked!.path)), radius: 65.0,)
                    : InkWell(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage("assets/images/user.jpg"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(

                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(15)),
                  width: 340.w,
                  child: TextFormField(
                    controller: _onlineController,
                    textAlign: TextAlign.center,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                        hintText: "한줄소개",
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(

                      color: kContainerColor,
                      borderRadius: BorderRadius.circular(15)),
                  width: 340.w,
                  height: 100.h,
                  child:  TextFormField(
                    maxLines: null,
                    textInputAction:TextInputAction.done,
                    controller: _introduceController,
                    textAlign: TextAlign.center,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                        hintText: "자기 소개",
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.3,
                ),
                InkWell(
                    onTap: () async {

                      if(_introduceController.text =="" || _onlineController.text == ""){
                        showtoast("내용을 모두 입력해주세요");
                      }else{
                        int? id = await ManagerApi().register_trainer(widget.name,_onlineController.text,_introduceController.text,widget.password,widget.nickname,widget.gymId);


                        if(id == null){
                          return showtoast("이미 존재하는 아이디입니다.");
                        }else{
                          if(_image == null){
                            showtoast("회원가입 완료 로그인을 진행해주세요");
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LoginView()));
                          }else{
                            showtoast("회원가입 완료 로그인을 진행해주세요");
                            ManagerApi().register_profile(_image!,id.toString());
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LoginView()));
                          }


                        }
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Button("다음")
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
