import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';
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
          backgroundColor: kBackgroundColor,
          iconTheme: IconThemeData(
            color: kTextColor, //change your color here
          ),
          title: Text("글 작성",style: TextStyle(color: kTextBlackColor,fontWeight: FontWeight.bold),),

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
                          child: Image.file(File(image_picked[index].path),fit: BoxFit.fitWidth,),
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
                    var save_post =await PostApi().save_post(_titleController.text,_contentController.text,prefs.getString("gymId").toString(),prefs.getString("token").toString());
                    var save_postimg = await PostApi().save_postimg(save_post.toString(), image_picked, prefs.getString("token").toString());

                    if(save_post == null){
                      return showtoast("서버가 원활하지 않습니다");
                    }else{
                      showtoast("글이 등록었습니다!");
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FrameView()), (route) => false);
                    }

                    }
                  ,
                  child: Button("게시"))
            ],
          ),
        ));
  }
}
