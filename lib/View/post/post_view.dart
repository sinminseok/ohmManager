import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/post/detailview/post_write.dart';
import 'package:ohmmanager/View/post/widgets/post_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/postDto.dart';
import '../../Controller/postApi.dart';
import '../../Utils/constants.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  _PostView createState() => _PostView();
}

class _PostView extends State<PostView> {
  var results;
  Future? myfuture;
  bool gymcheck = false;

  Future<List<PostDto>?> load_posts() async {
    await check_gym();
    results = [];
    final prefs = await SharedPreferences.getInstance();

    if(prefs.get("gymId") == null){

    }else{
      results =
      await PostApi().findall_posts(prefs.getString("gymId").toString());
    }


    return results;
  }

  Future<bool> check_gym() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("gymId") == null) {
      setState(() {
        gymcheck =false;
      });

      return false;
    } else {
      setState(() {
        gymcheck =true;
      });
      return true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    myfuture = load_posts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.h),
        child: AppBar(
          iconTheme: IconThemeData(
            color: kTextColor, //change your color here
          ),
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "게시물",
                style: TextStyle(
                  fontSize: 21,
                  fontFamily: "lightfont",
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () async {
                        bool check = await check_gym();
                        if (check == false) {
                          showAlertDialog(context, "알림", "헬스장을 먼저 등록하세요");
                        } else {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostWrite_View()))
                              .then((value) {
                            setState(() {});
                          });
                        }
                      },
                      child: Icon(Icons.add)),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            gymcheck == false?Center(
              child: Container(
                  margin: EdgeInsets.only(top: 180.h),
                  child: Text("헬스장을 먼저 선택해주세요",style:  TextStyle(fontSize: 19.sp,fontFamily: "lightfont"),)),
            ):FutureBuilder(
                future: myfuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Container(
                      margin: EdgeInsets.only(top: 220.h),
                      child: spinkit2
                    );
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
                  }
                  // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                  else {
                    return results.length==0?Container(
                      margin: EdgeInsets.only(top: 220.h),
                      child: Center(
                          child: Text(
                            "게시물을 작성해보세요!",
                            style: TextStyle(fontSize: 18.sp, fontFamily: "lightfont"),
                          )),
                    ):Container(
                        width: 360.w,
                        height: 600.h,
                        child: ListView.builder(
                            itemCount: results.length,
                            itemBuilder: (BuildContext ctx, int idx) {
                              return Post_Widget(size, context, results[idx]);
                            }));
                  }
                }),
          ],
        ),
      ),
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
