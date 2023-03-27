import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/View/frame/frame_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utils/constants.dart';

class DeleteManager_Finish extends StatefulWidget {
  const DeleteManager_Finish({Key? key}) : super(key: key);

  @override
  _DeleteManager_Finish createState() => _DeleteManager_Finish();
}

class _DeleteManager_Finish extends State<DeleteManager_Finish>  with TickerProviderStateMixin{

  late AnimationController scaleController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
  late Animation<double> scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
  late Animation<double> checkAnimation = CurvedAnimation(parent: checkController, curve: Curves.linear);
  @override
  void initState() {
    super.initState();
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        checkController.forward();
      }
    });
    scaleController.forward();
  }

  @override
  void dispose() {

    scaleController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double circleSize = 150;
    double iconSize = 108;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kTextColor,

      body: InkWell(
        onTap: (){
          // Navigator.pushNamedAndRemoveUntil(context, '/frame', (route) => false);
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => FrameView()), (route) => false);


        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.3,),
              Center(
                child: Text("해당 계정이 삭제 되었습니다!",style: TextStyle(fontFamily: "boldfont",fontSize: 22.sp,color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text("화면을 터치하면 메인페이지로 이동합니다.",style: TextStyle(fontSize: 17.sp,color: Colors.white,fontFamily: "lightfont"),),
              ),
              SizedBox(height: size.height*0.09,),
              ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  height: circleSize,
                  width: circleSize,
                  decoration: BoxDecoration(
                    color: kContainerColor,
                    shape: BoxShape.circle,
                  ),
                  child: SizeTransition(
                      sizeFactor: checkAnimation,
                      axis: Axis.horizontal,
                      axisAlignment: -1,
                      child: Center(
                          child: Icon(Icons.check, color: kTextColor, size: iconSize)
                      )
                  ),
                ),
              ),
              SizedBox(height: size.height*0.4,),

            ],
          ),
        ),
      ),
    );
  }
}