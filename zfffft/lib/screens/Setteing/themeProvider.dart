// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zfffft/screens/Setteing/Darkmode.dart';
import 'package:zfffft/screens/Setteing/lightmode.dart';

class Themeprovider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  } 
  
  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }

}