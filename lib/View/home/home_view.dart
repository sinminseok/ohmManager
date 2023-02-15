import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/date.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:ohmmanager/View/home/widget/bar_widget.dart';
import 'package:ohmmanager/View/home/widget/gymInfo_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/managerApi.dart';
import '../../Model/gymDto.dart';
import '../../Utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'detailview/home_view2.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  GymDto? gymDto;
  var result;
  Future? myFuture;
  bool select_mode = false;
  var current_datetime;

  @override
  void initState() {
    // TODO: implement initState
    current_datetime = fillter(DateTime.now().toString());
    myFuture = get_gyminfo();
    super.initState();
  }

  final spinkit = SpinKitDoubleBounce(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: index.isEven ? kPrimaryColor : Colors.black26,
        ),
      );
    },
  );

  Future<GymDto?> get_gyminfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    print(userId);


    var gym =
        await ManagerApi().gyminfo_byManager(userId, prefs.getString("token"));

    if (gym == null) {
      return null;
    } else {
      setState(() {
        gymDto = gym;
      });
      return gymDto;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(38.h),
          child: AppBar(
            iconTheme: IconThemeData(
              color: kIconColor, //change your color here
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kBottomColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Switch(
                  activeColor: Colors.grey,
                  value: select_mode,
                  onChanged: (value) {
                    setState(() {
                      select_mode = value;
                    });
                  },
                )
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
            child: Column(
          children: [
            gymDto == null
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: GymRegisterView()));
                    },
                    child: Center(
                      child: Container(
                        width: size.width * 1,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.all(10),
                        child: Center(
                            child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.only(left: 25.0, right: 25),
                              decoration: BoxDecoration(
                                  color: kBoxColor, shape: BoxShape.circle),
                              child: Icon(
                                Icons.add,
                                color: kTextColor,
                              ),
                            ),
                            // Icon(Icons.turned_in_not,),
                            Text(
                              "헬스장 등록",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: kTextColor),
                            )
                          ],
                        )),
                      ),
                    ),
                  )
                : select_mode == true
                    ? Container()
                    : Container(),
            FutureBuilder(
                future: myFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: size.width * 1,
                          height: size.height * 0.64,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: spinkit,
                        )
                      ],
                    );
                  }

                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    return select_mode == true
                        ? SingleChildScrollView(
                            child: Home_View2(current_datetime: current_datetime,)
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: 360.w,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                      color: kBottomColor,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 10,right: 20),
                                            child: Icon(Icons.fitness_center,color: Colors.white,size: 55,),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 30,right: 20),
                                              child: Text(
                                                "${gymDto?.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kTextWhiteColor,
                                                    fontSize: 35),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                GymInfo_Widget("주소", "${gymDto?.address}"),
                                GymInfo_Widget("한줄소개", "${gymDto?.oneline_introduce}"),
                                GymInfo_Widget("헬스장 소개", "${gymDto?.introduce}"),

                                Container(
                                  width: 320.w,

                                  margin: EdgeInsets.only(top: 30),
                                  height: size.height*0.15,

                                  decoration: BoxDecoration(
                                    color: kBoxColor,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(left: 22.w,right: 20,top: 30.h),
                                              child: Text("현재 헬스장 인원수를 알려주는",style: TextStyle(fontSize: 18,color: kPrimaryColor,fontWeight: FontWeight.bold),)),
                                          Container(
                                              margin: EdgeInsets.only(left: 22.w,right: 20),
                                              child: Text("오헬몇",style: TextStyle(fontSize: 25,color: kPrimaryColor,fontWeight: FontWeight.bold),)),
                                        ],
                                      ),

                                      Icon(Icons.emergency_share,color: kPrimaryColor,size: 50,)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                              ],
                            ),
                          );
                  }
                })
          ],
        )));
  }
}
