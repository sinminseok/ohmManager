

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Model/PostDto.dart';
import '../../../Utils/constants.dart';


class Post_Detail extends StatefulWidget {


  PostDto postDto;

  Post_Detail({required this.postDto});

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                width: size.width * 0.9,
                child:ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/images/gym_img.png",
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.13,
                child: Column(
                  children: [
                    Text("${widget.postDto.title}",style: TextStyle(fontSize: 30),),
                    Text("${widget.postDto.content}",style: TextStyle(fontSize: 30),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),


    );
  }
}