
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/GymApiControllerr.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/gyminput.dart';
import '../../../Utils/permission.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class GymRegisterView2 extends StatefulWidget {
  const GymRegisterView2({Key? key}) : super(key: key);

  @override
  _GymRegisterView2 createState() => _GymRegisterView2();
}

class _GymRegisterView2 extends State<GymRegisterView2> {
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                    : Container(
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

            InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  GymApiController().save_gymimg(prefs.getString("token").toString(),"2",image_picked);
                },
                child: Text("센터 이미지등록")),
          ],
        ),
      ),
    );
  }
}
