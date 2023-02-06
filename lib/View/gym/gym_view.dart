

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ohmmanager/View/gym/detailview/gym_register.dart';
import 'package:page_transition/page_transition.dart';

class GymView extends StatefulWidget {
  const GymView({Key? key}) : super(key: key);

  @override
  _GymView createState() => _GymView();
}

class _GymView extends State<GymView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130,
            ),
            InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: GymRegisterView()));
                },
                child: Text("data"))
          ],
        ),
      ),
    );
  }
}
