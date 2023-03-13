import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Model/questionDto.dart';
import 'package:ohmmanager/View/question/popup/delete_popup.dart';
import 'package:ohmmanager/View/question/widget/answerEdit_bottomSheet.dart';
import 'package:ohmmanager/View/question/widget/answer_bottomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool state = false;
  List<QuestionDto> questions = [];
  List<String> dropdownList = ['답변전', '답변후'];
  String selectedDropdown = '답변전';
  final spinkit2 = SpinKitWanderingCubes(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: index.isEven ? kPrimaryColor : kBoxColor,
        ),
      );
    },
  );

  get_questions() async {
    setState(() {
      not_answers = [];
      ok_answers = [];
    });

    final prefs = await SharedPreferences.getInstance();
    String gymId = prefs.getString("gymId").toString();
    if (gymId == null) {
    } else {
      questions = await QuestionApi()
          .findall_question(prefs.getString("gymId").toString());

      for (int i = 0; i < questions.length; i++) {
        //아직 답변이 안된 줄민
        if (questions[i].answerDto != null) {
          ok_answers.add(questions[i]);
        } else {
          not_answers.add(questions[i]);
        }
      }

      return questions;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    myfuture = get_questions();
    super.initState();
  }

  PersistentBottomSheetController? _controller;

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
                    fontFamily: "lightfont",
                    color: kTextColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                width: 100.w,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 0.3),
                    color: kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: DropdownButton(
                    alignment: Alignment.center,
                    value: selectedDropdown,
                    underline: SizedBox.shrink(),
                    items: dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          '$item',
                          style: TextStyle(
                              fontSize: 15.sp, fontFamily: "boldfont"),
                        ),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedDropdown = value;
                      });
                    },
                  ),
                ),
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
                    return Container(
                      margin: EdgeInsets.only(top: 220.h),
                      child: Center(child: spinkit2),
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
                        SizedBox(
                          height: 20.h,
                        ),
                        questions.length == 0
                            ? Center(
                                child: Container(
                                    margin: EdgeInsets.only(top: 200.h),
                                    child: Text(
                                      "아직 등록된 문의가 없습니다.",
                                      style: TextStyle(
                                          fontFamily: "lightfont",
                                          fontSize: 18.sp),
                                    )),
                              )
                            : selectedDropdown == "답변전"
                                ? not_answers.length == 0
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(top: 200.h),
                                            child: Text(
                                              "아직 등록된 문의가 없습니다.",
                                              style: TextStyle(
                                                  fontFamily: "lightfont",
                                                  fontSize: 18.sp),
                                            )),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                            left: 15.w,
                                            bottom: 20.h,
                                            top: 10.h,
                                            right: 15.w),
                                        width: 360.w,
                                        height: 600.h,
                                        child: ListView.builder(
                                            itemCount: not_answers.length,
                                            itemBuilder:
                                                (BuildContext ctx, int idx) {
                                              return Container(
                                                width: 320.w,
                                                height: 90.h,
                                                
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey,width: 0.6),
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    color: kContainerColor),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: 300.w,
                                                      margin: EdgeInsets.only(
                                                          top: 10.h,
                                                          left: 3,
                                                          right: 4),
                                                      child: Text(

                                                        "${not_answers[idx].content}",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "lightfont",
                                                            color:
                                                                kTextBlackColor,
                                                            fontSize: 15.sp),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(top: 15.h),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                            onTap: ()async{
                                                              await DeleteQuestion_Popup()
                                                                  .showDialog(
                                                                  context,
                                                                  not_answers[
                                                                  idx]);

                                                              setState(() {
                                                                selectedDropdown;
                                                                myfuture =
                                                                    get_questions();
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 100.w,
                                                              height: 30.h,
                                                              decoration:
                                                              BoxDecoration(
                                                                  border: Border.all(color: Colors.grey,width: 0.6),
                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                              child: Center(
                                                                child: Text("삭제",style: TextStyle(fontSize: 16,fontFamily: "boldfont"),),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: ()async{
                                                              //답변전 위젯
                                                              await showModalBottomSheet<
                                                              void>(
                                                              context: context,
                                                              isScrollControlled:
                                                              true,
                                                              builder:
                                                              (BuildContext
                                                              context) {
                                                              return StatefulBuilder(builder:
                                                              (BuildContext
                                                              context,
                                                              StateSetter
                                                              bottomState) {
                                                              return Answer_BottomSheet(
                                                              questionDto:
                                                              not_answers[
                                                              idx],
                                                              setter:
                                                              bottomState,
                                                              );
                                                              });
                                                              });

                                                              setState(() {
                                                              myfuture =
                                                              get_questions();
                                                              selectedDropdown;
                                                              });
                                                            },
                                                            child: Container(
                                                              width: 100.w,
                                                              height: 30.h,
                                                              margin: EdgeInsets.only(left: 10),
                                                              decoration:
                                                              BoxDecoration(
                                                                  border: Border.all(color: Colors.grey,width: 0.6),
                                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                              child: Center(
                                                                child: Text("답변",style: TextStyle(fontSize: 16,fontFamily: "boldfont"),),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }))
                                : ok_answers.length == 0
                                    ? Center(
                                        child: Container(
                                            margin: EdgeInsets.only(top: 200.h),
                                            child: Text(
                                              "아직 등록된 답변이 없습니다.",
                                              style: TextStyle(
                                                  fontFamily: "lightfont",
                                                  fontSize: 18.sp),
                                            )),
                                      )
                                    : Container(
                            margin: EdgeInsets.only(
                                left: 15.w,
                                bottom: 20.h,
                                top: 10.h,
                                right: 15.w),
                            width: 360.w,
                            height: 600.h,
                            child: ListView.builder(
                                itemCount: ok_answers.length,
                                itemBuilder:
                                    (BuildContext ctx, int idx) {
                                  return Container(
                                    width: 320.w,
                                    height: 90.h,

                                    margin:
                                    EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 0.6),
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: kContainerColor),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 300.w,
                                          margin: EdgeInsets.only(
                                              top: 10.h,
                                              left: 3,
                                              right: 4),
                                          child: Text(

                                            "${ok_answers[idx].content}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily:
                                                "lightfont",
                                                color:
                                                kTextBlackColor,
                                                fontSize: 15.sp),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 15.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: ()async{
                                                  await DeleteQuestion_Popup()
                                                      .showDialog(
                                                      context,
                                                      not_answers[
                                                      idx]);

                                                  setState(() {
                                                    selectedDropdown;
                                                    myfuture =
                                                        get_questions();
                                                  });
                                                },
                                                child: Container(
                                                  width: 100.w,
                                                  height: 30.h,
                                                  decoration:
                                                  BoxDecoration(
                                                      border: Border.all(color: Colors.grey,width: 0.6),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      color: Colors
                                                          .grey
                                                          .shade400),
                                                  child: Center(
                                                    child: Text("삭제",style: TextStyle(fontSize: 16,fontFamily: "boldfont"),),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: ()async{
                                                  await showModalBottomSheet<
                                                      void>(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return StatefulBuilder(builder:
                                                            (BuildContext
                                                        context,
                                                            StateSetter
                                                            bottomState) {
                                                          return AnswerEdit_BottomSheet(
                                                            questionDto:
                                                            ok_answers[
                                                            idx],
                                                          );
                                                        });
                                                      });

                                                  setState(() {
                                                    selectedDropdown;
                                                    myfuture =
                                                        get_questions();
                                                  });
                                                },
                                                child: Container(
                                                  width: 100.w,
                                                  height: 30.h,
                                                  margin: EdgeInsets.only(left: 10),
                                                  decoration:
                                                  BoxDecoration(
                                                      border: Border.all(color: Colors.grey,width: 0.6),
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      color: Colors
                                                          .grey
                                                          .shade400),
                                                  child: Center(
                                                    child: Text("보기",style: TextStyle(fontSize: 16,fontFamily: "boldfont"),),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }))
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
