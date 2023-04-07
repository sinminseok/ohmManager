import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Model/gym/gymDto.dart';
import 'package:ohmmanager/Utils/widget/buttom_container.dart';
import 'package:ohmmanager/Utils/sundry/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/gym/gymPriceDto.dart';
import '../../../Utils/sundry/toast.dart';
import '../../frame/frame_view.dart';

class GymPriceEdit_View extends StatefulWidget {
  GymDto? gymDto;

  GymPriceEdit_View({required this.gymDto});

  @override
  _GymPriceEdit_View createState() => _GymPriceEdit_View();
}

class _GymPriceEdit_View extends State<GymPriceEdit_View> {
  Future? myfuture;
  List<GymPriceDto> prices = [];
  List<GymPriceDto> add_prices = [];
  List<int?> delete_priceIds = [];
  TextEditingController _priceController = TextEditingController();

  final _valueList = [
    '1일',
    '1개월',
    '2개월',
    '3개월',
    '4개월',
    '5개월',
    '6개월',
    '7개월',
    '8개월',
    '9개월',
    '10개월',
    '11개월',
    '1년'
  ];
  var _selectedValue = '1일';

  bool check_date(String selected_day) {
    for (int i = 0; i < prices.length; i++) {
      if (prices[i].during == selected_day) {
        return false;
      }
    }
    return true;
  }

  Future<List<GymPriceDto>?> get_prices() async {
    final prefs = await SharedPreferences.getInstance();
    String? gymId = await prefs.getString("gymId");
    prices = (await GymApi().getPrices(int.parse(gymId!)))!;
    return prices;
  }

  @override
  void initState() {
    // TODO: implement initState
    myfuture = get_prices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        elevation: 0,
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: myfuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData == false) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 360.w,
                          height: 200.h,
                          decoration: BoxDecoration(
                              color: kContainerColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("wating.."),
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
                    return Column(

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 25, bottom: 15, top: 10),
                              child: Text(
                                "이용 가격",
                                style: TextStyle(
                                    color: kTextColor, fontSize: 19.sp),
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: size.width * 0.9,

                                decoration: BoxDecoration(
                                    color: kContainerColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                            margin:
                                            EdgeInsets.only(
                                                left: 15, top: 10, bottom: 10),
                                            child: Text(
                                              "이용기간",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTextColor),
                                            )),
                                        Container(
                                            margin:
                                            EdgeInsets.only(
                                                right: 15, top: 10, bottom: 10),
                                            width: 100.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                color: kContainerColor,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: DropdownButton(
                                              isExpanded: true,
                                              //make true to take width of parent widget
                                              underline: Container(),
                                              //empty line
                                              style: TextStyle(fontSize: 18,
                                                  color: Colors.black),
                                              dropdownColor: kContainerColor,
                                              iconEnabledColor: Colors.black,
                                              //Icon color
                                              value: _selectedValue,
                                              items: _valueList.map(
                                                    (value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Center(
                                                        child: Text(value)),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue = value!;
                                                });
                                              },
                                            )),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 15, top: 0, bottom: 20.h),
                                            child: Text(
                                              "가격",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTextColor),
                                            )),
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20, right: 10,),
                                              width: size.width * 0.25,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                  color: kBoxColor,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(10))),
                                              child: TextFormField(
                                                controller: _priceController,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                cursorColor: kTextBlackColor,
                                                decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(bottom: 10.h),
                                                    hintText: "-",
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,bottom: 20.h),
                                              child: Text("원", style: TextStyle(
                                                  fontSize: 16.sp),),
                                            )
                                          ],
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (_priceController.text == "") {
                                  return showtoast("가격을 입력주세요");
                                } else {
                                  var bool = check_date(_selectedValue);
                                  if (bool == false) {
                                    return showtoast("해당 기간은 이미 등록하셨습니다!");
                                  } else {
                                    GymPriceDto gymprice = new GymPriceDto(
                                        during: _selectedValue,
                                        price: _priceController.text, id: null);
                                    prices.add(gymprice);
                                    add_prices.add(gymprice);
                                    setState(() {
                                      _selectedValue = "1일";

                                      _priceController.text = "";
                                    });
                                    print(prices);
                                  }
                                }
                              },
                              child: Center(
                                child: Container(
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kContainerColor,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "등록",
                                    style: TextStyle(
                                        color: kTextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Container(
                              width: 340.w,
                              margin: EdgeInsets.all(8),
                              height: 120.h,
                              child: ListView.builder(reverse: true,

                                  scrollDirection: Axis.horizontal,
                                  itemCount: prices.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: (){

                                            setState(() {
                                              delete_priceIds?.add(prices[index].id);
                                              prices.remove(prices[index]);
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 160.w),
                                            child: Icon(Icons.cancel),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(8),

                                          height: 70.h,
                                          decoration: BoxDecoration(
                                              color: kContainerColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Text(
                                                    "${prices[index].during}",
                                                    style: TextStyle(
                                                        color: kTextColor,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight
                                                            .bold),)),
                                              Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Text(
                                                    "${prices[index].price}원",
                                                    style: TextStyle(
                                                        fontSize: 20),))
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),

                        SizedBox(height: 110.h),

                        InkWell(
                            onTap: () async{
                              final prefs = await SharedPreferences.getInstance();
                              bool? check;

                              if(add_prices.length == 0){

                              }else{
                                check = await GymApi().register_price(prefs.getString("gymId"), prefs.getString("token"),add_prices);
                              }


                             if(delete_priceIds.length == 0){

                             }else{
                               check = await GymApi().delete_price(prefs.getString("gymId"), prefs.getString("token"), delete_priceIds);
                             }

                             if(check == false){
                               Navigator.push(
                                   context,
                                   PageTransition(
                                       type: PageTransitionType.fade,
                                       child: FrameView()));

                             }else{
                               showtoast("가격 수정이 완료되었습니다");
                               Navigator.push(
                                   context,
                                   PageTransition(
                                       type: PageTransitionType.fade,
                                       child: FrameView()));
                             }



                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 20, bottom: 40),
                                child: Button("수정하기")))

                      ],
                    );
                  }
                }),

          ],
        ),
      ),
    );
  }
}
