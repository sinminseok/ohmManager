
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/gymImgDto.dart';
import 'package:ohmmanager/Model/gymTimeDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/home/widget/gymInfo_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/permission.dart';
import '../../frame/frame_view.dart';
import '../widget/gymEdit_widget.dart';

class GymTimeEdit_View extends StatefulWidget {
  GymDto? gymDto;

  GymTimeEdit_View({required this.gymDto});

  @override
  _GymTimeEdit_View createState() => _GymTimeEdit_View();
}

class _GymTimeEdit_View extends State<GymTimeEdit_View> {
  Future? myfuture;


  late GymTimeDto gymTimeDto;

  String? sunday_start;
  String? saturday_start;
  String? weekday_start;
  String? holiday_start;

  String? sunday_end;
  String? saturday_end;
  String? weekday_end;
  String? holiday_end;

  get_time()async{
    final prefs = await SharedPreferences.getInstance();
    String? gymId = await prefs.getString("gymId");

    gymTimeDto = (await GymApi().getTime(int.parse(gymId!)))!;
    sunday_start = gymTimeDto.sunday?.substring(0,5);
    sunday_end = gymTimeDto.sunday?.substring(8);

    weekday_start = gymTimeDto.weekday?.substring(0,5);
    weekday_end = gymTimeDto.weekday?.substring(8);

    saturday_start = gymTimeDto.saturday?.substring(0,5);
    saturday_end = gymTimeDto.saturday?.substring(8);

    holiday_start = gymTimeDto.holiday?.substring(0,5);
    holiday_end = gymTimeDto.holiday?.substring(8);
    return gymTimeDto;
  }
  @override
  void initState() {
    // TODO: implement initState
    myfuture = get_time();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        elevation: 0,
        backgroundColor: kBackgroundColor,

      ),
      backgroundColor: kBackgroundColor,
      body:  FutureBuilder(
          future: myfuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 360.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("wating.."),
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //평일
                    Container(
                        margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                        child: InkWell(
                            onTap: (){
                              //  showDialog_weekdaystart(size, context, "title");
                            },
                            child: Text("평일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                    Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: size.width*0.9,
                          height: size.height*0.13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                margin: EdgeInsets.only(top: 0,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_weekdaystart(size, context, "title");
                                    },
                                    child: Text("시작 시간 : ${weekday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_weekdayend(size, context, "title");
                                    },
                                    child: Text("종료 시간 : ${weekday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                              ),
                            ],
                          )
                      ),
                    ),

                    //토요일
                    gymTimeDto.closeddays=="토요일"?Container(): Container(
                        margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                        child: InkWell(
                            onTap: (){

                            },
                            child: Text("토요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                    gymTimeDto.closeddays=="토요일"?Container(): Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: size.width*0.9,
                          height: size.height*0.13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                margin: EdgeInsets.only(top: 0,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_staurdaystart(size, context, "title");
                                    },
                                    child: Text("시작 시간 : ${saturday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_staurdayend(size, context, "title");
                                    },
                                    child: Text("종료 시간 : ${saturday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                              ),
                            ],
                          )
                      ),
                    ),

                    //일요일
                    gymTimeDto.closeddays=="일요일"?Container():  Container(
                        margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                        child: InkWell(
                            onTap: (){
                              //  showDialog_weekdaystart(size, context, "title");
                            },
                            child: Text("일요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                    gymTimeDto.closeddays=="일요일"?Container(): Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: size.width*0.9,
                          height: size.height*0.13,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                margin: EdgeInsets.only(top: 0,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_sundaystart(size, context, "title");
                                    },
                                    child: Text("시작 시간 : ${sunday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_sundayend(size, context, "title");
                                    },
                                    child: Text("종료 시간 : ${sunday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                              ),
                            ],
                          )
                      ),
                    ),

                    //공휴일
                    gymTimeDto.holiday=="00:00 ~ 00:00"?Container():Container(
                        margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                        child: InkWell(
                            onTap: (){
                              //  showDialog_weekdaystart(size, context, "title");
                            },
                            child: Text("공휴일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                    gymTimeDto.holiday=="00:00 ~ 00:00"?Container():Center(
                      child: Container(
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          width: size.width*0.9,
                          height: size.height*0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Container(
                                margin: EdgeInsets.only(top: 0,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_holydaystart(size, context, "title");
                                    },
                                    child: Text("시작 시간 : ${holiday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10,left: 10),
                                child: InkWell(
                                    onTap: (){
                                      showDialog_holydayend(size, context, "title");
                                    },
                                    child: Text("종료 시간 : ${holiday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: InkWell(
                          onTap: () async {
                            print(gymTimeDto.id);
                            final prefs = await SharedPreferences.getInstance();
                            var register_time = await GymApi().update_time(
                              gymTimeDto.id,
                                prefs.getString("gymId"),
                                prefs.getString("token"),
                                gymTimeDto.closeddays,
                                sunday_start! + " ~ " + sunday_end!,
                                saturday_start! + " ~ " + saturday_end!,
                                weekday_start! + " ~ " + weekday_end!,
                                holiday_start! + " ~ " + holiday_end!);

                            if (register_time == true) {
                              showtoast("운영시간이 수정되었습니다.");
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FrameView()));
                            } else {
                              return;
                            }
                          },
                          child: Button("다음")
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              );
            }
          }),
    );
  }


  void showDialog_weekdaystart(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    weekday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    weekday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    weekday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    weekday_start =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_weekdayend(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, StateSetter set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() => {
                                if (value.hour.toString().length == 1)
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        weekday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        weekday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        weekday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        weekday_end = "${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_staurdaystart(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    saturday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    saturday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    saturday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    saturday_start =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_staurdayend(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    saturday_end =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    saturday_end =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    saturday_end =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    saturday_end =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_sundaystart(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    sunday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    sunday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    sunday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    sunday_start =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_sundayend(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    sunday_end =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    sunday_end =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    sunday_end =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    sunday_end =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_holydaystart(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    holiday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    holiday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    holiday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    holiday_start =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }

  void showDialog_holydayend(Size size, BuildContext context, String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, set) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.55,
                          width: size.width * 0.85,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if (value.hour.toString().length == 1) {
                                  if (value.minute.toString().length == 1) {
                                    holiday_end =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    holiday_end =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    holiday_end =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    holiday_end =
                                        "${value.hour}" + ":" + "${value.minute}";
                                  }
                                }
                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Button("완료")))
                      ],
                    )),
              ),
            );
          });
        });
  }
}
