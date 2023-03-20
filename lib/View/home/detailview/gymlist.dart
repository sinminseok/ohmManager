import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/constants.dart';

class GymList_View extends StatefulWidget {
  const GymList_View({Key? key}) : super(key: key);

  @override
  State<GymList_View> createState() => _GymList_ViewState();
}

class _GymList_ViewState extends State<GymList_View> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 360.w,
              height: 70.h,
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
          InkWell(
            onTap: () {
              // Navigator.push(
              // context,
              // PageTransition(
              // type: PageTransitionType.fade,
              // child: GymDetail_View(gymDto: widget.gymDto,)));
            },
            child: Container(
              margin: EdgeInsets.only(top: 0.h, bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: kBoxColor, width: 1.3),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    child: Container(
                      margin: EdgeInsets.only(top: 10.h),
                      width: 360.w,
                      height: 160.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          //widget.gymDto.imgs.length
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10.w, right: 10.w),
                              height: 350.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Image.network(
                                      "https://www.esongpa.or.kr/common/image/facility/facility2_2.jpg",
                                      fit: BoxFit.fill)),

                              // Image.network(
                              //     awsimg_endpoint + widget.gymDto.imgs[index].filePath,
                              //     fit: BoxFit.fill
                              // )
                            );
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, top: 10),
                    child: Text(
                      "gymname",
                      style: TextStyle(
                          color: kTextBlackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "boldfont"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, top: 5),
                    child: Text(
                      "gym address",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "lightfont"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.w, top: 5, bottom: 15),
                    child: Text(
                      "gym introudce",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "lightfont"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
