import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/postApi.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/post/detailview/post_edit.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Model/postDto.dart';
import '../../../Utils/constants.dart';

class Post_Detail extends StatefulWidget {
  PostDto postDto;
  var fun;

  Post_Detail({required this.postDto,required this.fun});

  @override
  _Post_Detail createState() => _Post_Detail();
}

class _Post_Detail extends State<Post_Detail> {




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
                      var delete_post =
                          await PostApi().delete_post(widget.postDto.id);
                      if (delete_post == true) {
                        Navigator.pop(context);
                        showtoast("게시물이 삭제되었습니다.");
                      } else {
                        showtoast("삭제중 오류가 발생했습니다");
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.delete,
                          color: kPrimaryColor,
                        ))),
                InkWell(
                    onTap: () async{
                      bool isBack = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Post_Edit( postDto: widget.postDto,)));
                      if (isBack) {
                        widget.fun;
                      }
                      // await Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => Post_Edit( postDto: widget.postDto,)))
                      //     .then((value) {
                      //   setState(() {});
                      // });
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //         type: PageTransitionType.fade,
                      //         child: Post_Edit(
                      //           postDto: widget.postDto,
                      //         )));
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
            Container(
              height: 240.h,
              width: 360.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    "assets/images/gym_img.png",
                    fit: BoxFit.cover,
                  )),
            ),
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
