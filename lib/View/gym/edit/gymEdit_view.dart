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
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:ohmmanager/View/home/widget/gymInfo_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/permission.dart';
import '../widget/gymEdit_widget.dart';

class GymEdit_View extends StatefulWidget {
  GymDto? gymDto;
  int orign_imglength;

  GymEdit_View({required this.gymDto, required this.orign_imglength});

  @override
  _GymEdit_ViewState createState() => _GymEdit_ViewState();
}

class _GymEdit_ViewState extends State<GymEdit_View> {
  List<XFile> image_picked = [];

  //삭제할 사진
  List<String?> delete_imgs = [];

  //이미지 추가
  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage(
        maxWidth: 640, maxHeight: 280, imageQuality: 70);

    for (int i = 0; i < images.length; i++) {
      setState(() {
        image_picked.add(images[i]);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    image_picked = [];
    delete_imgs = [];
    super.dispose();
  }

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
            gymImgs?.length == 0 && image_picked.length == 0
                ? Container(
                    width: 330.w,
                    height: 170.h,
                    child: InkWell(
                      onTap: () {
                        Permission_handler().requestCameraPermission(context);
                        getImages();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        width: 300.w,
                        height: 140.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: kContainerColor),
                        child: Center(
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      Container(
                        width: 360.w,
                        height: 180.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: gymImgs!.length + image_picked.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                              // print(gymImgs.length);
                                              // print(index+1);

                                              if (gymImgs.length >= index + 1) {
                                                delete_imgs?.add(gymImgs![index]
                                                    .id
                                                    .toString());
                                                setState(() {
                                                  gymImgs
                                                      ?.remove(gymImgs[index]);
                                                });
                                              } else {
                                                // print(index+1 - gymImgs.length);
                                                // print(image_picked[index - gymImgs.length]);
                                                setState(() {
                                                  image_picked.remove(
                                                      image_picked[index -
                                                          gymImgs.length]);
                                                });
                                              }
                                            },
                                            child: Container(
                                                margin: EdgeInsets.all(0),
                                                child: Icon(Icons.cancel)),
                                          )
                                        ],
                                      ),
                                      gymImgs.length < index + 1
                                          ? Container(
                                              margin: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              width: 300.w,
                                              height: 140.h,
                                              child: Image.file(
                                                File(
                                                  image_picked[index -
                                                          gymImgs.length]
                                                      .path,
                                                ),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            )
                                          : Container(
                                              width: 300.w,
                                              height: 140.h,
                                              margin: EdgeInsets.all(6),
                                              //추후 gym_img[index] 로변경
                                              child: Image.network(
                                                awsimg_endpoint +
                                                    gymImgs[index].filePath,
                                                fit: BoxFit.fitWidth,
                                              ))
                                    ],
                                  ),
                                  index + 1 !=
                                          gymImgs!.length + image_picked.length
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Permission_handler()
                                                .requestCameraPermission(
                                                    context);
                                            getImages();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 6, top: 8.h),
                                            width: 300.w,
                                            height: 127.h,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: kContainerColor),
                                            child: Center(
                                              child: Icon(
                                                Icons.add_circle_outline,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
            GymEdit_Widget(
                "헬스장 이름", widget.gymDto?.name, _nameController, false),
            GymEdit_Widget(
                "헬스장 주소", widget.gymDto?.name, _addressController, false),
            GymEdit_Widget(
                "헬스장 한줄소개", widget.gymDto?.name, _onelineController, false),
            GymEdit_Widget(
                "헬스장 소개", widget.gymDto?.name, _introduceController, false),
            InkWell(
              onTap: (){
                showtoast("가입코드는 수정할 수 없습니다.\n고객센터에 문의해주세요");
              },
              child: Container(
                width: 360.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20, bottom: 15, top: 20),
                        child: Text(
                          "가입코드",
                          style: TextStyle(
                              fontSize: 19,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      width: 360.w,
                      height: 70.h,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          color: kContainerColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 25.h, bottom: 20, left: 20, right: 20),
                          child: Text("${widget.gymDto?.code}")),
                    ),
                  ],
                ),
              ),
            ),
            GymEdit_Widget(
                "회원수", widget.gymDto?.count.toString(), _countController, true),
            InkWell(
                onTap: () {
                  if (_codeController.text != 6) {
                    showtoast("가입코드는6자리로 설정해주세요!");
                  }

                  if (widget.orign_imglength -
                          delete_imgs.length +
                          image_picked.length ==
                      0) {
                    showtoast("최소 한장 이상의 사진을 등록해야합니다.");
                  } else {
                    GymApi().update_gymInfo(
                        widget.gymDto?.id,
                        _nameController.text,
                        _addressController.text,
                        int.parse(_countController.text),
                        _onelineController.text,
                        _introduceController.text,
                        int.parse(_trainerCountController.text),
                        int.parse(_codeController.text));

                    GymApi().update_gymImgs(
                        widget.gymDto?.id, delete_imgs, image_picked);

                    showtoast("정보가 수정되었습니다.");
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: FrameView()));
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 40),
                    child: Button("수정하기")))
          ],
        ),
      ),
    );
  }
}
