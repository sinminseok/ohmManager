
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/Utils/buttom_container.dart';
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
        iconTheme: IconThemeData(
          color: kTextBlackColor, //change your color here
        ),
        title: Text("관리자 정보",style: TextStyle(fontWeight: FontWeight.bold,color: kTextBlackColor),),
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Scaffold(

            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kBackgroundColor,
                width: size.width,
                height: size.height * 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.all(20),
                          child: Text("센터에서의 역할을 선택해주세요!",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: kTextBlackColor),)),

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
                              margin: EdgeInsets.only(bottom: 15),
                              child: Button("관리자"))
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
                          child: Button("트레이너")
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
