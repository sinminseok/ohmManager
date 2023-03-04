

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/postApi.dart';
import 'package:ohmmanager/Model/postImgDto.dart';
import 'package:ohmmanager/Utils/toast.dart';

import '../../../Model/postDto.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/permission.dart';
import '../../frame/frame_view.dart';


class Post_Edit extends StatefulWidget {
  int orign_imglength;
  PostDto postDto;

  Post_Edit({required this.postDto,required this.orign_imglength});

  @override
  _Post_Edit createState() => _Post_Edit();
}

class _Post_Edit extends State<Post_Edit> {
  TextEditingController? _titleController;
  TextEditingController? _contentController;
  List<XFile> image_picked = [];

  //삭제할 사진
  List<String?> delete_imgs = [];

  //이미지 추가
  Future<void> getImages() async {
    ImagePicker imagePicker = ImagePicker();

    List<XFile> images = await imagePicker.pickMultiImage(
        maxWidth: 640, maxHeight: 280, imageQuality: 100);

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
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController(text: widget.postDto.title);
    _contentController = TextEditingController(text: widget.postDto.content);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<PostImgDto>? postImgs = widget.postDto?.imgs;
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Row(
              children: [

                Container(width: 100.w,height: 30.h,decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                ),
                  child: InkWell(

                      onTap: ()async{
                        // print(widget.postDto.imgs.length);
                        // print(delete_imgs.length);
                        // print(image_picked.length);
                        if (widget.orign_imglength -
                            delete_imgs.length +
                            image_picked.length ==
                            0) {
                          showtoast("최소 한장 이상의 사진을 등록해야합니다.");
                        }else{
                          await PostApi().update_post(widget.postDto.id,_titleController!.text, _contentController!.text);
                          await PostApi().update_postImgs(
                              widget.postDto?.id, delete_imgs, image_picked);
                          showtoast("수정되었습니다");
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FrameView()), (route) => false);
                        }



                      },
                      child: Center(child: Text("수정하기",style: TextStyle(fontSize: 18),))),)
              ],
            )
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            postImgs?.length == 0 && image_picked.length == 0
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
                      itemCount: postImgs!.length + image_picked.length,
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

                                        if (postImgs.length >= index + 1) {
                                          delete_imgs?.add(postImgs![index]
                                              .id
                                              .toString());
                                          setState(() {
                                            postImgs
                                                ?.remove(postImgs[index]);
                                          });
                                        } else {
                                          // print(index+1 - gymImgs.length);
                                          // print(image_picked[index - gymImgs.length]);
                                          setState(() {
                                            image_picked.remove(
                                                image_picked[index -
                                                    postImgs.length]);
                                          });
                                        }
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(0),
                                          child: Icon(Icons.cancel)),
                                    )
                                  ],
                                ),
                                postImgs.length < index + 1
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
                                          postImgs.length]
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
                                      awsimg_endpoint+postImgs[index].filePath,
                                      fit: BoxFit.fitWidth,
                                    ))
                              ],
                            ),
                            index + 1 !=
                                postImgs!.length + image_picked.length
                                ? Container()
                                : InkWell(
                              onTap: () {
                                Permission_handler()
                                    .requestCameraPermission(
                                    context);
                                getImages();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 6,top: 8.h),
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
            Container(
              width: size.width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                      child: TextField(


                        controller: _titleController,
                        decoration: InputDecoration(

                          border: InputBorder.none
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 30,bottom: 50),
                      child: TextField(
                        controller: _contentController,
                        decoration: InputDecoration(

                            border: InputBorder.none
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}