import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/ManagerApiController.dart';
import '../../Model/GymDto.dart';
import '../../Utils/constants.dart';

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

  Future<GymDto?> get_gyminfo() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");

    var return_value = await ManagerApiController()
        .gyminfo_byManager(userId, prefs.getString("token"));

    if (return_value == null) {
      return null;
    } else {
      setState(() {
        gymDto = return_value;
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
            backgroundColor: kBackgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/main_text.png',
                  fit: BoxFit.contain,
                  height: 40.h,
                ),
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: kBackgroundColor,
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
                        margin: EdgeInsets.all(50),
                        child: Text("헬스장 등록"),
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
                          child: Text("등록된 헬스장이 없습니다"),
                        ),
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
                          Container(
                            child: Text(
                              "헬스장 이름 : ${gymDto?.name}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "헬스장 주소 : ${gymDto?.address}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "헬스장 인원수 : ${gymDto?.count}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "헬스장 소개 : ${gymDto?.introduce}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              "헬스장 한줄소개 : ${gymDto?.oneline_introduce}",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text("헬스장 상세 정보 보기버튼"),
                          ),
                          Container(
                            child: Text("헬스장 정보수정"),
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
