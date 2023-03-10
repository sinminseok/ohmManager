import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/gymTimeDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:ohmmanager/View/gym/edit/gymPriceEdit_view.dart';
import 'package:ohmmanager/View/gym/edit/gymTimeEdit_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../gym/edit/gymEdit_view.dart';

class Reset_Popup {
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
                            margin: EdgeInsets.only(top: 20.h,bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: Icon(Icons.info),
                                ),
                                Text("?????? ?????????",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 16.sp,fontFamily: "lightfont"),),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Text("????????? ?????? ????????? ???????????? ???????????????\n????????? ????????? ????????? ?????? ????????? 0?????? ??????????????????",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "lightfont",fontSize: 15.sp),),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 120.w,
                                  height: 35.h,
                                  margin: EdgeInsets.only(right: 7,bottom: 10,top: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kButtonColor,
                                  ),


                                  alignment: Alignment.center,
                                  child: Text(
                                    "??????",
                                    style: TextStyle(
                                        color: kTextWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                )),
                            InkWell(
                                onTap: () async{
                                  bool return_bool =
                                      await GymApi().reset_count();
                                  if (return_bool == true) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FrameView()), (route) => false);
                                    showtoast("????????? ???????????????.");
                                  } else {
                                    Navigator.pop(context);
                                    showtoast("??????");
                                  }
                                },
                                child: Container(
                                  width: 120.w,
                                  height: 35.h,
                                  margin: EdgeInsets.only(left: 7,bottom: 10,top: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kButtonColor,
                                  ),


                                  alignment: Alignment.center,
                                  child: Text(
                                    "?????????",
                                    style: TextStyle(
                                        color: kTextWhiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                )),
                          ],)
                        ],
                      ),
                    )),
              ),
            );
          });
        });
  }
}
