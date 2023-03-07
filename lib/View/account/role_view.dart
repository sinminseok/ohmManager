import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/View/account/ceo/ceo_code.dart';
import 'package:ohmmanager/View/account/trainer/trainer_code.dart';
import 'package:page_transition/page_transition.dart';
import '../../Utils/constants.dart';
import 'manager/manager_code.dart';

class Role_View extends StatefulWidget {
  const Role_View({Key? key}) : super(key: key);

  @override
  _Role_View createState() => _Role_View();
}

class _Role_View extends State<Role_View> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kTextBlackColor, //change your color here
          ),
          title: Text(
            "",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: kTextBlackColor,fontFamily: "boldfont"),
          ),
          backgroundColor: Color(0xff2651f0).withAlpha(20),
          elevation: 0,
        ),
        body: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                    0.2,
                    0.4,
                    0.2,
                    0.7
                  ],
                      colors: [
                    Color(0xff2651f0).withAlpha(20),
                    Color(0xff2651f0).withAlpha(20),
                    Color(0xff2651f0).withAlpha(100),
                    Color(0xff2651f0).withAlpha(200),
                  ])),
              width: size.width,
              height: size.height * 1,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "센터에서의 역할을 선택해주세요!",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: "lightfont",
                            fontWeight: FontWeight.bold,
                            color: kTextBlackColor),
                      )),
                  SizedBox(
                    height: size.height * 0.5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: CEO_CodeView()));
                    },
                    child: Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Button("사장"))),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Manager_CodeView()));
                    },
                    child: Center(
                        child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Button("관리자"))),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Trainer_CodeView()));
                    },
                    child: Center(child: Button("트레이너")),
                  ),
                ],
              )),
            ),
          ),
        ));
  }
}
