import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/gymApi.dart';
import 'package:ohmmanager/Utils/sundry/toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/gym/gymPriceDto.dart';
import '../../../Provider/gymProvider.dart';
import '../../../Utils/sundry/constants.dart';
import 'finish_view.dart';

class GymRegisterView4 extends StatefulWidget {
  @override
  _GymRegisterView4 createState() => _GymRegisterView4();
}

class _GymRegisterView4 extends State<GymRegisterView4> {
  List<GymPriceDto> prices = [];

  TextEditingController _priceController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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

  @override
  Widget build(BuildContext context) {
    var _gymProvider = Provider.of<GymProvider>(context, listen: false);
    void _doSomething() async {
      if(prices.length == 0 ){
        showtoast("최소 한개 이상의 이용가격을 등록해주세요!");
        _btnController.stop();
      }else{
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var gymId =await GymApi().register_gym(token.toString(), _gymProvider.gymName.toString(), _gymProvider.gymAddress.toString(),int.parse(_gymProvider.gymCount.toString()) , _gymProvider.gymOneline.toString(), _gymProvider.gymCode.toString(), _gymProvider.gymIntroduce.toString(), _gymProvider.gymArea.toString());
          var register_time =await GymApi().register_time(gymId, token, _gymProvider.closedTime, _gymProvider.mondayTime.toString(), _gymProvider.tuesdayTime.toString(), _gymProvider.wednesdayTime.toString(), _gymProvider.thursdayTime.toString(), _gymProvider.fridayTime.toString(), _gymProvider.sundayTime.toString(), _gymProvider.saturdayTime.toString(), _gymProvider.holidayTime.toString());
        var save_gymimg =await GymApi().save_gymimg(token!, gymId!, _gymProvider.image_picked);
        var register_price =await GymApi().register_price(gymId, token, prices);
        if(register_price == null){
          return showtoast("서버오류");
        }else{
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: GymSave_Finish()));
        }
      }

    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: kIconColor, //change your color here
        ),
        shape: Border(bottom: BorderSide(color: Colors.black26, width: 0.3)),
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25, bottom: 15, top: 20.h),
                  child: Text(
                    "이용 가격",
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 23,
                        fontFamily: "lightfont",
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: size.width * 0.9,
                    height: 130.h,
                    decoration: BoxDecoration(
                        color: kContainerColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, top: 10, bottom: 10),
                                child: Text(
                                  "이용기간",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "lightfont",
                                      color: kTextColor),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    right: 15, top: 10, bottom: 10),
                                width: 100.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: kContainerColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                child: DropdownButton(
                                  isExpanded: true,
                                  //make true to take width of parent widget
                                  underline: Container(),
                                  //empty line
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  dropdownColor: kContainerColor,
                                  iconEnabledColor: Colors.black,
                                  //Icon color
                                  value: _selectedValue,
                                  items: _valueList.map(
                                        (value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Center(child: Text(value)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 15, top: 0, bottom: 10),
                                child: Text(
                                  "가격",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: "lightfont",
                                      fontWeight: FontWeight.bold,
                                      color: kTextColor),
                                )),
                            Row(
                              children: [
                                Container(
                                  margin:
                                  EdgeInsets.only(bottom: 10, right: 10),
                                  width: size.width * 0.25,
                                  height: size.height * 0.04,
                                  decoration: BoxDecoration(
                                      color: kBoxColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextFormField(
                                    keyboardType:
                                    TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                    controller: _priceController,
                                    textAlign: TextAlign.center,
                                    cursorColor: kContainerColor,
                                    decoration: InputDecoration(
                                        contentPadding:
                                        EdgeInsets.only(bottom: 10.h),
                                        hintText: "원",
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                    "원",
                                    style: TextStyle(fontSize: 18),
                                  ),
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
                            price: _priceController.text,
                            id: null);
                        prices.add(gymprice);
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
                SizedBox(
                  height: size.height * 0.05,
                ),
                Container(
                  width: size.width * 0.95,
                  margin: EdgeInsets.all(8),
                  height: 80.h,
                  child: ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: prices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: kContainerColor,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      child: Text(""),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 150.w),
                                        child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                prices.remove(prices[index]);
                                              });
                                            },
                                            child: Icon(Icons.cancel)))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20.w, top: 10.h),
                                        child: Text(
                                          "${prices[index].during}",
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontSize: 18.sp,
                                              fontFamily: "lightfont",
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20.w,
                                            top: 10.h,
                                            right: 20.w),
                                        child: Text(
                                          "${prices[index].price}원",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: "lightfont",
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                ),
                              ],
                            ));
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 135.h,
            ),
            RoundedLoadingButton(
              controller: _btnController,
              successColor: kTextBlackColor,
              color: kTextBlackColor,
              onPressed: _doSomething,
              child: Container(
                width: 330.w,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kButtonColor,
                ),


                alignment: Alignment.center,
                child: Text(
                  "다음",
                  style: TextStyle(
                      fontFamily: "lightfont",
                      color: kTextWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
