import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohmmanager/Controller/managerApi.dart';
import 'package:ohmmanager/View/account/manager/signup_manager2.dart';
import 'package:ohmmanager/View/account/signup_trainer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/toast.dart';
import '../../../Utils/widget/passwordinput_widget.dart';
import '../../../Utils/widget/rouninput_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupView createState() => _SignupView();
}

class _SignupView extends State<SignupView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        title: Text("정보입력",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: kPrimaryColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: SizedBox(height: size.height * 0.01)),

                Container(

                  child: RoundedInput(
                      controller: _userIDController,

                      title: "아이디",
                     ),
                ),
                RoundedPasswordInput(
                  controller: _passwordController, hint: 'Password',title: "비밀번호",),
                RoundedPasswordInput(
                  controller: _checkpasswordController,
                  hint: 'check pw',title: "비밀번호 확인",),
                Container(

                  child: RoundedInput(
                      controller: _nicknameController,

                      title: "이름",
                     ),
                ),


                SizedBox(
                  height: size.height * 0.02,
                ),

                InkWell(
                  onTap: () async {
                    if(_userIDController.text == "" || _passwordController.text == "" || _nicknameController.text == ""){
                      return showtoast("정보를 모두 입력해주세요");
                    }else{
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: SignupView2(name: _userIDController.text, nickname: _nicknameController.text, password: _passwordController.text,)));
                    }



                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    margin: EdgeInsets.only(top: 340),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kContainerColor,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "다음",
                      style: TextStyle(color: kTextColor,fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          )
        ],
      ),
    );
  }
}
