

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/sundry/constants.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:ohmmanager/View/account/login_view.dart';
import 'package:ohmmanager/View/mypage/detailview/delete_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_BottomSheet extends StatelessWidget {
  const Profile_BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130.h,
        color: kBackgroundColor,
        child: Column(
          children: [

            InkWell(
              onTap: ()async{

              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black,
                          width: 0.1)),
                ),
                child: ListTile(
                  leading: new Icon(
                      Icons.logout),
                  title: new Text(
                    '로그아웃',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily:
                        "numberfont"),
                  ),
                  onTap: () async{
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove("token");
                    prefs.remove("userId");
                    prefs.remove("gymId");
                    prefs.remove("loginId");
                    prefs.remove("loginPw");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            LoginView()), (route) => false);

                    showtoast("로그아웃 되었습니다 ");
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black,
                        width: 0.1)),
              ),
              child: ListTile(
                leading: new Icon(
                    Icons.delete),
                title: new Text(
                  '계정삭제',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily:
                      "numberfont"),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: Delete_View()));
                },
              ),
            ),
          ],
        ));
  }
}
