
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Model/gymPriceDto.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
import 'package:ohmmanager/Utils/toast.dart';
import 'package:ohmmanager/View/gym/popup/check_price.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/constants.dart';

class GymRegisterView4 extends StatefulWidget {
  @override
  _GymRegisterView4 createState() => _GymRegisterView4();
}

class _GymRegisterView4 extends State<GymRegisterView4> {
  List<GymPriceDto> prices = [];

  TextEditingController _priceController = TextEditingController();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {


  }
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

  bool check_date(String selected_day){
    for(int i=0;i<prices.length;i++){
      if(prices[i].during == selected_day){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: kIconColor, //change your color here
          ),
          shape: Border(
              bottom: BorderSide(
                  color: Colors.black26,
                  width: 0.3
              )
          ),
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
                    margin: EdgeInsets.only(left: 25, bottom: 15,top: 20.h),
                    child: Text(
                      "이용 가격",
                      style: TextStyle(color: kTextColor, fontSize: 23,fontFamily: "lightfont",fontWeight: FontWeight.bold),
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
                                  margin:
                                  EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                  child: Text(
                                    "이용기간",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "lightfont",
                                        color: kTextColor),
                                  )),
                              Container(
                                  margin:
                                  EdgeInsets.only(right: 15, top: 10, bottom: 10),
                                  width: 100.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      color: kContainerColor,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    //make true to take width of parent widget
                                    underline: Container(),
                                    //empty line
                                    style: TextStyle(fontSize: 18, color: Colors.black),
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
                                  margin: EdgeInsets.only(left: 15, top: 0, bottom: 10),
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
                                    margin: EdgeInsets.only(bottom: 10, right: 10),
                                    width: size.width * 0.25,
                                    height: size.height * 0.04,
                                    decoration: BoxDecoration(
                                        color: kBoxColor,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                    child: TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                      controller: _priceController,
                                      textAlign: TextAlign.center,
                                      cursorColor: kContainerColor,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(bottom: 10.h),
                                          hintText: "원",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child:  Text("원",style: TextStyle(fontSize: 18),),
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
                      if(_priceController.text == ""){
                        return showtoast("가격을 입력주세요");
                      }else{
                        var bool = check_date(_selectedValue);
                        if(bool == false){
                          return showtoast("해당 기간은 이미 등록하셨습니다!");
                        }else{
                          GymPriceDto gymprice = new GymPriceDto(
                              during: _selectedValue, price: _priceController.text, id: null);
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
                  SizedBox(height: size.height*0.05,),
                  Container(
                    width: size.width*0.95,
                    margin: EdgeInsets.all(8),
                    height: 80.h,
                    child: ListView.builder(reverse: true,

                        scrollDirection: Axis.horizontal,
                        itemCount: prices.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(left: 10),


                            decoration: BoxDecoration(
                                color: kContainerColor,
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
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
                                            onTap: (){
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
                                        margin: EdgeInsets.only(left: 20.w,top: 10.h),
                                        child: Text("${prices[index].during}",style: TextStyle(color: kTextColor,fontSize: 18.sp,fontFamily: "lightfont",fontWeight: FontWeight.bold),)),
                                    Container(
                                        margin: EdgeInsets.only(left: 20.w,top: 10.h,right: 20.w),
                                        child: Text("${prices[index].price}원",style: TextStyle(fontSize: 18.sp,fontFamily: "lightfont",fontWeight: FontWeight.bold ),))
                                  ],
                                ),
                              ],
                            )
                          );
                        }),
                  ),
                ],
              ),

              SizedBox(height: 135.h,),


              InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  CheckPrice_Popup().showDialog(size, context,prices);

                  },
                child: Center(
                  child: Button("다음")
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
