// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart'; // To format the time
import 'package:zfffft/FileDetails/FileDetalis.dart';
import 'package:zfffft/controllers/FileController.dart';
import 'package:zfffft/screens/auth-ui/welcom-screen.dart';
import 'package:zfffft/utils/app-constant.dart';
import 'package:zfffft/wedgit/FileCard.dart';
import 'package:zfffft/wedgit/Search.dart';
import 'package:zfffft/wedgit/drawer-widget.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FileController fileController = Get.put(FileController());

    // Get user's first name
    String userName = fileController.fAuth.currentUser?.displayName ?? "";
    String firstName = userName.split(' ').first; // Getting only the first name

    // Get current hour to determine greeting
    int currentHour = DateTime.now().hour;
    String greeting = currentHour >= 5 && currentHour < 12
        ? "Good morning ☀️🌼✨,"
        : (currentHour >= 12 && currentHour < 18
            ? "Good afternoon 🌞,"
            : "Good evening 🌙,");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppConstant.appTextColor),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.signOut();
              await googleSignIn.signOut();
              Get.offAll(() => WelcomeScreen());
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          fileController.getUserFile();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Greeting Section
            Container(
              padding: EdgeInsets.all(10),
              color: AppConstant.appMainColor,
              height: Get.height / 4.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(greeting,
                          style: TextStyle(color: AppConstant.appTextColor)),
                      Text(firstName,
                          style: TextStyle(color: AppConstant.appTextColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Time to read files and enhance your knowledge",
                    style: TextStyle(
                        color: AppConstant.appTextColor, fontSize: 11),
                  ),
                  SizedBox(height: 20),
                  Search(),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Files:',
                    style: TextStyle(
                      color: AppConstant.appTextColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Display User-Uploaded Files
                  Obx(() {
                    if (fileController.currentUserFiles.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No files uploaded yet.',
                            style: TextStyle(color: AppConstant.appTextColor),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true, // Allow it to fit inside Column
                      physics:
                          NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                      itemCount: fileController.currentUserFiles.length,
                      itemBuilder: (context, index) {
                        final file = fileController.currentUserFiles[index];
                        return FileCard(
                          title: file.title!,
                          coverUrl: file.coverUrl!,
                          ontap: () => Get.to(FileDetails(file: file)),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}