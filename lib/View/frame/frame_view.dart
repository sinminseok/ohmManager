

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohmmanager/View/gym/gym_view.dart';
import 'package:ohmmanager/View/mypage/mypage_view.dart';
import 'package:ohmmanager/View/post/post_view.dart';

import '../../Utils/widget/bottomnav_widget.dart';
import '../home/home_view.dart';

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
    GymView(),
    MypageView(),
  ];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,

        // drawer: Drawer(),

        bottomNavigationBar: CustomBottomNavigationBar(
          iconList: [
            Icons.home,
            Icons.speaker_notes_outlined,
            Icons.storefront,
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