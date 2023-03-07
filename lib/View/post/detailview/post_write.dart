import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/permission.dart';
import '../../../Controller/postApi.dart';
import '../../frame/frame_view.dart';

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
  bool goodToGo = true;
  PickedFile? _image;
  var imim;
  List<File> imageFileList = [];

  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage( imageQuality: 50);

    setState(() {
      image_picked = images;
    });
  }

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {

    if(_titleController.text == "" || _contentController.text ==""){
      _btnController.stop();
      showtoast("제목,내용은 필수 항목입니다");

    }else{
      if(!goodToGo){return;}
      if(goodToGo){debugPrint("Going to the moon!");}// do your thing
      goodToGo = false;

      Future.delayed(const Duration(milliseconds: 5000), () async{
        goodToGo = true;
        final prefs = await SharedPreferences.getInstance();
        var save_post = await PostApi().save_post(
            _titleController.text,
            _contentController.text,
            prefs.getString("gymId").toString(),
            prefs.getString("token").toString());
        var save_postimg = await PostApi().save_postimg(
            save_post.toString(),
            image_picked,
            prefs.getString("token").toString());

        if (save_post == null) {
          _btnController.stop();
          return showtoast("서버가 원활하지 않습니다");
        } else {
          _btnController.success();
          showtoast("글이 등록었습니다!");

          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => FrameView()),
                  (route) => false);
        }
      });

    }



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
          backgroundColor: kBackgroundColor,
          iconTheme: IconThemeData(
            color: kTextColor, //change your color here
          ),
          title: Text(
            "",
            style:
                TextStyle(color: kTextBlackColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              image_picked.isNotEmpty
                  ? Container()
                  : InkWell(
                      onTap: () {
                        Permission_handler().requestCameraPermission(context);
                        getImages();
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          width: size.width * 0.9,
                          height: size.height * 0.34,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                width: size.width * 0.9,
                                height: size.height * 0.2,
                                child: Image.file(
                                  File(image_picked[index].path),
                                  fit: BoxFit.fill,
                                ),
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
                        hintText: "제목",
                        hintStyle:
                            TextStyle(fontFamily: "lightfont", fontSize: 21),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                        ),
                      ))),
              Container(
                  height: 200.h,
                  child: TextField(
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      controller: _contentController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20, top: 20),
                        hintText: "내용",
                        hintStyle:
                            TextStyle(fontFamily: "lightfont", fontSize: 21),
                        border: InputBorder.none,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 10),
                        ),
                      ))),
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
                      height: 47.h,
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




            ],
          ),
        ));
  }
}
