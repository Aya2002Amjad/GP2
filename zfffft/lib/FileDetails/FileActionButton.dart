// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zfffft/FilePage/FilePage.dart';
import 'package:zfffft/utils/app-constant.dart';


class Fileactionbutton extends StatelessWidget {
  const Fileactionbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: AppConstant.appMainColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              Get.to(FilePage());
            },
            child: Row(
              children: [
                Icon(
                  Icons.my_library_books_sharp,
                  color: AppConstant.appTextColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("READ BOOK",
                    style:
                        TextStyle(color: AppConstant.appTextColor, fontSize: 20))
              ],
            ),
          ),
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(color: AppConstant.appTextColor),
          ),
          Row(
            children: [
              Icon(
                Icons.play_arrow_rounded,
                color: AppConstant.appTextColor,
                size: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Text("PLAY BOOK",
                  style:
                      TextStyle(color: AppConstant.appTextColor, fontSize: 20))
            ],
          )
        ],
      ),
    );
  }
}