

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohmmanager/View/mypage/detailview/question_view.dart';
import 'package:ohmmanager/View/mypage/mypage_view.dart';
import 'package:ohmmanager/View/post/post_view.dart';
import 'package:ohmmanager/View/trainer/trainer_view.dart';

import '../../Utils/widget/bottomnav_widget.dart';
import '../home/home_view.dart';
import '../question/question_view.dart';

class FrameView extends StatefulWidget {
  const FrameView({Key? key}) : super(key: key);

  @override
  _FrameView createState() => _FrameView();
}

class _FrameView extends State<FrameView> {

  int _selectedItem = 0;


  final screens = [
    HomeView(),
    PostView(),
    QuestionView(),
    TrainerView(),
    MypageView(),
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,


        bottomNavigationBar: CustomBottomNavigationBar(

          iconList: [
            Icons.fitness_center,
            Icons.speaker_notes_outlined,
            Icons.question_answer,
            Icons.group,
            Icons.person,
          ],
          onChange: (val) {
            setState(() {
              _selectedItem = val;
            });
          },
          defaultSelectedIndex: 0,
        ),
        body: screens[_selectedItem]);
  }
}