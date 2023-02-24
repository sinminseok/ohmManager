import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/Model/gymDto.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:ohmmanager/Utils/constants.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/mypage/detailview/profile_edit.dart';
import 'package:ohmmanager/View/mypage/detailview/question_view.dart';
import 'package:ohmmanager/View/mypage/popup/bottm_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'detailview/ohm_introduce.dart';



class MypageView extends StatefulWidget {
  const MypageView({Key? key}) : super(key: key);

  @override
  _MypageViewState createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  Future? myFuture;
  TrainerDto? user;
  GymDto? gymDto;

  _callNumber() async{
    const number = '01083131764'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
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
  void initState() {
    // TODO: implement initState
    // get_userinfo();
    myFuture = get_userinfo();
    super.initState();
  }

  get_userinfo() async {
    print("dddddd");
    final prefs = await SharedPreferences.getInstance();
    user = await ManagerApi().get_userinfo(prefs.getString("token"));
    await get_gyminfo();
    return user;
  }

  //1고객센터,이용방법,Q&A,자주묻는 질문,유료회원 등록(추후 서비스)
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
            automaticallyImplyLeading: false,
            backgroundColor: kBackgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "내 정보",

                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "boldfont",color: kTextColor, fontSize: 21),
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Profile_BottomSheet();
                          });
                    },
                    child: Icon(Icons.settings))
              ],
            ),
            shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
            elevation: 0,
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder(
                future: myFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Container(
                      width: 330.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        color: kBoxColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Center(
                        child: Text("회원가입을 진행해주세요"),
                      ),
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
                    return Center(
                      child: Container(
                        width: 350.w,
                        height: 120.h,
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        margin: EdgeInsets.only(top: 0.h, left: 0),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5, left: 23),
                              width: size.width * 0.16,
                              height: size.height * 0.08,
                              child: CircleAvatar(
                                backgroundColor: kContainerColor,
                                backgroundImage: NetworkImage(
                                    "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                    EdgeInsets.only(top: 23.h, left: 20),
                                    child: Text(
                                      "${user?.nickname}",
                                      style: TextStyle(
                                        fontFamily: "boldfont",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                gymDto?.name == null?
                                Container(
                                margin:
                                EdgeInsets.only(top: 6.h, left: 20,bottom: 10),
                                child: Text(
                                "등록된 헬스장이 없습니다.",
                                style: TextStyle(
                                fontSize: 16,
                                ),
                                )):Container(
                                    margin:
                                    EdgeInsets.only(top: 6.h, left: 20,bottom: 10),
                                    child: Text(
                                      "${gymDto?.name}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          ),
                                    )),
                                InkWell(
                                  onTap: ()async{
                                    if(gymDto == null){
                                      showAlertDialog(context,"알림","헬스장을 먼저 등록하세요");
                                    }else{
                                      // Navigator.push(
                                      //     context,
                                      //     PageTransition(
                                      //         type: PageTransitionType.fade,
                                      //         child: Profile_Edit(user: user!, gymDto: gymDto!,)));
                                      bool isBack = await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => Profile_Edit(user: user!, gymDto: gymDto!,)));
                                      if (isBack) {
                                        setState(() {
                                          get_userinfo();

                                        });
                                      }
                                    }

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15.w, top: 5.h),
                                    width: 200.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child: Center(child: Text("프로필 관리")),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }),
            Container(
                margin: EdgeInsets.only(top: 30),
                width: 330.w,
                height: 50.h,
                decoration: BoxDecoration(
                    color: kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20.w, top: 3.h),
                        child: Icon(
                          Icons.support_agent,
                          size: 30,
                          color: kPrimaryColor,
                        )),
                    InkWell(
                      onTap: (){
                        _callNumber();
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 20.w, top: 5.h),
                          child: Text(
                            "고객센터",
                            style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: Question_View()));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 330.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: kBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20.w, top: 3.h),
                          child: Icon(
                            Icons.question_mark,
                            size: 30,
                            color: kPrimaryColor,
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20.w, top: 5.h),
                          child: Text(
                            "자주 묻는 질문",
                            style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: Introduce_View()));
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 330.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: kBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 20.w, top: 3.h),
                          child: Icon(
                            Icons.alarm,
                            size: 30,
                            color: kPrimaryColor,
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20.w, top: 5.h),
                          child: Text(
                            "오헬몇 이란?",
                            style: TextStyle(
                                fontSize: 17,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )),
            ),
            Center(
              child: InkWell(
                onTap: ()async{
                  showtoast("서비스 준비중입니다");
                  // 연결 페이지 URL 구하기
//                   Uri url = await TalkApi.instance.addChannelUrl('_WTJexj');
//                   print(url);
//
// // 연결 페이지 URL을 브라우저에서 열기
//                   try {
//                     await launchBrowserTab(url);
//                   } catch (error) {
//                     print('카카오톡 채널 추가 실패 $error');
//                   }
                },
                child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: 330.w,
                    height: 70.h,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20.w, top: 15.h),
                            child: Text(
                              "카카오톡으로 문의하기",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: kTextWhiteColor,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 20.w, top: 5.h),
                            child: Text(
                              "소중한 피드백을 보내주세요.",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: kTextWhiteColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    )),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
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
        )));
  }
}
