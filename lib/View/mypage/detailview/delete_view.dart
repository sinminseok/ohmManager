import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/Utils/widget/buttom_container.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:ohmmanager/View/account/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/sundry/constants.dart';

class Delete_View extends StatefulWidget {
  const Delete_View({Key? key}) : super(key: key);

  @override
  State<Delete_View> createState() => _Delete_ViewState();
}

class _Delete_ViewState extends State<Delete_View> {

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(38.h),
        child: AppBar(
          iconTheme: IconThemeData(
            color: kTextWhiteColor, //change your color here
          ),
          backgroundColor: kBottomColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 10.w,top: 13.h),
                child: Text("회원탈퇴",style: TextStyle(fontFamily: "boldfont",fontSize: 18.sp),)),
            Container(
              margin: EdgeInsets.only(left: 10.w,top: 13.h),
              child:Text("오헬몇 계정을 삭제합니다.한번 삭제된 계정은 복구가 불가능합니다.그래도 진행하시겠습니까?",style: TextStyle(fontFamily: "lightfont"),),
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
                  value: isChecked,
                  shape: CircleBorder(),
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                      print(isChecked);
                    });
                  },
                ),
                Text("위 내용을 숙지 하였으며 동의합니다."),

              ],
            ),
            SizedBox(
              height: 410.h,
            ),
            InkWell(
                onTap: ()async{
                  if(isChecked == false){
                    showtoast("약관에 동의해주세요");
                  }else{
                    final prefs = await SharedPreferences.getInstance();
                    var userId = prefs.getString("userId");

                   bool check = await AdminApi().delete_account(userId.toString(),prefs.getString("token").toString());
                   if(check ==true){
                     showtoast("계정이 삭제되었습니다.");
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                         builder: (BuildContext context) =>
                             LoginView()), (route) => false);


                  }else{
                     showtoast("서버 오류. 관리자에게 문의하세요");

                   }
                  }
                },
                child: Center(child: Button("계정 삭제하기")))
          ],
        ),
      ),
    );
  }
}
