import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ohmmanager/Controller/adminApi.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gym/gymDto.dart';
import 'package:ohmmanager/Model/account/managerDto.dart';
import 'package:ohmmanager/Utils/sundry/constants.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:ohmmanager/View/home/detailview/gymInfo_view.dart';
import 'package:ohmmanager/View/mypage/detailview/profile_edit.dart';
import 'package:ohmmanager/View/mypage/detailview/question_view.dart';
import 'package:ohmmanager/View/mypage/popup/bottm_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'detailview/gyminfo_view.dart';

class MypageView extends StatefulWidget {
  const MypageView({Key? key}) : super(key: key);

  @override
  _MypageViewState createState() => _MypageViewState();
}

class _MypageViewState extends State<MypageView> {
  Future? myFuture;
  TrainerDto? user;
  GymDto? gymDto;
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

  _callNumber() async {
    const number = '01083131764'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<bool> get_gyminfo_byuserId() async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    print("userIduserId");
    print(userId);

    var gym =
        await AdminApi().gyminfo_byManager(userId, prefs.getString("token"));

    if (gym == null) {
      return false;
    } else {
      setState(() {
        gymDto = gym;
      });

      return true;
    }
  }

  //ceo가 사용
  Future<bool> get_gyminfo_bygymId() async {
    final prefs = await SharedPreferences.getInstance();
    var gymId = prefs.getString("gymId");
    if (gymId == null) {
      return false;
    } else {
      var gym = await GymApi().search_byId(int.parse(gymId!));
      if (gym == null) {
        return false;
      } else {
        setState(() {
          gymDto = gym;
        });

        return true;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // get_userinfo();
    myFuture = get_userinfo();
    super.initState();
  }

  Future<bool> get_userinfo() async {
    final prefs = await SharedPreferences.getInstance();
    user = await AdminApi().get_userinfo(prefs.getString("token"));

    if (user?.role == "ROLE_CEO") {
      await get_gyminfo_bygymId();
    } else {
      await get_gyminfo_byuserId();
    }
    if (user == null) {
      return false;
    } else {
      return true;
    }
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
                InkWell(
                  onTap: () {
                    print(user);
                  },
                  child: Text(
                    "내 정보",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "lightfont",
                        color: kTextColor,
                        fontSize: 21),
                  ),
                ),
                InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Profile_BottomSheet();
                          });
                    },
                    child: Icon(Icons.settings,color: Colors.black,))
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
                    return Center(
                      child: Container(
                          width: 350.w,
                          height: 140.h,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                          margin: EdgeInsets.only(top: 0.h, left: 0),
                          child: spinkit2),
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
                        height: 130.h,
                        decoration: BoxDecoration(
                            color: kContainerColor,
                            borderRadius: BorderRadius.all(Radius.circular(0))),
                        margin: EdgeInsets.only(top: 0.h, left: 0),
                        child: user?.role == "ROLE_CEO"
                            ? Container(
                                child: Center(
                                    child: Text(
                                        "사장님정보는 회원들에게 노출되지 않습니다.\n트레이너 또는 직원 계정을 만들수있습니다!")),
                              )
                            : Row(
                                children: [
                                  user!.profile != null
                                      ? Container(
                                          margin:
                                              EdgeInsets.only(bottom: 30, left: 23),
                                          width: size.width * 0.16,
                                          height: size.height * 0.08,
                                          child: CircleAvatar(
                                            backgroundColor: kContainerColor,
                                            backgroundImage: NetworkImage(
                                                awsimg_endpoint +
                                                    user!.profile!),
                                          ),
                                        )
                                      : Container(
                                    margin: EdgeInsets.only(bottom: 30.h,left: 25.w),
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage("assets/images/basic_user.png"),
                                          fit: BoxFit.fitWidth
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: 23.h, left: 20),
                                          child: Text(
                                            "${user?.nickname}",
                                            style: TextStyle(
                                                fontFamily: "boldfont",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      gymDto?.name == null
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  top: 6.h,
                                                  left: 20,
                                                  bottom: 10),
                                              child: Text(
                                                "등록된 헬스장이 없습니다.",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ))
                                          : Container(
                                              margin: EdgeInsets.only(
                                                  top: 6.h,
                                                  left: 20,
                                                  bottom: 10),
                                              child: Text(
                                                "${gymDto?.name}",
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
                                              )),
                                      InkWell(
                                        onTap: () async {
                                          if (gymDto == null) {
                                            showAlertDialog(
                                                context, "알림", "헬스장을 먼저 등록하세요");
                                          } else {
                                            bool isBack = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile_Edit(
                                                          user: user!,
                                                          gymDto: gymDto!,
                                                        )));
                                            if (isBack) {
                                              setState(() {
                                                get_userinfo();
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 15.w, top: 5.h),
                                          width: 200.w,
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
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
                height: 60.h,
                decoration: BoxDecoration(
                    color: kBoxColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 20.w, top: 3.h),
                        child: Icon(
                          Icons.fitness_center,
                          size: 30,
                          color: kPrimaryColor,
                        )),
                    InkWell(
                      onTap: () async {
                        if (gymDto == null) {
                          showtoast("메인화면에서 헬스장을 선택해주세요!");
                        } else {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: GymDetail_View(
                                    gymDto: gymDto!,
                                  )));
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 15.w, top: 0.h),
                          child: Text(
                            "헬스장 정보",
                            style: TextStyle(
                                fontFamily: "lightfont",
                                fontSize: 18.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                width: 330.w,
                height: 60.h,
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
                      onTap: () async {
                        _callNumber();
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 15.w, top: 0.h),
                          child: Text(
                            "고객센터",
                            style: TextStyle(
                                fontFamily: "lightfont",
                                fontSize: 18.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                )),
            Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                Text(
                  "(주)코무무 | komumu",
                  style: TextStyle(color: Colors.black38),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4,bottom: 4),
                  child: Text(
                    "오헬몇 관리자 version 1.0.3",
                    style: TextStyle(color: Colors.black38),
                  ),
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
