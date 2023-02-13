
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/account/login_view.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class SignupView2 extends StatefulWidget {

  SignupView2({required this.name,required this.nickname,required this.password});

  String name;
  String password;
  String nickname;

  @override
  _SignupView2 createState() => _SignupView2();
}

class _SignupView2 extends State<SignupView2>
    with SingleTickerProviderStateMixin {
  final TextEditingController _onlineController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PickedFile? _image;
    var image_picked;
    double defaultLoginSize = size.height - (size.height * 0.2);

    Future getImageFromGallery() async {
      // for gallery
      image_picked =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if(mounted){
        setState(() {
          _image = image_picked!;
        });
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("프로필 정보",style: TextStyle(fontWeight: FontWeight.bold),),
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
                Center(child: SizedBox(height: size.height * 0.01)),



                image_picked != null ?Container(
                  height: size.height*0.35,
                  width: size.width*0.7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.file(
                      File(image_picked!.path),
                      fit: BoxFit.fitWidth,
                    ),
                  )
                ) : InkWell(
                  onTap: (){
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
                      borderRadius: BorderRadius.circular(15)
                  ),
                  width: 340.w,
                  child: TextFormField(
                    controller: _onlineController,
                    textAlign: TextAlign.center,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                        hintText: "한줄소개",
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
                  width: 340.w,
                  height: 100.h,
                  child: TextFormField(
                    maxLines: null,
                    controller: _introduceController,
                    textAlign: TextAlign.center,
                    cursorColor: kContainerColor,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                        hintText: "자기 소개",
                        border: InputBorder.none
                    ),
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
                      print(widget.nickname);
                      int? id = await ManagerApi().register_manager(widget.name, widget.password, widget.nickname, _onlineController.text,_introduceController.text);

                      if(id == null){
                        return showtoast("회원가입 실패");
                      }else{
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: LoginView()));
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
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18),
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
