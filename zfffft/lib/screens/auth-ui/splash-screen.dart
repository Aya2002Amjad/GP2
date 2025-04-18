// ignore_for_file: file_names, avoid_unnecessary_containers, override_on_non_overriding_member, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zfffft/screens/auth-ui/welcom-screen.dart';
import '../../utils/app-constant.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 
  @override
void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => WelcomeScreen());
    });
  }
 
 
  @override
  Widget build(BuildContext context) {
   // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.appMainColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        elevation: 0,
      ),
     body: Container(
      child: Column(
       children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Lottie.asset('assests/images/start.json'),),
        ),
       Container(
       // width: Get.width,
       margin: EdgeInsets.only(bottom: 20),
       alignment: Alignment.center,
        child: Text(
          AppConstant.appPoweredBy,
          style: TextStyle(color: AppConstant.appTextColor,
          fontSize: 12,
          fontWeight: FontWeight.bold
          ),
        ),
       ),
       ],
     ),),
    );
  }
}