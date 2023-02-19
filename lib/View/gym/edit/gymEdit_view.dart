
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/gymImgDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/View/home/widget/gymInfo_widget.dart';

import '../../../Utils/permission.dart';
import '../widget/gymEdit_widget.dart';

class GymEdit_View extends StatefulWidget {
  GymDto? gymDto;

  GymEdit_View({required this.gymDto});

  @override
  _GymEdit_ViewState createState() => _GymEdit_ViewState();
}

class _GymEdit_ViewState extends State<GymEdit_View> {

  List<XFile> image_picked = [];
  var imim;
  List<File> imageFileList = [];

  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage(
        maxWidth: 640, maxHeight: 280, imageQuality: 100);

    setState(() {
      image_picked = images;
    });
  }
  List<String?> delete_imgs =[];

  @override
  Widget build(BuildContext context) {
    List<GymImgDto>? gymImgs = widget.gymDto?.imgs;

    TextEditingController _nameController =
        TextEditingController(text: widget.gymDto?.name);
    TextEditingController _addressController =
        TextEditingController(text: widget.gymDto?.address);
    TextEditingController _onelineController =
        TextEditingController(text: widget.gymDto?.oneline_introduce);
    TextEditingController _introduceController =
    TextEditingController(text: widget.gymDto?.introduce);
    TextEditingController _trainerCountController =
    TextEditingController(text: widget.gymDto?.trainer_count.toString());
    TextEditingController _codeController =
    TextEditingController(text: widget.gymDto?.code.toString());
    TextEditingController _countController =
    TextEditingController(text: widget.gymDto?.count.toString());



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        elevation: 0,
        backgroundColor: kBackgroundColor,

      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: 360.w,
              height: 180.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: gymImgs?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [

                            Row(
                              children: [
                                Container(
                                  width: 300.w,
                                ),
                                GestureDetector(
                                  onTap: () {


                                    delete_imgs?.add(gymImgs![index].id.toString());
                                    setState(() {
                                      gymImgs?.remove(gymImgs[index]);
                                    });

                                    //delete_imgs.add(;
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(0),
                                      child: Icon(Icons.cancel)),
                                )
                              ],
                            ),
                            Container(
                                width: 300.w,
                                height: 140.h,
                                margin: EdgeInsets.all(6),

                                child:
                                Image.asset("assets/images/gym_img.png",fit: BoxFit.fitWidth,)),
                          ],
                        ),

                        index+1 == gymImgs?.length?Row(
                          children: [
                            image_picked.length==0?Container():Container(
                              width: 300.w,

                              height: 140.h,
                              margin: EdgeInsets.only(top: 10.h,right: 10.w),

                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: image_picked.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      width: 300.w,
                                      height: 140.h,
                                      child: Image.file(File(image_picked[index].path,),fit: BoxFit.fitHeight,),
                                    );
                                  }),
                            ),
                            InkWell(

                              onTap: (){
                                Permission_handler().requestCameraPermission(context);
                                getImages();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                width: 300.w,
                                height: 140.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: kContainerColor
                                ),
                                child: Center(
                                  child: Icon(Icons.add_circle_outline,color: Colors.grey.shade500,),
                                ),
                              ),
                            )
                          ],
                        ):Container()

                      ],
                    );
                  }),
            ),
            GymEdit_Widget("헬스장 이름", widget.gymDto?.name, _nameController),
            GymEdit_Widget("헬스장 주소", widget.gymDto?.name, _addressController),
            GymEdit_Widget("헬스장 한줄소개", widget.gymDto?.name, _onelineController),
            GymEdit_Widget("헬스장 소개", widget.gymDto?.name, _introduceController),
            GymEdit_Widget("트레이너 가입코드", widget.gymDto?.code.toString(), _codeController),
            GymEdit_Widget("트레이너 인원", widget.gymDto?.count.toString(), _trainerCountController),
            GymEdit_Widget("회원수", widget.gymDto?.count.toString(), _countController),
            InkWell(
                onTap: (){

                  GymApi().update_gymInfo(widget.gymDto?.id, _nameController.text, _addressController.text, int.parse(_countController.text), _onelineController.text, _introduceController.text, int.parse(_trainerCountController.text), int.parse(_codeController.text));

                  GymApi().update_gymImgs(widget.gymDto?.id, delete_imgs, image_picked);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20,bottom: 40),
                    child: Button("수정하기")))
          ],
        ),
      ),
    );
  }
}
