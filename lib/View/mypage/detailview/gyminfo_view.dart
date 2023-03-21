import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/gymApi.dart';
import '../../../Model/gymDto.dart';
import '../../../Model/gymPriceDto.dart';
import '../../../Model/gymTimeDto.dart';
import '../../../Utils/constants.dart';
import '../../home/popup/edit_popup.dart';
import '../widget/gymPrice_widget.dart';



class GymDetail_View extends StatefulWidget {
  GymDto gymDto;

  GymDetail_View({required this.gymDto});

  @override
  _GymDetail_View createState() => _GymDetail_View();
}

class _GymDetail_View extends State<GymDetail_View> {
  bool isChecked = false;
  GymTimeDto? gymTime;
  Future? myfuture;
  List<GymPriceDto> prices = [];

  @override
  void initState() {
    // TODO: implement initState
    myfuture = get_gymInfo();
    super.initState();
  }

  get_gymInfo() async{
    gymTime =await GymApi().getTime(widget.gymDto.id);
    prices =(await GymApi().getPrices(widget.gymDto.id))!;
    return prices;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: kTextColor, //change your color here
        ),
        // automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  Edit_Popup().showDialog(context, widget.gymDto!);
                },
                child: Icon(
                  Icons.settings,
                  color: kTextBlackColor,
                )),

          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
          future: myfuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.connectionState == false) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData == false) {
              return Center(child: CircularProgressIndicator());
            }
            //error가 발생하게 될 경우 반환하게 되는 부분
            else if (snapshot.hasError) {
              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator()),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:EdgeInsets.only(top: 10),
                      child:  Container(
                        width: 360.w,
                        height: 200.h,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),

                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.gymDto.imgs.length,
                            //widget.gymDto.imgs.length
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 15.w,right: 15.w),
                                height: 200.h,
                                width: 330.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                        awsimg_endpoint + widget.gymDto.imgs[index].filePath,
                                        fit: BoxFit.fill
                                    )),
                              );
                            }),),
                    ),



                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 30.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.gymDto.name}",
                            style: TextStyle(fontSize: 23.sp, fontFamily: "boldfont"),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.w, top: 10.h,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.gymDto.address}",
                            style: TextStyle(fontSize: 16.sp, fontFamily: "boldfont"),
                          ),

                        ],
                      ),
                    ),



                    Container(
                        margin: EdgeInsets.only(top: 10.h),
                        width: 360.w,
                        height: 140.h,
                        decoration: BoxDecoration(color: kContainerColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 15.w),
                              child: Text(
                                "센터 이용료",
                                style: TextStyle(
                                    fontSize: 17.sp, fontFamily: "boldfont",fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 360.w,
                              height: 90.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: prices.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              margin: EdgeInsets.all(10),
                                              child: GymPrice_Widget("${prices[index].during}", "${prices[index].price}")),
                                        )
                                      ],
                                    );
                                  }),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10.h),
                        width: 360.w,
                        height: 240.h,
                        decoration: BoxDecoration(color: kContainerColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 18.w),
                              child: Text(
                                "센터 운영시간",
                                style: TextStyle(
                                    fontSize: 17.sp, fontFamily: "boldfont",fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    gymTime?.monday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("월요일 : ${gymTime?.monday}")),
                                    gymTime?.tuesday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("화요일 : ${gymTime?.tuesday}")),
                                    gymTime?.wednesday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("수요일 : ${gymTime?.wednesday}")),
                                    gymTime?.thursday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("목요일 : ${gymTime?.thursday}")),
                                    gymTime?.friday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("금요일 : ${gymTime?.friday}")),
                                    gymTime?.saturday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),child: Text("토요일 : ${gymTime?.saturday}")),
                                    gymTime?.sunday == "00:00 ~ 00:00"?Container(): Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("일요일 : ${gymTime?.sunday}")),
                                    gymTime?.holiday == "00:00 ~ 00:00"?Container():Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("공휴일 : ${gymTime?.holiday}")),
                                    gymTime?.closeddays == null?Container():Container(
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: Text("휴관일 : ${gymTime?.closeddays}")),
                                  ],
                                ))
                          ],
                        )),

                    Container(

                        width: 360.w,
                        margin: EdgeInsets.only(top: 10.h,bottom: 20.h),
                        decoration: BoxDecoration(color: kContainerColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 18.w),
                              child: Text(
                                "센터 소개",
                                style: TextStyle(
                                    fontSize: 17.sp, fontFamily: "boldfont",fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 20, left: 20,right: 20,bottom: 20),
                                child: Text("${widget.gymDto.introduce}"))
                          ],
                        )),

                    SizedBox(height: 30,)
                  ],
                ),
              );
            }
          }),
    );
  }
}