// ignore_for_file: unused_field, body_might_complete_normally_nullable, non_constant_identifier_names, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:zfffft/screens/auth-ui/sign-in-screen.dart';
import 'package:zfffft/utils/app-constant.dart';

class ForgetPasswordController extends GetxController{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;
 
  Future<void> ForgetPasswordMethod(
    String userEmail,
  )async{
    try{
      EasyLoading.show(status: "Pleas wait...");
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        "Request Sent Sucessfully", 
        "Password reste link sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor, 
        colorText: AppConstant.appTextColor,
        );
        Get.offAll(()=>SignInScreen());
      EasyLoading.dismiss();
    }on FirebaseException catch(e){
      EasyLoading.dismiss();
      Get.snackbar(
        "Error", 
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor, 
        colorText: AppConstant.appTextColor,
        );
    }
  }
}