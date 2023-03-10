import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/date.dart';
import 'package:ohmmanager/View/home/popup/register_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/gymApi.dart';
import '../../Controller/adminApi.dart';
import '../../Model/gymDto.dart';
import '../../Model/statisticsDto.dart';
import '../../Utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'detailview/gymStatistics_View.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  GymDto? gymDto;
  Future? myFuture;
  var current_datetime;
  StatisticsDto? time_avg;

  @override
  void initState() {
    // TODO: implement initState
    current_datetime = fillter(DateTime.now().toString());
    myFuture = get_gyminfo();
    super.initState();
  }

  Future<bool> get_gyminfo() async {
    //메모리에 저장된 userId조회
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");

    var gym =
        await AdminApi().gyminfo_byManager(userId, prefs.getString("token"));

    if (gym == null) {
      gymDto = null;
      return false;
    } else {
      setState(() {
        gymDto = gym;
      });
      await get_avg();
      return true;
    }
  }

  get_avg() async {
    final prefs = await SharedPreferences.getInstance();
    time_avg =
        (await GymApi().get_timeavg(prefs.getString("gymId").toString()))!;
    return time_avg;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kIconColor, //change your color here
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kBottomColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          ),
          elevation: 0,
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder(
                future: myFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      children: [
                        Container(
                          width: 360.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: kBottomColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(0.0),
                                bottomLeft: Radius.circular(0.0)),
                          ),
                          child: spinkit2
                        ),
                        Container(
                          height: 30.h,
                        ),

                      ],
                    );
                  }
                  if (snapshot.hasData == false) {
                    return Text("${snapshot.data}");
                  }
                  //error가 발생하게 될 경우 반환하게 되는 부분
                  else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  } else {
                    return gymDto == null
                        ? Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Register_Popup().showDialog(context);
                                },
                                child: Center(
                                  child: Container(
                                    width: size.width * 1,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                        color: kContainerColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(10),
                                    child: Center(
                                        child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          margin: EdgeInsets.only(
                                              left: 25.0, right: 25),
                                          decoration: BoxDecoration(
                                              color: kBoxColor,
                                              shape: BoxShape.circle),
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
                                              fontFamily: "lightfont",
                                              fontWeight: FontWeight.bold,
                                              color: kTextColor),
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                              Container(
                                width: 340.w,
                                height: 450.h,
                                decoration: BoxDecoration(
                                    color: kBoxColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: spinkit,
                              )
                            ],
                          )
                        : SingleChildScrollView(
                        child: GymStatistics_View(
                          current_datetime: current_datetime,
                          time_avg: time_avg!,
                          current_count: gymDto?.current_count.toString(),
                        ));
                  }
                })
          ],
        )));
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
}
