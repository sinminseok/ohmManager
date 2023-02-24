

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Model/questionDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';

class Answer_BottomSheet extends StatefulWidget {
  QuestionDto questionDto;
  StateSetter? setter;

  // Future<dynamic>? fun;
  Answer_BottomSheet({required this.questionDto,required this.setter});

  @override
  State<Answer_BottomSheet> createState() => _Answer_BottomSheetState();
}

class _Answer_BottomSheetState extends State<Answer_BottomSheet> {
  TextEditingController _answerController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Container(
        height: 400.h,
        color: kBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

             Container(
                width: 340.w,
                margin: EdgeInsets.only(top: 15.h),
                decoration: BoxDecoration(
                  color: kBoxColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.w),
                  child: Text("${widget.questionDto.content}",style: TextStyle(fontSize: 18),),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: 340.w,
                height: 170.h,
                child: TextFormField(
                  controller: _answerController,
                  textAlign: TextAlign.start,
                  cursorColor: kContainerColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                      hintText: "답변",
                      border: InputBorder.none
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                child: InkWell(

                    onTap: ()async{
                      var register_answer =await QuestionApi().register_answer(widget.questionDto.id, _answerController.text);
                      if(register_answer == true){
                        widget.setter!((){

                        });


                        showtoast("답변이 등록되었습니다");
                        Navigator.pop(context);
                      }else{
                        showtoast("네트워크를 확인해주세요");
                      }
                    },
                    child: Button("답변 등록")),
              )
            ],
          ),
        ));
  }
}
