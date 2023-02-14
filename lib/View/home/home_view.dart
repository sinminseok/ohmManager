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
          preferredSize: Size.fromHeight(40.h),
          child: AppBar(
            iconTheme: IconThemeData(
              color: kIconColor, //change your color here
            ),
            shape:
                Border(bottom: BorderSide(color: Colors.black26, width: 0.3)),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                select_mode == true
                    ? Text(
                        "헬스장 현황",
                        style: TextStyle(
                            fontSize: 21,
                            color: kTextColor,
                            ),
                      )
                    : Text(
                        "헬스장 정보",
                        style: TextStyle(
                            fontSize: 21,
                            color: kTextColor,
                           ),
                      ),
                Switch(
                  activeColor: kTextColor,
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ],
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
                                  color: kPrimaryColor, shape: BoxShape.circle),
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
                    : Container(
                        child: CarouselSlider.builder(
                          itemCount: 3,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: size.height * 0.35,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 2),
                            reverse: false,
                          ),
                          itemBuilder: (context, i, id) {
                            //for onTap to redirect to another screen
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                //ClipRRect for image border radius
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.asset(
                                        "assets/images/gym_img.png")),
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
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
                            child: Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        right: 210.w, bottom: 10, top: 20),
                                    child: Text(
                                      "현재 헬스장 인원",
                                      style: TextStyle(
                                          fontSize: 19, color: kTextColor),
                                    )),
                                Container(
                                    width: 340.w,
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                        color: kContainerColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 30.h,top: 15),
                                            child: Text(
                                              "$current_datetime",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          Center(child: Text("약 14 명",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: kTextColor),))
                                        ])),
                                Container(
                                    margin: EdgeInsets.only(
                                        right: 200.w, bottom: 10, top: 20),
                                    child: Text(
                                      "시간별 인원 평균수",
                                      style: TextStyle(
                                          fontSize: 19, color: kTextColor),
                                    )),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                                    width: 340.w,
                                    height: 180.h,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Center(
                                          child: Container(
                                            height: size.height * 0.25,
                                            decoration: BoxDecoration(
                                                color: kContainerColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: charts.BarChart(
                                              Bar_Widget.time_data(),
                                              animate: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        right: 200.w, bottom: 10, top: 20),
                                    child: Text(
                                      "요일별 인원 평균수",
                                      style: TextStyle(
                                          fontSize: 19, color: kTextColor),
                                    )),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                                    width: 340.w,
                                    height: 180.h,

                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Center(
                                          child: Container(
                                            height: size.height * 0.25,
                                            decoration: BoxDecoration(
                                                color: kContainerColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: charts.BarChart(
                                              Bar_Widget.time_data(),
                                              animate: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                GymInfo_Widget("헬스장 이름", gymDto?.name),
                                GymInfo_Widget("헬스장 주소", gymDto?.address),
                                GymInfo_Widget("회원수", gymDto?.count.toString()),
                                GymInfo_Widget(
                                    "한줄 소개", gymDto?.oneline_introduce),
                                GymInfo_Widget("헬스장 소개", gymDto?.introduce),
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
