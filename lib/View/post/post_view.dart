import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Future<List<PostDto>?> load_posts() async {
    final prefs = await SharedPreferences.getInstance();
    results = await PostApi().findall_posts(prefs.getString("gymId").toString());
    return results;
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
                style: TextStyle(fontSize: 21,
                    color: kTextColor,
                   ),
              ),
              Row(
                children: [

                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: PostWrite_View()));
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
            FutureBuilder(
                future: load_posts(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Container(
                      margin: EdgeInsets.only(top: 100.h),
                      child: Center(child: Text("아직 등록된 게시물이 없습니다.",style: TextStyle(fontSize: 23),)),
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
                    return Container(
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
}
