import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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

    // if ((images ?? []).isNotEmpty) {
    //   //get the path of the first image from the select images
    //   String imagePath = images?.first.path ?? '';
    //
    //   //get the content of the first image from the select images as bytes
    //   Uint8List? imageAsBytes = await images?.first.readAsBytes();
    //
    //   //get the content of the first image from the select images as a String based on a given encoding
    //   String? imageAsString = await images?.first.readAsString();
    // }
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
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "글 작성",
                style: TextStyle(fontSize: 30),
              ),
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
                      ? Container()
                      : Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: image_picked.length,
                        itemBuilder: (BuildContext context, int index) {

                          return Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(image_picked[index].path))
                              )
                            ),
                          );
                        }),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
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
                  height: size.height * 0.08,
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
                  child: Text("글 작성 클릭!"))
            ],
          ),
        ));
  }
}
