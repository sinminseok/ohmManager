import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gymPriceDto.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/buttom_container.dart';
import 'gym_register3.dart';

class GymRegisterView2 extends StatefulWidget {
  String closedday;
  bool holyday_bool;

  GymRegisterView2({required this.closedday,required this.holyday_bool});

  @override
  _GymRegisterView2 createState() => _GymRegisterView2();
}

class _GymRegisterView2 extends State<GymRegisterView2> {
  List<GymPriceDto> prices = [];
  bool goodToGo = true;
  String sunday_start = "00:00";
  String saturday_start = "00:00";
  String monday_start = "00:00";
  String tuesday_start = "00:00";
  String wednesday_start = "00:00";
  String thursday_start = "00:00";
  String friday_start = "00:00";
  String holiday_start = "00:00";

  String sunday_end = "00:00";
  String saturday_end = "00:00";
  String monday_end = "00:00";
  String tuesday_end = "00:00";
  String wednesday_end = "00:00";
  String thursday_end = "00:00";
  String friday_end = "00:00";
  String holiday_end = "00:00";

  @override
  void initState() {
    super.initState();
  }
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {

    final prefs = await SharedPreferences.getInstance();

    if(!goodToGo){return;}
    if(goodToGo){debugPrint("Going to the moon!");}// do your thing
    goodToGo = false;

    Future.delayed(const Duration(milliseconds: 1), () async{
      goodToGo = true;
      var register_time = await GymApi().register_time(
          prefs.getString("gymId"),
          prefs.getString("token"),
          widget.closedday,
          monday_start + " ~ " + monday_end,
          tuesday_start + " ~ " + tuesday_end,
          wednesday_start + " ~ " + wednesday_end,
          thursday_start + " ~ " + thursday_end,
          friday_start + " ~ " + friday_end,
          sunday_start + " ~ " + sunday_end,
          saturday_start + " ~ " + saturday_end,

          holiday_start + " ~ " + holiday_end);

      if (register_time == true) {
        _btnController.success();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: GymRegisterView3()));
      } else {
        return;
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(

            color: kIconColor, //change your color here
          ),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.black26,
                  width: 0.3
              )
          ),
          backgroundColor: kBackgroundColor,
          elevation: 0,
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
          child: Column(

            children: [
              //평일

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("월요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
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
                                    showDialog_mondaystart(size, context, "title");
                                  },
                                  child: Text("시작 시간 : ${monday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: InkWell(
                                  onTap: (){
                                    showDialog_mondayend(size, context, "title");
                                  },
                                  child: Text("종료 시간 : ${monday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("화요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
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
                                    showDialog_tusdaystart(size, context, "title");
                                  },
                                  child: Text("시작 시간 : ${tuesday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: InkWell(
                                  onTap: (){
                                    showDialog_tuesdayend(size, context, "title");
                                  },
                                  child: Text("종료 시간 : ${tuesday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("수요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
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
                                    showDialog_wednesdaystart(size, context, "title");
                                  },
                                  child: Text("시작 시간 : ${wednesday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: InkWell(
                                  onTap: (){
                                    showDialog_wednesdayend(size, context, "title");
                                  },
                                  child: Text("종료 시간 : ${wednesday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("목요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
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
                                    showDialog_thursdaystart(size, context, "title");
                                  },
                                  child: Text("시작 시간 : ${thursday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: InkWell(
                                  onTap: (){
                                    showDialog_thursdayend(size, context, "title");
                                  },
                                  child: Text("종료 시간 : ${thursday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("금요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
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
                                    showDialog_fridaystart(size, context, "title");
                                  },
                                  child: Text("시작 시간 : ${friday_start}",style: TextStyle(fontSize: 20,color: kTextColor))),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 10),
                              child: InkWell(
                                  onTap: (){
                                    showDialog_fridayend(size, context, "title");
                                  },
                                  child: Text("종료 시간 : ${friday_end}",style: TextStyle(fontSize: 20,color: kTextColor),)),
                            ),
                          ],
                        )
                    ),
                  ),

                  //토요일
                  widget.closedday=="토요일"?Container(): Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){

                          },
                          child: Text("토요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                  widget.closedday=="토요일"?Container(): Center(
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
                  widget.closedday=="일요일"?Container():  Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("일요일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                  widget.closedday=="일요일"?Container(): Center(
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
                  widget.holyday_bool==true?Container():Container(
                      margin: EdgeInsets.only(left: 20,bottom: 10,top: 30),
                      child: InkWell(
                          onTap: (){
                            //  showDialog_weekdaystart(size, context, "title");
                          },
                          child: Text("공휴일 운영 시간",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: kTextColor),))),
                  widget.holyday_bool==true?Container():Center(
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
                ],
              ),


              SizedBox(height: 30.h,),
              Center(
                  child: RoundedLoadingButton(
                    color: kTextBlackColor,
                    successColor: kTextBlackColor,
                    controller: _btnController,
                    onPressed: () {
                      _doSomething();
                    },
                    child: Container(
                      width: 330.w,
                      height: 47.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kButtonColor,
                      ),


                      alignment: Alignment.center,
                      child: Text(
                        "다음",
                        style: TextStyle(
                            fontFamily: "lightfont",
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void showDialog_mondaystart(Size size, BuildContext context, String title) {
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
                                    monday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    monday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    monday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    monday_start =
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

  void showDialog_mondayend(Size size, BuildContext context, String title) {
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
                                        monday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        monday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        monday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        monday_end = "${value.hour}" +
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

  void showDialog_tusdaystart(Size size, BuildContext context, String title) {
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
                                    tuesday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    tuesday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    tuesday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    tuesday_start =
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

  void showDialog_tuesdayend(Size size, BuildContext context, String title) {
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
                                        tuesday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        tuesday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        tuesday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        tuesday_end = "${value.hour}" +
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

  void showDialog_wednesdaystart(Size size, BuildContext context, String title) {
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
                                    wednesday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    wednesday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    wednesday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    wednesday_start =
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

  void showDialog_wednesdayend(Size size, BuildContext context, String title) {
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
                                        wednesday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        wednesday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        wednesday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        wednesday_end = "${value.hour}" +
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

  void showDialog_thursdaystart(Size size, BuildContext context, String title) {
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
                                    thursday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    thursday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    thursday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    thursday_start =
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

  void showDialog_thursdayend(Size size, BuildContext context, String title) {
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
                                        thursday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        thursday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        thursday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        thursday_end = "${value.hour}" +
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

  void showDialog_fridaystart(Size size, BuildContext context, String title) {
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
                                    friday_start =
                                        "0${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    friday_start =
                                        "0${value.hour}" + ":" + "${value.minute}";
                                  }
                                } else {
                                  if (value.minute.toString().length == 1) {
                                    friday_start =
                                        "${value.hour}" + ":" + "0${value.minute}";
                                  } else {
                                    friday_start =
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

  void showDialog_fridayend(Size size, BuildContext context, String title) {
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
                                        friday_end = "0${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        friday_end = "0${value.hour}" +
                                            ":" +
                                            "${value.minute}"
                                      }
                                  }
                                else
                                  {
                                    if (value.minute.toString().length == 1)
                                      {
                                        friday_end = "${value.hour}" +
                                            ":" +
                                            "0${value.minute}"
                                      }
                                    else
                                      {
                                        friday_end = "${value.hour}" +
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
