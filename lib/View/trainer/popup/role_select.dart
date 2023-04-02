

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/widget/buttom_container.dart';
import 'package:ohmmanager/View/trainer/detailview/manager_register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Utils/sundry/constants.dart';
import '../../../Utils/sundry/toast.dart';

class RoleSelect_Popup {
  void showDialog(Size size, BuildContext context) {
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
                    child: Column(
                      children: [
                        Container(
                            height: size.height * 0.25,
                            width: size.width * 0.9,
                            child: Center(
                              child: Text("직원의 직책을 선택해주세요!",style: TextStyle(fontSize: 17.sp),),
                            )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade, child: Manager_Register(role: 'manager',)));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 10.h,left: 0.h,right: 0.h),
                                    child: Container(
                                      width: 200.w,
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kButtonColor,
                                      ),


                                      alignment: Alignment.center,
                                      child: Text(
                                        "일반직원",
                                        style: TextStyle(
                                            color: kTextWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
                                        ),
                                      ),
                                    ))),
                            InkWell(
                                onTap: ()async{
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade, child: Manager_Register(role: 'trainer',)));

                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 20.h,left: 0.h,right: 0.h),
                                    child: Container(
                                      width: 200.w,
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kButtonColor,
                                      ),


                                      alignment: Alignment.center,
                                      child: Text(
                                        "트레이너",
                                        style: TextStyle(
                                            color: kTextWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
                                        ),
                                      ),
                                    ))),
                          ],
                        )
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
}
