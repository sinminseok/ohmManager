import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Provider/gymProvider.dart';
import '../../../Utils/sundry/constants.dart';
import '../../../Utils/sundry/permission.dart';
import 'gym_register4.dart';

class GymRegisterView3 extends StatefulWidget {
  @override
  _GymRegisterView3 createState() => _GymRegisterView3();
}

class _GymRegisterView3 extends State<GymRegisterView3> {
  List<XFile> image_picked = [];
  var imim;
  List<File> imageFileList = [];
  bool goodToGo = true;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();


  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage(
        maxWidth: 640, maxHeight: 280, imageQuality: 85);

    setState(() {
      image_picked = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _gymProvider = Provider.of<GymProvider>(context, listen: false);
    void _doSomething() async {
      Timer(Duration(seconds: 1), () {
        if(image_picked.length == 0){
          _btnController.stop();
          showtoast("최소 한장 이상의 사진이 필요합니다");
        }else{
          _gymProvider.register_gymImg(image_picked);
          goodToGo = false;
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: GymRegisterView4()));
          _btnController.stop();


        }
      });
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kIconColor, //change your color here
        ),
        shape: Border(
            bottom: BorderSide(
                color: Colors.black26,
                width: 0.3
            )
        ),
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 30,top: 10.h),
              child: Text(
                "헬스장 사진",
                style: TextStyle(fontFamily: "lightfont",color: kTextColor, fontSize: 18.sp,fontWeight: FontWeight.bold),
              ),
            ),
            image_picked.isNotEmpty
                ? Container()
                : InkWell(
              onTap: () {
                Permission_handler().requestCameraPermission(context);
                getImages();
              },
              child: Center(
                child: Container(
                  width: size.width * 0.9,
                  height:size.height * 0.6,
                  decoration: BoxDecoration(

                      color: kContainerColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Icon(
                    Icons.add,
                    color: kTextColor,
                    size: 35,
                  ),
                ),
              ),
            ),
            image_picked.isEmpty
                ? Container()
                : Center(
              child: Container(
                width: size.width * 0.9,

                height: size.height * 0.6,

                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: image_picked.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        width: size.width * 0.9,
                        height: size.height * 6,
                        child: Image.file(File(image_picked[index].path),fit: BoxFit.fill,),
                      );
                    }),
              ),
            ),

            SizedBox(height: size.height*0.07,),
            InkWell(
                onTap: () async {


                },
                borderRadius: BorderRadius.circular(10),
                child: RoundedLoadingButton(
                  controller: _btnController,
                  successColor: kTextBlackColor,
                  color: kTextBlackColor,
                  onPressed: _doSomething,
                  child: Container(
                    width: 330.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kButtonColor,
                    ),


                    alignment: Alignment.center,
                    child: Text(
                      "다음",
                      style: TextStyle(
                          fontFamily: "lightfont",
                          color: kTextWhiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                      ),
                    ),
                  ),
                )
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
