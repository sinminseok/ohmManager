import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/permission.dart';
import '../../../Controller/postApi.dart';

class PostWrite_View extends StatefulWidget {
  const PostWrite_View({Key? key}) : super(key: key);

  @override
  _PostWrite_View createState() => _PostWrite_View();
}

class _PostWrite_View extends State<PostWrite_View> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> image_picked = [];


  PickedFile? _image;
  var imim;
  List<File> imageFileList = [];


  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage();

    setState(() {
      image_picked=images;
    });

  }

  //이미지 Uint8 변환 함수
  convert_img() async {
    Uint8List test = await _image!.readAsBytes();
    imim = test;
    return test;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(
            color: kTextColor, //change your color here
          ),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.3
              )
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15.h,right: 240.w),
                child: Text(
                  "글 작성",
                  style: TextStyle(fontSize: 21,color: kTextColor,fontWeight: FontWeight.bold),
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
                    margin: EdgeInsets.all(10),
                    width: size.width * 0.9,
                    height: size.height * 0.34,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
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
                  margin: EdgeInsets.all(10),
                  width: size.width * 0.9,
                  height: size.height * 0.34,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: image_picked.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: size.width * 0.9,
                          height: size.height * 0.2,
                          child: Image.file(File(image_picked[index].path),fit: BoxFit.fitHeight,),
                        );
                      }),
                ),
              ),


              Container(
                  height: size.height * 0.08,
                  child: TextField(
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, top: 20),
                        hintText: "글 제목",
                        hintStyle:
                            TextStyle(fontFamily: "gilogfont", fontSize: 21),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                        ),
                      ))),
              Container(
                  height: size.height * 0.24,
                  child: TextField(
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      controller: _contentController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, top: 20),
                        hintText: "내용...",
                        hintStyle:
                            TextStyle(fontFamily: "gilogfont", fontSize: 21),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                        ),
                      ))),
              InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    var save_post =await PostApi().save_post(_titleController.text,_contentController.text,"2",prefs.getString("token").toString());
                    PostApi().save_postimg(save_post.toString(), image_picked, prefs.getString("token").toString());
                  },
                  child: Button("게시"))
            ],
          ),
        ));
  }
}
