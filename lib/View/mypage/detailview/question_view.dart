import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Utils/sundry/constants.dart';

class Question_View extends StatelessWidget {
  const Question_View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: AppBar(
          iconTheme: IconThemeData(
            color: kIconColor, //change your color here
          ),
          backgroundColor: kBackgroundColor,
          shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w,bottom: 10.h,top: 20.h),
              child: Text("오헬몇은 무슨 서비스인가요?",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
            ),
            Center(
              child: Container(
                width: 340.w,
                height: 250.h,
                decoration: BoxDecoration(
                    color: kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Container(
                    margin: EdgeInsets.all(20.h),
                    child: Text("오헬몇은 다니는 헬스장을 등록해 실시간으로 헬스장에 있는 인원수를 볼수있습니다!\n\n뿐만아니라 헬스장 최근 공지사항,운영시간,이용가격등을 확인하고 평소 헬스장을 이용하면서 불편했던 사항을 헬스장 담장자에게 익명으로 말할수 있습니다\n\n 오헬몇을 이용해 편한시간에 운동해보세요!",style: TextStyle(fontSize: 21),)),
              ),
            ),



            Container(
              margin: EdgeInsets.only(left: 10.w,bottom: 10.h,top: 20.h),
              child: Text("오헬몇 서비스는 무료인가요?",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
            ),
            Center(
              child: Container(
                width: 340.w,
                height: 170.h,
                decoration: BoxDecoration(
                    color: kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Container(
                    margin: EdgeInsets.all(20.h),
                    child: Text("오헬몇 서비스는 현재 무료로 사용하실수 있습니다! 추후 사용자가 증가해 서버비,유지보수를 위한 비용이 필요할 경우 최소한의 금액만을 측정해 헬스장측에 청구드릴 예정입니다.",style: TextStyle(fontSize: 21),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
