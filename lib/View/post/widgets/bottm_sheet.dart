

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/constants.dart';

class Bottom_Sheet extends StatelessWidget {
  const Bottom_Sheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130.h,
        color: kBackgroundColor,
        child: Column(
          children: [

            Container(
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
                onTap: () {

                },
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

                },
              ),
            ),
          ],
        ));
  }
}
