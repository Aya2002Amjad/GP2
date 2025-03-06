// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zfffft/utils/app-constant.dart';
import '../../Componant/BackButton.dart';

class FileDetailHeader extends StatelessWidget {
  const FileDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackbutton(),
            Icon(
              Icons.favorite,
              color: AppConstant.appTextColor,
            )
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assests/images/book.jpeg',
                width: 170,
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Text("Title"),
        Text("Title"),
        Text("Title"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Text("Hi"),
              Text("Hi"),
            ]),
            Column(children: [
              Text("Hi"),
              Text("Hi"),
            ]),
            Column(children: [
              Text("Hi"),
              Text("Hi"),
            ]),
          ],
        ),
      ],
    );
  }
}