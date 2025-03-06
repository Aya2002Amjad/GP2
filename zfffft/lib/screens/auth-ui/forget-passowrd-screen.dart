// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, file_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zfffft/controllers/forget-password-controller.dart';
import '../../utils/app-constant.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

final ForgetPasswordController _forgetPasswordController = Get.put(ForgetPasswordController());
TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            "Forget Password",
            style: TextStyle(
              color: AppConstant.appTextColor,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              isKeyboardVisible
                  ? Text("Welcom to my app")
                  : Column(
                      children: [Lottie.asset('assests/images/start.json')],
                    ),
             
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appMainColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  )),
              SizedBox(
                height: Get.height / 20,
              ),
              Material(
              child: Container(
                width: Get.width / 2,
                height: Get.height / 18,
                decoration: BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                  child: Text(
                    "Forget",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () async {
                    String email = userEmail.text.trim();

                      // Input validation
                      if (email.isEmpty ) {
                        Get.snackbar(
                            "Error",
                            "Please enter all details",
                           snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                      }

                     else{
                        String email = userEmail.text.trim();
                        _forgetPasswordController.ForgetPasswordMethod(email);
                     }  
                  },
                ),
              ),
            ),
            ],
          ),
        ),
      );
    });
  }
}
