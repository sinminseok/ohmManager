import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Utils/sundry/date.dart';
import 'package:ohmmanager/View/home/popup/register_popup.dart';
import 'package:ohmmanager/View/home/widget/gym_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/gymApi.dart';
import '../../Controller/adminApi.dart';
import '../../Model/gym/gymDto.dart';
import '../../Model/statistics/statisticsDto.dart';
import '../../Utils/sundry/constants.dart';
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
  //gym의 statistics 테이블 조회
  StatisticsDto? time_avg;
  //로그인된 계정이 ceo인지 manager인지 구분
  bool role_ceo = false;
  bool gym_null = false;
  //ceo 계정이 담을 gyms 리스트
  List<GymDto>? gyms= [];
  @override
  void initState() {
    // TODO: implement initState
    //현재 시간을 가져옴
    current_datetime = fillter(DateTime.now().toString());
    //로그인된 admin정보를 가져옴
    myFuture = get_gyminfo();
    super.initState();
  }

  Future<bool> get_gyminfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    //로그인된 계정 정보를 가져옴
    var trainerDto = await AdminApi().get_userinfo(prefs.getString("token"));

    if (trainerDto?.role == "ROLE_CEO") {
      setState(() {
        role_ceo = true;
      });

      final prefs = await SharedPreferences.getInstance();
      var gynId =await prefs.getString("gymId");
      if(gynId == null){
        gyms  =await AdminApi().findgyms_byceo(prefs.getString("userId"), prefs.getString("token"));
        return true;
      }else{
        var gg = await GymApi().search_byId(int.parse(gynId));
        if(gg == null){
          setState(() {
            gym_null = true;
          });

        }else{
          setState(() {
            gymDto = gg;
          });
          await get_avg();
        }

        return true;
      }


    }else{
      //일반 admin이 gyminfo를 가져옴 (단일 조회)
      var gym =
      await AdminApi().gyminfo_byManager(userId, prefs.getString("token"));

      //gym 정보가 아직 등록되지 않았을때
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


  }

  get_avg() async {
    final prefs = await SharedPreferences.getInstance();
    var ti =
        (await GymApi().get_timeavg(prefs.getString("gymId").toString()))!;
    setState(() {
      time_avg = ti;
    });
    return time_avg;
  }

  set_gym_ceo(String gymIdd)async{

    final prefs = await SharedPreferences.getInstance();

    var gymId = prefs.getString("gymId");

    if(gymId == null){
      prefs.setString("gymId", gymIdd);
      GymDto? searchgym =await GymApi().search_byId(int.parse(gymIdd));
      await get_avg();
      setState(() {
        gymDto = searchgym;
      });

    }else{
      prefs.remove("gymId");
      prefs.setString("gymId", gymIdd);
      GymDto? searchgym =await GymApi().search_byId(int.parse(gymIdd));
      await get_avg();
      setState(() {
        gymDto = searchgym;
      });
    }
  }

  reset_gym()async{


    setState(() {
      gymDto = null;
      gyms = null;
      time_avg = null;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("gymId");
    var ddd  =await AdminApi().findgyms_byceo(prefs.getString("userId"), prefs.getString("token"));
    setState(() {
      gyms = ddd;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: kIconColor, //change your color here
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kBottomColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                role_ceo!=true?Container():InkWell(
                    onTap: (){
                      reset_gym();
                    },
                    child: Icon(Icons.arrow_back)),
                gymDto == null?Container():role_ceo!=true?Container(
                  margin: EdgeInsets.only(left: 0),
                  child: Text("${gymDto?.name}",style: TextStyle(fontSize: 16.sp),),
                ):Container(
                  margin: EdgeInsets.only(right: 27.w),
                  child: Text("${gymDto?.name}",style: TextStyle(fontSize: 16.sp),),
                ),
                Container(

                )

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
                              child: spinkit2),
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
                                gyms == null?Container():Container(
                                  width: 350.w,
                                  height: 450.h,
                                  child: ListView.builder(
                                      itemCount: gyms?.length,
                                      itemBuilder: (BuildContext ctx, int idx) {
                                        return InkWell(
                                          onTap: (){

                                            set_gym_ceo(gyms![idx].id.toString());
                                          },
                                          child: Container(
                                          child: Gym_Container(size: size,gymDto: gyms![idx],),
                                          ),
                                        );
                                      }
                                  )
                                )

                              ],
                            )
                          : GymStatistics_View(
                        gymDto: gymDto,
                        current_datetime: current_datetime,
                        time_avg: time_avg!,
                        current_count: gymDto?.current_count.toString(),
                      );
                    }
                  })
            ],
          ))),
    );
  }



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
