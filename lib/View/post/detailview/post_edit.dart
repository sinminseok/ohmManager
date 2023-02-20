

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/postApi.dart';

import '../../../Model/postDto.dart';
import '../../../Utils/constants.dart';


class Post_Edit extends StatefulWidget {

  PostDto postDto;

  Post_Edit({required this.postDto});

  @override
  _Post_Edit createState() => _Post_Edit();
}

class _Post_Edit extends State<Post_Edit> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _titleController = TextEditingController(text: widget.postDto.title);
    TextEditingController _contentController = TextEditingController(text: widget.postDto.content);

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
                        print(widget.postDto.id);
                        print("object");
                        await PostApi().update_post(widget.postDto.id,_titleController.text, _contentController.text);
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
            Container(
              height: 240.h,
              width: 360.w,
              child:ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    "assets/images/gym_img.png",
                    fit: BoxFit.cover,
                  )
              ),
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