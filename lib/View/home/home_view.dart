import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/managerApi.dart';
import '../../Model/gymDto.dart';
import '../../Utils/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  GymDto? gymDto;
  var result;
  Future? myFuture;

  @override
  void initState() {
    // TODO: implement initState
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
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "헬스장 정보",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                Icon(Icons.settings)
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: kPrimaryColor,
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
                                  margin: EdgeInsets.only(left: 25.0,right: 25),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.turned_in_not,color: kContainerColor,),
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
                : Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: size.width * 1,
                              height: size.height * 0.3,
                              child: Image.asset("assets/images/gym_img.png"));
                        }),
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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "센터 이름 :${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "센터 주소 :${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "현재 센터 인원수:${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "센터 사진(최대5장):${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "센터 한줄:${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          Text(
                            "센터 소개:${gymDto?.name}",
                            style: TextStyle(fontSize: 21),
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          Text("센터 정보 수정 버튼")
                        ],
                      ),
                    );
                  }
                })
          ],
        )));
  }
}
