import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/constants.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key}) : super(key: key);

  @override
  _MypageViewState createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.notifications,color: Colors.grey,size: 30,)
              
            ],
          ),
          elevation: 0,
        ),
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 23),
                          width: size.width * 0.16,
                          height: size.height * 0.08,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                                "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "신민석",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 5, left: 10),
                          child: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    Container(
                        width: size.width * 0.9,
                        height: size.height * 0.07,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("케렌시아 센터 트레이너",style: TextStyle(fontSize: 18),))),
                    Container(
                        width: size.width * 0.9,
                        height: size.height * 0.07,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("카카오톡 문의하기",style: TextStyle(fontSize: 18),))),
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.35,
                        ),
                        Text("고객센터"),
                        Text("01091741764"),
                        SizedBox(
                          height: size.height * 0.014,
                        ),
                        Text(
                          "(주)코무무 | komumu",
                          style: TextStyle(color: Colors.black38),
                        ),
                        Text(
                          "@Copyright 신민석,김영솔",
                          style: TextStyle(color: Colors.black38),
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }
}
