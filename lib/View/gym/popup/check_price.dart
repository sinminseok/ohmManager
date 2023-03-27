

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Model/gymPriceDto.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../register/finish_view.dart';

class CheckPrice_Popup {
  void showDialog(Size size, BuildContext context,List<GymPriceDto> prices) {
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
                              child: Text("헬스장 이용가격을 모두 입력하셨습니까?"),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 20.h,left: 0.h,right: 0.h),
                                    child: Container(
                                      width: 110.w,
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kButtonColor,
                                      ),


                                      alignment: Alignment.center,
                                      child: Text(
                                        "닫기",
                                        style: TextStyle(
                                            color: kTextWhiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17
                                        ),
                                      ),
                                    ))),
                            InkWell(
                                onTap: ()async{
                                  showtoast("잠시만 기다려주세요!");
                                  Future.delayed(const Duration(milliseconds: 1000), () async{

                                    final prefs = await SharedPreferences.getInstance();
                                    var bool = await GymApi().register_price(prefs.getString("gymId"), prefs.getString("token"), prices);
                                    if(bool == null){
                                      return showtoast("서버오류");
                                    }else{
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: GymSave_Finish()));
                                    }
                                  });

                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 20.h,left: 0.h,right: 0.h),
                                    child: Container(
                                      width: 110.w,
                                      height: 37.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kButtonColor,
                                      ),


                                      alignment: Alignment.center,
                                      child: Text(
                                        "등록",
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
