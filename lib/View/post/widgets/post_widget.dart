import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Model/postDto.dart';
import '../detailview/post_detail.dart';



Widget Post_Widget(Size size,context,PostDto postDto) {

  return InkWell(
    onTap: ()async{

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: Post_Detail(postDto:postDto)));

    },
    child:Padding(
      padding: const EdgeInsets.only(bottom: 30.0,top: 10),
      child: Container(
        height: size.height * 0.55,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(1))),
        child: Column(
          children: [
            postDto.imgs.length == 0?Container():Container(
              height: size.height * 0.4,
              width: size.width * 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(1.0),
                  child: Image.asset(
                    "assets/images/gym_img.png",
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${postDto.title}",style: TextStyle(fontFamily: "boldfont",fontSize: 21),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("..더보기",style: TextStyle(fontFamily: "lightfont",fontSize: 21),),
            ),
          ],
        ),
      ),
    ),

  );
}

Widget Gym_Trainer_Item(Size size,context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: size.height * 0.2,
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
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          //  assets/images/img1.jpeg

          Container(
            width: size.width*0.4,
            child: ClipRRect(

                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset("assets/images/teacher.jpeg",fit: BoxFit.cover,)),
          ),
          Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("신민석 선생님",style: TextStyle(fontSize: 18,fontFamily: "boldfont"),),
              ),
              Text("비나이더 안산점",style: TextStyle(color: Colors.grey,fontFamily: "boldfont"),),
              SizedBox(height: size.height*0.06,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("근세포 하나하나 자극을",style: TextStyle(fontFamily: "boldfont"),),
              )
            ],
          )
        ],
      ),
    ),
  );
}