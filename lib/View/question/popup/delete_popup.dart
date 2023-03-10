import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/questionApi.dart';
import 'package:ohmmanager/Model/questionDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';

import '../../../Utils/constants.dart';

class DeleteQuestion_Popup {
  Future<bool?> showDialog( BuildContext context,QuestionDto questionDto) async{
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            content: DefaultTextStyle(
              style: TextStyle(fontSize: 16, color: Colors.black),
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 3.w),
                              child: Icon(Icons.cancel),
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30.h,left: 10.w,right: 10.h),
                          child: Text("?????? ????????? ??????????????????????",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                      InkWell(
                          onTap: ()async{
                            var delete_question =await QuestionApi().delete_question(questionDto.id);
                            if(delete_question == true){
                              showtoast("????????????");
                              Navigator.pop(context,true);

                            }else{
                              showtoast("??????????????? ??????????????????");
                              Navigator.pop(context,true);
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 20.h,top: 40.h),
                              child: Button("????????????")))
                    ],
                  )
              ),
            ),
          );
        });
  }
}
