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
import '../../gym/detailview/gym_register.dart';
import '../../gym/edit/gymEdit_view.dart';

class Register_Popup {
  void showDialog(BuildContext context) {
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
                      Container(
                        margin: EdgeInsets.only(
                            top: 30.h, bottom: 10.h, left: 15.w, right: 15.h),
                        child: Text(
                          "헬스장 등록이 진행되는동안 어플을 종료하지마세요!\n\n최소 한장 이상의 헬스장 사진이 필요합니다.",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "lightfont"),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: GymRegisterView()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  bottom: 15, top: 30, left: 20, right: 20),
                              child: Button("등록 하러가기")))
                    ],
                  ),
                )),
              ),
            );
          });
        });
  }
}
