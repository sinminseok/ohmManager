import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ohmmanager/Utils/constants.dart';

void showtoast(String message) async {
  Fluttertoast.showToast(
    msg: message,
    timeInSecForIosWeb: 2,
    textColor: kTextColor,
    backgroundColor: kBoxColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,



  );
}

showAlertDialog(BuildContext context, String title, String content) {
  // set up the AlertDialog
  Widget okButton = TextButton(
    child: Text("확인",style: TextStyle(color: kPrimaryColor),),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(title,style: TextStyle(fontFamily: "boldfont"),),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}