
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/View/account/manager/signup_manager.dart';
import 'package:ohmmanager/View/account/signup_trainer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/constants.dart';
import '../../Utils/toast.dart';
import '../../Utils/widget/passwordinput_widget.dart';
import '../../Utils/widget/rouninput_widget.dart';

class Role_View extends StatefulWidget {
  const Role_View({Key? key}) : super(key: key);

  @override
  _Role_View createState() => _Role_View();
}

class _Role_View extends State<Role_View>
    with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Text("관리자 정보"),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: kPrimaryColor,
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kPrimaryColor,
                width: size.width,
                height: size.height * 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Text("센터에서의 역할을 선택해주세요!",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.white),)),

                     SizedBox(height: size.height*0.6,),

                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SignupView()));
                        },
                        child: Center(
                          child: Container(
                            width: size.width*0.9,
                            height: size.height*0.06,
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("관리자",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black),)),



                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: SignupTrainer()));
                        },
                        child: Center(
                          child: Container(
                            width: size.width*0.9,
                            height: size.height*0.06,
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("트레이너",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.black),)),



                          ),
                        ),
                      ),


                    ],
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
