import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/managerApi.dart';
import '../../Model/gymDto.dart';
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

    var gym = await ManagerApi()
        .gyminfo_byManager(userId, prefs.getString("token"));

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
                          Text("센터 이름",style: TextStyle(fontSize: 21),),
                          Text("센터 주소",style: TextStyle(fontSize: 21),),
                          Text("현재 센터 인원수",style: TextStyle(fontSize: 21),),
                          Text("센터 사진(최대5장)",style: TextStyle(fontSize: 21),),
                          Text("센터 한줄",style: TextStyle(fontSize: 21),),
                          Text("센터 소개",style: TextStyle(fontSize: 21),),

                          SizedBox(height: size.height*0.05,),
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
