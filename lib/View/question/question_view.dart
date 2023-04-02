import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Utils/widget/buttom_container.dart';
import 'package:ohmmanager/View/question/popup/delete_popup.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/message/questionDto.dart';
import '../../Utils/sundry/constants.dart';
import '../../Utils/sundry/toast.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({Key? key}) : super(key: key);

  @override
  _QuestionView createState() => _QuestionView();
}

class _QuestionView extends State<QuestionView> {
  TextEditingController _answerController = TextEditingController();
  TextEditingController _editingController = TextEditingController();
  bool gymcheck = false;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  List<QuestionDto> not_answers = [];
  List<QuestionDto> ok_answers = [];
  Future? myfuture;
  bool state = false;
  List<QuestionDto> questions = [];
  List<String> dropdownList = ['답변전', '답변후'];
  String selectedDropdown = '답변전';
  Future<bool> check_gym() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("gymId") == null) {
      setState(() {
        gymcheck =false;
      });

      return false;
    } else {
      setState(() {
        gymcheck =true;
      });
      return true;
    }
  }


  get_questions() async {
    await check_gym();
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



  @override
  Widget build(BuildContext context) {


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
                margin: EdgeInsets.only(top: 0.h,bottom: 0,right: 5.w),
                height: 36.h,
                width: 90.w,
                decoration: BoxDecoration(
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
        child:  gymcheck == false?Center(
          child: Container(
              margin: EdgeInsets.only(top: 180.h),
              child: Text("헬스장을 먼저 선택해주세요",style:  TextStyle(fontSize: 19.sp,fontFamily: "lightfont"),)),
        ):Column(
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
                                        height: 520.h,
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
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 0.6),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "lightfont",
                                                            color:
                                                                kTextBlackColor,
                                                            fontSize: 15.sp),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 15.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
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
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                              child: Center(
                                                                child: Text(
                                                                  "삭제",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "boldfont"),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        InkWell(
                                                            onTap: () async {
                                                              write_showDialog(context, not_answers[idx]);
                                                              // showDialog(context, _contentController)
                                                              //답변전 위젯
                                                              // await showModalBottomSheet<
                                                              //         void>(
                                                              //     context:
                                                              //         context,
                                                              //     isScrollControlled:
                                                              //         true,
                                                              //     builder:
                                                              //         (BuildContext
                                                              //             context) {
                                                              //       return StatefulBuilder(builder: (BuildContext
                                                              //               context,
                                                              //           StateSetter
                                                              //               bottomState) {
                                                              //         return Answer_BottomSheet(
                                                              //           questionDto:
                                                              //               not_answers[idx],
                                                              //           setter:
                                                              //               bottomState,
                                                              //         );
                                                              //       });
                                                              //     });
                                                              //
                                                              // setState(
                                                              //     ()  {
                                                              //   myfuture =
                                                              //        get_questions();
                                                              //   selectedDropdown;
                                                              // });
                                                            },
                                                            child: Container(
                                                              width: 100.w,
                                                              height: 30.h,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey,
                                                                      width:
                                                                          0.6),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400),
                                                              child: Center(
                                                                child: Text(
                                                                  "답변",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontFamily:
                                                                          "boldfont"),
                                                                ),
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
                                        height: 520.h,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                              itemCount: ok_answers.length,
                                              reverse: true,
                                              shrinkWrap: true,

                                              itemBuilder:
                                                  (BuildContext ctx, int idx) {
                                                return Container(
                                                  width: 320.w,
                                                  height: 90.h,
                                                  margin:
                                                      EdgeInsets.only(bottom: 15),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.6),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "lightfont",
                                                              color:
                                                                  kTextBlackColor,
                                                              fontSize: 15.sp),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 15.h),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                await DeleteQuestion_Popup()
                                                                    .showDialog(
                                                                        context,
                                                                        ok_answers[
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
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            0.6),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(
                                                                                10)),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400),
                                                                child: Center(
                                                                  child: Text(
                                                                    "삭제",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            "boldfont"),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () async {
                                                                setState(() {
                                                                  _editingController = TextEditingController(text: ok_answers[idx].answerDto!.content);
                                                                });
                                                                edit_showDialog(context,ok_answers[idx]);

                                                              },
                                                              child: Container(
                                                                width: 100.w,
                                                                height: 30.h,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left: 10),
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            0.6),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(
                                                                                10)),
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400),
                                                                child: Center(
                                                                  child: Text(
                                                                    "보기",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontFamily:
                                                                            "boldfont"),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ))
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );

  }
  void _writedoSomething(QuestionDto questionDto) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("gymId") == null) {
      showtoast("다니는 헬스장을 먼저 등록해보세요!");
    } else {
      var s = await QuestionApi()
          .register_answer(questionDto.id, _answerController.text);
      setState(() {
        myfuture = get_questions();
        _answerController.text = "";
      });


      showtoast("답변이 등록되었습니다.");
      Navigator.pop(context);
    }
  }

  void write_showDialog(
      BuildContext context, QuestionDto questionDto2) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, s) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180.w,
                                margin: EdgeInsets.only(left: 15.w, top: 20.h),
                                child: Text(
                                  "문의내용 작성",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: kTextBlackColor,
                                      fontFamily: "boldfont"),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 15.w, top: 5.h),
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 20.h, left: 10.w, right: 10.w),
                              width: 310.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                  color: kContainerColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {});
                                },
                                controller: _answerController,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: "답변",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              )),
                          SizedBox(height: 20.h,),
                          InkWell(
                              onTap: (){
                                _writedoSomething(questionDto2);
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 10.w,right: 10.w),
                                  child: Button("답변"))),
                          SizedBox(height: 20.h,),



                        ],
                      ),
                    )),
              ),
            );
          });
        });
  }

  void _editdoSomething(QuestionDto questionDto3) async {
    print(questionDto3.id);
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("gymId") == null) {
      showtoast("다니는 헬스장을 먼저 등록해보세요!");
    } else {
      var s = await QuestionApi().edit_answer(questionDto3.answerDto!.id, _editingController.text);
      setState(() {
        myfuture = get_questions();
      });

      // _editingController.clear();
      showtoast("답변이 수정되었습니다.");
      Navigator.pop(context);
    }
  }

  void edit_showDialog(
      BuildContext context, QuestionDto questionDto2) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, s) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: kBackgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 180.w,
                                margin: EdgeInsets.only(left: 15.w, top: 20.h),
                                child: Text(
                                  "문의내용 작성",
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: kTextBlackColor,
                                      fontFamily: "boldfont"),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 15.w, top: 5.h),
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 20.h, left: 10.w, right: 10.w),
                              width: 310.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                  color: kContainerColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {});
                                },
                                controller: _editingController,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: "답변",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              )),
                          SizedBox(height: 20.h,),
                          Container(
                            margin: EdgeInsets.only(left: 10.w,right: 10.w),
                            child: InkWell(
                                onTap: (){
                                  _editdoSomething(questionDto2);
                                },
                                child: Button("수정")),
                          ),
                          SizedBox(height: 20.h,),



                        ],
                      ),
                    )),
              ),
            );
          });
        });
  }


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
}
