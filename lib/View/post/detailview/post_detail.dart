import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/postApi.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:ohmmanager/View/post/detailview/post_edit.dart';
import 'package:ohmmanager/View/post/popup/delete_popup.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Model/postDto.dart';
import '../../../Utils/constants.dart';

class Post_Detail extends StatefulWidget {
  PostDto postDto;
  Post_Detail({required this.postDto});

  @override
  State<Post_Detail> createState() => _Post_DetailState();
}

class _Post_DetailState extends State<Post_Detail> {
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Row(
              children: [
                InkWell(
                    onTap: () async {
                      DeletePost_Popup()
                          .showDialog(size, context, widget.postDto.id);
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.delete,
                          color: kPrimaryColor,
                        ))),
                InkWell(
                    onTap: () async {
                      bool isBack = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Post_Edit(
                                    postDto: widget.postDto, orign_imglength: widget.postDto.imgs.length,
                                  )));
                      if (isBack) {}
                    },
                    child: Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                    ))
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.postDto.imgs.length == 0
                ? Container()
                : Container(
              width: 360.w,
              height: 340.h,

              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.postDto.imgs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 340.h,
                      width: 360.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: Image.network(
                            awsimg_endpoint + widget.postDto.imgs[index].filePath,
                            fit: BoxFit.fill
                          )),
                    );
                  }),),


            Container(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        "${widget.postDto.title}",
                        style: TextStyle(fontSize: 30),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 50),
                      child: Text(
                        "${widget.postDto.content}",
                        style: TextStyle(fontSize: 30),
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
