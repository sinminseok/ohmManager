import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Utils/sundry/constants.dart';

class Loading_Widget extends StatelessWidget {
  const Loading_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spinkit2 = SpinKitWanderingCubes(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: index.isEven ? kPrimaryColor : kBoxColor,
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            margin: EdgeInsets.only(top: 200.h,bottom: 40.h),
            child: Text("로그인 정보 확인중..",style: TextStyle(fontFamily: "lightfont2",fontWeight:FontWeight.bold,fontSize: 18.sp,color: kTextBlackColor),),),
          Center(
            child: spinkit2,
          ),
        ],
      )
    );
  }
}
