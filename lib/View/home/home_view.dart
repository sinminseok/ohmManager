import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/date.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:ohmmanager/View/gym/edit/gymEdit_view.dart';
import 'package:ohmmanager/View/home/detailview/gymInfo_view.dart';
import 'package:ohmmanager/View/home/popup/edit_popup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/gymApi.dart';
import '../../Controller/managerApi.dart';
import '../../Model/gymDto.dart';
import '../../Utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'detailview/gymStatistics_View.dart';

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
  List<double> time_avg = [];

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

  Future<bool> get_gyminfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");

    var gym =
        await ManagerApi().gyminfo_byManager(userId, prefs.getString("token"));
    print("FGSGGDFS");

    if (gym == null) {
      print("nuddd");
      gymDto = null;
      return false;
    } else {
      print("object");
      setState(() {
        gymDto = gym;
      });
      await get_avg();
      print("objecasdt");
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
                Switch(
                  activeColor: Colors.grey,
                  value: select_mode,
                  onChanged: (value) {
                    setState(() {
                      select_mode = value;
                    });
                  },
                ),
                InkWell(
                    onTap: () {
                      if (gymDto == null) {
                        showtoast("헬스장을 먼저 등록해주세요");
                      } else {
                        Edit_Popup().showDialog(context, gymDto!);
                      }
                    },
                    child: Icon(
                      Icons.settings,
                      color: kTextWhiteColor,
                    )),
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.grey.shade200,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${snapshot.data}")


                            ],
                          ),
                        ),
                        Container(height: 30.h,),
                        Text("인터넷 연결중 ., ",style: TextStyle(fontFamily: "boldfont",fontSize: 18,color: kPrimaryColor),)
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
                                        fontFamily: "boldfont",
                                        fontWeight: FontWeight.bold,
                                        color: kTextColor),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ):select_mode == true
                        ? SingleChildScrollView(
                            child: GymStatistics_View(
                            current_datetime: current_datetime,
                            time_avg: time_avg,
                            current_count: gymDto?.current_count.toString(),
                          ))
                        : GymInfo_View(gymDto: gymDto);
                  }
                })
          ],
        )));
  }
}
