import 'dart:async';

import 'package:architect/shared/constants/constants.dart';
import 'package:architect/shared/router/routes.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget{
  _SplashScreenPageState createState()=>_SplashScreenPageState();
}
class _SplashScreenPageState extends State<SplashScreenPage>{

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.popAndPushNamed(context, Routes.HOME);
    });
  }

  Widget build(BuildContext  context){
    return Scaffold(
      body: Center(
        child: Text(Constants.APP_NAME),
      ),
    );
  }
}