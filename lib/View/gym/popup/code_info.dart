import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/constants.dart';

class CodeInfo_Popup {
  void showDialog(Size size, BuildContext context,String title,String? time) {
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
                          height: size.height * 0.45,
                          width: size.width * 0.8,
                          child: Center(
                            child: Text("가입코드는 헬스장 트레이너 혹은 직원이 가입할때 인증받을 숫자입니다."),
                          )
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Text("닫기"))
                      ],
                    )
                ),
              ),
            );
          });
        });
  }
}
