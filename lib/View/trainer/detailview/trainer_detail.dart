

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohmmanager/Model/trainerDto.dart';

import '../../../Utils/constants.dart';


class Trainer_Detail extends StatefulWidget {
  TrainerDto trainerDto;
  Trainer_Detail({required this.trainerDto});


  @override
  _Trainer_Detail createState() => _Trainer_Detail();
}

class _Trainer_Detail extends State<Trainer_Detail> {
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
                      "assets/images/teacher.jpeg",
                      fit: BoxFit.cover,
                    )
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.453,
                child: Column(
                  children: [
                    Text("신민석 트레이너",style: TextStyle(fontSize: 30),),
                    SizedBox(height: size.height*0.1,),
                    Text("한줄소개 .. ",style: TextStyle(fontSize: 30),),
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