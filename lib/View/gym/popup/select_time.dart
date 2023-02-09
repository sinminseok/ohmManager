import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/constants.dart';

class SelectTime_Popup {
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
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (value) {
                            setState(() {
                              time = "${value.hour}"+"${value.minute}";
                              print("time = $time");
                            });
                          },
                          initialDateTime: DateTime.now(),
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            print("object");
                          },
                          child: Text("data"))
                    ],
                  )
                ),
              ),
            );
          });
        });
  }
}
