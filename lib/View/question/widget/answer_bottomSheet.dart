import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Utils/sundry/constants.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../Model/message/questionDto.dart';

class Answer_BottomSheet extends StatefulWidget {
  QuestionDto questionDto;
  StateSetter? setter;

  // Future<dynamic>? fun;
  Answer_BottomSheet({required this.questionDto, required this.setter});

  @override
  State<Answer_BottomSheet> createState() => _Answer_BottomSheetState();
}

class _Answer_BottomSheetState extends State<Answer_BottomSheet> {
  TextEditingController _answerController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    var register_answer = await QuestionApi()
        .register_answer(widget.questionDto.id, _answerController.text);
    Navigator.pop(context);
    if (register_answer == true) {
      _btnController.success();
      widget.setter!(() {});
      showtoast("답변이 등록되었습니다");
    } else {
      _btnController.stop();
      showtoast("네트워크를 확인해주세요");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 420.h,
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  margin: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                  child: Text(
                    "${widget.questionDto.content}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(10)),
                width: 340.w,
                height: 250.h,
                child: TextFormField(
                  controller: _answerController,
                  textAlign: TextAlign.start,
                  cursorColor: kContainerColor,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: "답변",
                      border: InputBorder.none),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 30.h),
                  child: RoundedLoadingButton(
                    controller: _btnController,
                    successColor: kTextBlackColor,
                    color: kTextBlackColor,
                    onPressed: _doSomething,
                    child: Container(
                      width: 330.w,
                      height: 47.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kButtonColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "답변등록",
                        style: TextStyle(
                            fontFamily: "lightfont",
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
