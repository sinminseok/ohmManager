

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Model/questionDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/mypage/detailview/question_view.dart';
import 'package:ohmmanager/View/question/question_view.dart';

class AnswerEdit_BottomSheet extends StatefulWidget {
  QuestionDto questionDto;

  AnswerEdit_BottomSheet({required this.questionDto});

  @override
  State<AnswerEdit_BottomSheet> createState() => _AnswerEdit_BottomSheetState();
}

class _AnswerEdit_BottomSheetState extends State<AnswerEdit_BottomSheet> {

  TextEditingController? _answerController;

  @override
  void initState() {
    // TODO: implement initState
    _answerController = TextEditingController(text: widget.questionDto.answerDto?.content);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
        height: 350.h,
        color: kBackgroundColor,
        child: Column(
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
                    var register_answer =await QuestionApi().edit_answer(widget.questionDto.answerDto!.id, _answerController!.text);
                    if(register_answer == true){
                      showtoast("답변이 수정되었습니다.");
                       // widget.fun;

                      Navigator.pop(context);
                    }else{
                      showtoast("네트워크를 확인해주세요");
                    }
                  },
                  child: Button("수정하기")),
            )
          ],
        ));
  }
}
