import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/gymTimeDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/gym/edit/gymPriceEdit_view.dart';
import 'package:ohmmanager/View/gym/edit/gymTimeEdit_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/constants.dart';
import '../../gym/edit/gymEdit_view.dart';

class Edit_Popup {
  void showDialog(BuildContext context,GymDto gymDto) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              content: DefaultTextStyle(
                style: TextStyle(fontSize: 16, color: Colors.black),
                child: SingleChildScrollView(
                    child: Container(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: GymEdit_View(gymDto: gymDto,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          width: 320.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: kBoxColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20,right: 15),
                                  child: Icon(Icons.fitness_center,color: kPrimaryColor,size: 25,)),
                              Container(
                                child: Text("헬스장 정보수정",style: TextStyle(color: kPrimaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: GymPrice_View(gymDto: gymDto,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          width: 320.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: kBoxColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20,right: 15),
                                  child: Icon(Icons.monetization_on_outlined,color: kPrimaryColor,size: 25,)),
                              Container(
                                child: Text("헬스장 가격수정",style: TextStyle(color: kPrimaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: GymTimeEdit_View(gymDto: gymDto,)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                          width: 320.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: kBoxColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 20,right: 15),
                                  child: Icon(Icons.alarm,color: kPrimaryColor,size: 25,)),
                              Container(
                                child: Text("헬스장 시간수정",style: TextStyle(color: kPrimaryColor,fontSize: 17,fontWeight: FontWeight.bold),),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            print("object");
                          },
                          child: Container(
                              margin: EdgeInsets.only(bottom: 15,top: 30,left: 20,right: 20),
                              child: Button("닫기")))
                    ],
                  ),
                )),
              ),
            );
          });
        });
  }
}
