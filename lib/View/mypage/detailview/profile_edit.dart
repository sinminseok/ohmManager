import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/constants.dart';

class Profile_Edit extends StatefulWidget {
  TrainerDto user;
  GymDto gymDto;

  Profile_Edit({required this.user, required this.gymDto});

  @override
  _Profile_EditState createState() => _Profile_EditState();
}

class _Profile_EditState extends State<Profile_Edit> {
  PickedFile? _image;
  var image_picked;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nickNameController =
        TextEditingController(text: widget.user.nickname);
    final TextEditingController _onlineController =
        TextEditingController(text: widget.user.oneline_introduce);
    final TextEditingController _introduceController =
        TextEditingController(text: widget.user.introduce);
    final TextEditingController _positionController =
        TextEditingController(text: widget.user.position);

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: AppBar(
          iconTheme: IconThemeData(
            color: kIconColor, //change your color here
          ),
          backgroundColor: kBackgroundColor,
          shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 20.h),
              child: Text(
                "프로필 정보",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18.sp,
                    fontFamily: "boldfont"),
              ),
            ),
            Center(
              child: Container(
                width: 340.w,
                height: 120.h,
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    _image != null
                        ? Container(
                            margin: EdgeInsets.only(left: 20.w),
                            child: CircleAvatar(
                              backgroundImage:
                                  new FileImage(File(image_picked!.path)),
                              radius: 43.0,
                            ),
                          )
                        : widget.user.profile != null
                            ? Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: CircleAvatar(
                                    radius: 43,
                                    backgroundImage: NetworkImage(
                                        awsimg_endpoint + widget.user.profile!),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 20.w),
                                child: InkWell(
                                  onTap: () {
                                    getImageFromGallery();
                                  },
                                  child: CircleAvatar(
                                    radius: 43,
                                    backgroundImage:
                                        AssetImage("assets/images/user.jpg"),
                                  ),
                                ),
                              ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200.w,
                          margin: EdgeInsets.only(left: 20.w, top: 10.h),
                          child: TextFormField(
                            controller: _nickNameController,
                            textAlign: TextAlign.start,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                                // contentPadding: EdgeInsets.,
                                hintText: "이름",
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          width: 200.w,
                          margin: EdgeInsets.only(top: 7.h, left: 20.w),
                          child: Text(
                            "${widget.gymDto.name}",
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 20.h),
              child: Text(
                "직책",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18.sp,
                    fontFamily: "boldfont"),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 340.w,
                child: TextFormField(
                  controller: _positionController,
                  textAlign: TextAlign.center,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                      hintText: "한줄소개",
                      border: InputBorder.none),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15.w, top: 20.h),
              child: Text(
                "소개 정보",
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18.sp,
                    fontFamily: "boldfont"),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 340.w,
                child: TextFormField(
                  controller: _onlineController,
                  textAlign: TextAlign.center,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                      hintText: "한줄소개",
                      border: InputBorder.none),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 340.w,
                height: 100.h,
                child: TextFormField(
                  maxLines: null,
                  controller: _introduceController,
                  textAlign: TextAlign.center,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.,
                      hintText: "자기 소개",
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              height: 70.h,
            ),
            InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await AdminApi().update_admin(
                      _positionController.text,
                      prefs.getString("token").toString(),
                      widget.user!.id,
                      _nickNameController.text,
                      _onlineController.text,
                      _introduceController.text,
                      widget.user.name.toString());
                  if (_image == null) {
                    showtoast("프로필이 수정되었습니다.");
                    Navigator.pop(context, true);
                  } else {
                    await AdminApi().update_profile(
                        prefs.getString("token").toString(),
                        _image!,
                        widget.user.id.toString());
                    showtoast("프로필이 수정되었습니다.");
                    Navigator.pop(context, true);
                  }
                },
                child: Center(child: Button("수정")))
          ],
        ),
      ),
    );
  }
}
