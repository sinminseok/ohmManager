import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/Model/trainerDto.dart';
import 'package:ohmmanager/View/trainer/widget/trainer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/constants.dart';

class TrainerView extends StatefulWidget {
  const TrainerView({Key? key}) : super(key: key);

  @override
  _TrainerViewState createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView> {
  Future? myfuture;
  List<TrainerDto> trainers = [];
  bool delete = false;

  @override
  void initState() {
    // TODO: implement initState
    myfuture = get_trainers();
    super.initState();
  }

  get_trainers() async {
    final prefs = await SharedPreferences.getInstance();

    trainers = await ManagerApi().findall_trainer(prefs.get("gymId").toString());

    return trainers;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(40.h),
          child: AppBar(
            iconTheme: IconThemeData(
              color: kTextColor, //change your color here
            ),
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            shape: Border(
                bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.3
                )
            ),
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "트레이너",
                  style: TextStyle(fontSize: 21,
                      color: kTextColor,
                      ),
                ),

              ],
            ),

          ),
        ),
        backgroundColor: Colors.grey.shade200,
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
                          child: Text("등록된 트레이너가 없습니다."),
                        ),
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
                    return Container(
                      height: size.height * 1,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          itemCount: trainers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Trainer_Widget(size, context,trainers[index]);
                          }),
                    );
                  }
                })
          ],
        )));
  }
}


