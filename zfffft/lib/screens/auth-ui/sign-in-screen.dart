// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, file_names, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zfffft/controllers/sign-in-controller.dart';
import 'package:zfffft/screens/auth-ui/forget-passowrd-screen.dart';
import 'package:zfffft/screens/auth-ui/sign-up-screen.dart';
import 'package:zfffft/screens/user-panel/main-screen.dart';

import '../../utils/app-constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

final SignInController _signInController = Get.put(SignInController());
TextEditingController userEmail = TextEditingController();
TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          centerTitle: true,
          title: Text(
            "Sign In",
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
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(()=>
                    TextFormField(
                      controller: userPassword,
                      obscureText: _signInController.isPasswordVisible.value,
                      cursorColor: AppConstant.appMainColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: (){
                              _signInController.isPasswordVisible.toggle();
                            },
                            child: _signInController.isPasswordVisible.value? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                            ),
                          contentPadding: EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    )
                  )),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap:() {
                    Get.to(()=> ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: AppConstant.appMainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
                    "SIGN IN",
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                  onPressed: () async {
                    String email = userEmail.text.trim();
                      String password = userPassword.text.trim();

                      // Input validation
                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar(
                            "Error",
                            "Please enter all details",
                           snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                          );
                      }
                      else{
                        UserCredential ? userCredential = await _signInController.signInMethod(email, password);
                        if(userCredential != null){
                          if(userCredential.user!.emailVerified){
                            Get.snackbar("Success " , "login Successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                            );
                            Get.offAll(()=>MainScreen());
                          }
                          else{
                             Get.snackbar("Error " , "Please verify your email before login",
                             snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                             );
                          }
                        }
                        else{
                          Get.snackbar("Error " , "Please try again",
                             snackPosition: SnackPosition.BOTTOM,
                           backgroundColor: AppConstant.appMainColor,
                            colorText: AppConstant.appTextColor,
                             );
                        }
                      }

                       
                  },
                ),
              ),
            ),
            SizedBox(
                height: Get.height / 20,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                style: TextStyle(color: AppConstant.appMainColor,
                ),
                ),
                GestureDetector(
                  onTap: ()=> Get.offAll(()=> SignUpScreen()),
                  child: Text("Sign Up",
                  style: TextStyle(
                    color: AppConstant.appMainColor,
                    fontWeight: FontWeight.bold,
                  
                  ),
                  ),
                ),

              ],
            )
            ],
          ),
        ),
      );
    });
  }
}
