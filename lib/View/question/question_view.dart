import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Model/questionDto.dart';
import 'package:ohmmanager/View/post/detailview/post_write.dart';
import 'package:ohmmanager/View/post/widgets/post_widget.dart';
import 'package:ohmmanager/View/question/popup/delete_popup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/postDto.dart';
import '../../Controller/postApi.dart';
import '../../Utils/constants.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionView createState() => _QuestionView();
}

class _QuestionView extends State<QuestionView> {
  List<QuestionDto> not_answers = [];
  List<QuestionDto> ok_answers = [];
  Future? myfuture;

  get_questions() async {
    final prefs = await SharedPreferences.getInstance();
    String gymId = prefs.getString("gymId").toString();
    if (gymId == null) {
      return;
    } else {
      List<QuestionDto> questions = await QuestionApi()
          .findall_question(prefs.getString("gymId").toString());

      for (int i = 0; i < questions.length; i++) {
        //아직 답변이 안된 줄민
        if (questions[i].answerDto == null) {
          not_answers.add(questions[i]);
        } else {
          ok_answers.add(questions[i]);
        }
      }
      return ok_answers;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    myfuture = get_questions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: AppBar(
          iconTheme: IconThemeData(
            color: kTextColor, //change your color here
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "회원 문의",
                style: TextStyle(
                    fontSize: 21,
                    color: kTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: myfuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: size.width * 1,
                          height: size.height * 0.64,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Wating..."),
                        )
                      ],
                    );
                  }

                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.w, bottom: 20.h, top: 10.h),
                          child: Text(
                            "답변전",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 15.w,
                                bottom: 20.h,
                                top: 10.h,
                                right: 15.w),
                            width: 360.w,
                            height: 260.h,
                            child: ListView.builder(
                                itemCount: not_answers.length,
                                itemBuilder: (BuildContext ctx, int idx) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        width: 340.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                            color: kBoxColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: InkWell(
                                          onTap: () {
                                            print("d");
                                          },
                                          child: Container(
                                              width: 320.w,
                                              margin: EdgeInsets.only(
                                                  left: 10.w, right: 10),
                                              child: Center(
                                                  child: Text(
                                                "${not_answers[idx].content}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 16),
                                              ))),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 3.h, right: 5.w),
                                            child: InkWell(
                                                onTap: () {
                                                  DeleteQuestion_Popup().showDialog(context,not_answers[idx]);
                                                },
                                                child: Icon(Icons.cancel)),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                })),
                        Container(
                          margin: EdgeInsets.only(
                              left: 15.w, bottom: 20.h, top: 10.h),
                          child: Text(
                            "답변완료",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 15.w,
                                bottom: 20.h,
                                top: 10.h,
                                right: 15.w),
                            width: 360.w,
                            height: 260.h,
                            child: ListView.builder(
                                itemCount: ok_answers.length,
                                itemBuilder: (BuildContext ctx, int idx) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      width: 340.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          color: kBoxColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Container(
                                          width: 340.w,
                                          margin: EdgeInsets.only(
                                              left: 10.w, right: 10),
                                          child: Center(
                                              child: Text(
                                            "${ok_answers[idx].content}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize: 16),
                                          ))),
                                    ),
                                  );
                                })),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}