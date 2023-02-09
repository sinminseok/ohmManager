
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/constants.dart';
import '../../../Utils/gyminput.dart';
import '../../../Utils/permission.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class GymRegisterView3 extends StatefulWidget {


  @override
  _GymRegisterView3 createState() => _GymRegisterView3();
}

class _GymRegisterView3 extends State<GymRegisterView3> {
  List<XFile> image_picked = [];
  var imim;
  List<File> imageFileList = [];

  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage(maxWidth: 640, maxHeight: 280, imageQuality: 100);

    setState(() {
      image_picked = images;
    });

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  Permission_handler().requestCameraPermission(context);
                  getImages();
                },
                child: Text("이미지 선택")),

            Container(
              height: size.height * 0.35,
              width: size.width * 1,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white12,
                    style: BorderStyle.solid,
                    width: 0),
              ),
              child: Center(
                child: image_picked.isEmpty
                    ? Container(
                  child: Text("선택된 이미지가 ㅇ벗습니다."),
                )
                    : Center(
                      child: Container(
                  height: 400,

                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: image_picked.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: size.width*0.7,
                            height: size.height*0.3,
                            child:Image.file(File(image_picked[index].path)),
                          );
                        }),
                ),
                    ),
              ),
            ),



            InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  var gymId = await prefs.getString("gymId");
                  var bool =await GymApi().save_gymimg(prefs.getString("token").toString(),gymId!,image_picked);
                  print(bool);
                  if(bool == true){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: FrameView()));
                  }else{
                    showtoast("이미지 등록 실패");
                  }



                  },
                child: Text("다음",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),)),
          ],
        ),
      ),
    );
  }
}
