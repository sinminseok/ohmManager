

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/constants.dart';

class TrainerView extends StatefulWidget {
  const TrainerView({Key? key}) : super(key: key);

  @override
  _TrainerViewState createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kBackgroundColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/main_text.png',
                  fit: BoxFit.contain,
                  height: 40.h,
                ),
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
            child: Column(
              children: [
               Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: size.width * 1,
                            height: size.height * 0.3,
                            child: Image.asset("assets/images/gym_img.png"));
                      }),
                ),

              ],
            )));
  }
}
