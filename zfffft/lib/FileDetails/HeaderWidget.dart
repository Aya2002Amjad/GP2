
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:zfffft/models/file_model.dart';
import 'package:zfffft/utils/app-constant.dart';
import '../../Componant/BackButton.dart';

class FileDetailHeader extends StatefulWidget {
  
  final String coverUrl;
  final String title;
  final String description;
  final String pages;
  final String language;
  final String audioLen;
  final String fileId; // File document ID in Firestore
  final String fileurl;

  const FileDetailHeader({
    super.key,
    required this.coverUrl,
    required this.title,
    required this.description,
    required this.pages,
    required this.language,
    required this.audioLen,
    required this.fileId,
    required this.fileurl,
  });

  @override
  State<FileDetailHeader> createState() => _FileDetailHeaderState();
}

class _FileDetailHeaderState extends State<FileDetailHeader> {
  

void deleteDocument(String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection('File') // Replace with your collection name
        .doc(documentId) // The document ID of the document to delete
        .delete();

         await FirebaseFirestore.instance
        .collection('userFile') // Replace with your collection name
        .doc()
        .collection('Files')
        .doc('p28GAxUW8aKx0ExhCacp') // The document ID of the document to delete
        .delete();
     // Show a confirmation message using Get.snackbar
      Get.snackbar(
        'Success',
        'File deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor,
        colorText: Colors.white,
      );
    print("Document successfully deleted!");
  } catch (e) {
    print("Error deleting document: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackbutton(),
            IconButton(
              onPressed: () async {
               deleteDocument('Ls8WB15Q3uz74A2z9PfO');
              },
              icon: Icon(
                Icons.delete,
                color: AppConstant.appTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                widget.coverUrl,
                width: 170,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          widget.title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppConstant.appTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Pages',
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                Text(
                  widget.pages,
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Languages",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                Text(
                  widget.language,
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Audio",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                widget.audioLen.isEmpty
                    ? Text(
                        "No Audio for this file",
                        style: TextStyle(
                          color: AppConstant.appTextColor,
                          fontSize: 12,
                        ),
                      )
                    : Text(
                        widget.audioLen,
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}