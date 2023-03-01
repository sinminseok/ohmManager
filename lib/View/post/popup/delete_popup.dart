

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Controller/postApi.dart';
import '../../../Model/gymPriceDto.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../frame/frame_view.dart';

class DeletePost_Popup {
  void showDialog(Size size, BuildContext context,int postid) {
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
                              child: Text("해당 게시글을 삭제 하시겠습니까?"),
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
                                  var delete_post =
                                  await PostApi().delete_post(postid);
                                  if (delete_post == true) {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            FrameView()), (route) => false);


                                    showtoast("게시물이 삭제되었습니다.");
                                  } else {
                                    showtoast("삭제중 오류가 발생했습니다");
                                  }
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
                                        "삭제",
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
