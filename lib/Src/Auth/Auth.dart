import 'package:firebase_web_login/Src/Home/SignIn.dart';
import 'package:firebase_web_login/Src/Home/SignUp.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context)=>isLogin
      ? SignIn(onClickedSignUp: toggle,)
      : SignUp(onClickedSignUp: toggle,);
  void toggle()=>setState(()=>isLogin=!isLogin);
}
