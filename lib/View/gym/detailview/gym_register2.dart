

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gymPriceDto.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gym_register3.dart';


class GymRegisterView2 extends StatefulWidget {
  String closedday;

  GymRegisterView2({required this.closedday});

  @override
  _GymRegisterView2 createState() => _GymRegisterView2();
}

class _GymRegisterView2 extends State<GymRegisterView2> {

  List<GymPriceDto> prices = [];

  String sunday_start="00:00";
  String saturday_start="00:00";
  String weekday_start="00:00";
  String holiday_start="00:00";


  String sunday_end="00:00";
  String saturday_end="00:00";
  String weekday_end="00:00";
  String holiday_end="00:00";


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(30),
              child: Text("운영시간 설정",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      showDialog_weekdaystart(size, context,"시작시간");
                    });


                  },
                  child: Text("평일 시작시간 : ${weekday_start}",style: TextStyle(fontSize: 15),),
                ),
                SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    showDialog_weekdayend(size, context,"시작시간");

                  },
                  child: Text("평일 종료시간 : ${weekday_end}",style: TextStyle(fontSize: 15),),
                ),
              ],
            ) ,
            SizedBox(height: 12,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog_staurdaystart(size, context,"시작시간");

                  },
                  child: Text("토요일 시작시간 : ${saturday_start}",style: TextStyle(fontSize: 15),),
                ),
                SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    showDialog_staurdayend(size, context,"시작시간");

                  },
                  child: Text("토요일 종료시간 : ${saturday_end}",style: TextStyle(fontSize: 15),),
                ),
              ],
            ) ,
            SizedBox(height: 12,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog_sundaystart(size, context,"시작시간");

                  },
                  child: Text("일요일 시작시간 : ${sunday_start}",style: TextStyle(fontSize: 15),),
                ),
                SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    showDialog_sundayend(size, context,"시작시간");

                  },
                  child: Text("일요일 종료시간 : ${sunday_end}",style: TextStyle(fontSize: 15),),
                ),
              ],
            ) ,
            SizedBox(height: 12,),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog_holydaystart(size, context,"시작시간");

                  },
                  child: Text("공휴일 시작시간 : ${holiday_start}",style: TextStyle(fontSize: 15),),
                ),
                SizedBox(width: 30,),
                InkWell(
                  onTap: (){
                    showDialog_holydayend(size, context,"시작시간");


                  },
                  child: Text("공휴일 종료시간 : ${holiday_end}",style: TextStyle(fontSize: 15),),
                ),
              ],
            ) ,

            SizedBox(height: 20,),
            Container(
                margin: EdgeInsets.all(30),
                child: Text("휴관일:${widget.closedday}")),


            SizedBox(height: 12,),
            InkWell(
              onTap: ()async{
                final prefs = await SharedPreferences.getInstance();
                var register_time =await GymApi().register_time(prefs.getString("gymId"), prefs.getString("token"), widget.closedday, sunday_start + " ~ "+ sunday_end,  saturday_start + " ~ "+ saturday_end, weekday_start+ " ~ "+ weekday_end,holiday_start+ " ~ "+ holiday_end);

                if(register_time == true){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: GymRegisterView3()));
                }else{
                  return;
                }
              },
              child: Text("다음",style: TextStyle(fontSize: 21),),
            ),



          ],
        ),
      ),
    );
  }
  void showDialog_weekdaystart(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    weekday_start = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    weekday_start = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    weekday_start = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    weekday_start = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });


                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("설정"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_weekdayend(Size size, BuildContext context,String title) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context,StateSetter set) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() =>{
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    weekday_end = "0${value.hour}"+":"+"0${value.minute}"
                                  }else{
                                    weekday_end = "0${value.hour}"+":"+"${value.minute}"
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    weekday_end = "${value.hour}"+":"+"0${value.minute}"
                                  }else{
                                    weekday_end = "${value.hour}"+":"+"${value.minute}"
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_staurdaystart(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    saturday_start = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    saturday_start = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    saturday_start = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    saturday_start = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_staurdayend(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    saturday_end = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    saturday_end = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    saturday_end = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    saturday_end = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_sundaystart(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    sunday_start = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    sunday_start = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    sunday_start = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    sunday_start = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_sundayend(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    sunday_end = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    sunday_end = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    sunday_end = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    sunday_end = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_holydaystart(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    holiday_start = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    holiday_start = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    holiday_start = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    holiday_start = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
  void showDialog_holydayend(Size size, BuildContext context,String title) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            onDateTimeChanged: (value) {
                              setState(() {
                                if(value.hour.toString().length == 1){
                                  if(value.minute.toString().length == 1){
                                    holiday_end = "0${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    holiday_end = "0${value.hour}"+":"+"${value.minute}";
                                  }
                                }else{
                                  if(value.minute.toString().length == 1){
                                    holiday_end = "${value.hour}"+":"+"0${value.minute}";
                                  }else{
                                    holiday_end = "${value.hour}"+":"+"${value.minute}";
                                  }
                                }

                              });
                            },
                            initialDateTime: DateTime.now(),
                          ),
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("완료"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }


}
