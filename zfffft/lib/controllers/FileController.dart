// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:zfffft/models/file_model.dart';
import 'package:zfffft/utils/app-constant.dart';


class FileController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController pages = TextEditingController();
  TextEditingController aduioLen = TextEditingController();
  TextEditingController language = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;
  final fAuth = FirebaseAuth.instance;
  RxString imageUrl = ''.obs;
  RxString pdfUrl = ''.obs;
  int index = 0;
  RxBool isImageUploading = false.obs;
  RxBool isPdfUploading = false.obs;
  RxBool isPostUploading = false.obs;
  var fileData = RxList<FileModel>();
  var currentUserFiles = RxList<FileModel>();

  @override
  void onInit() {
    super.onInit();
    getAllFiles();
    getUserFile();
  }

  // Function to generate a unique Firebase-like ID
  String generateUniqueId() {
    return Uuid().v4(); // Generates a unique ID
  }

  // Fetch files uploaded by the user
  Future<void> getUserFile() async {
    currentUserFiles.clear(); // Clear the previous files list
    try {
      var files = await db
          .collection('userFile')
          .doc(fAuth.currentUser!.uid)
          .collection('Files')
          .get();

      for (var file in files.docs) {
        currentUserFiles.add(FileModel.fromJson(file.data()));
      }
    } catch (e) {
      print("Error fetching user files: $e");
    }
  }

  // Fetch all files (not just user's files)
  Future<void> getAllFiles() async {
    fileData.clear(); // Clear the previous files list
    try {
      var files = await db.collection('Files').get();
      for (var file in files.docs) {
        fileData.add(FileModel.fromJson(file.data()));
      }
    } catch (e) {
      print("Error fetching all files: $e");
    }
  }

  // Upload image function
  void pickImage() async {
    isImageUploading.value = true;
    final XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera); // image.gallery
    if (image != null) {
      uploadImageToFirebase(File(image.path));
    }
  }

  // Upload image to Firebase Storage
  void uploadImageToFirebase(File image) async {
    try {
      var uuid = Uuid();
      var filename = uuid.v1();
      var storageRef = storage.ref().child('Images/$filename');
      var response = await storageRef.putFile(image);
      String downloadURL = await storageRef.getDownloadURL();
      imageUrl.value = downloadURL;
    } catch (e) {
      print("Error uploading image: $e");
      Get.snackbar("Error", "Failed to upload image. Please try again.");
    } finally {
      isImageUploading.value = false; // Ensure it's set to false
    }
  }

  // Create a new file and upload it to Firestore
  void createFile() async {
    String fileId = generateUniqueId(); // Generate unique ID for the file

    isPostUploading.value = true;
    var newfile = FileModel(
      id: fileId,
      title: title.text,
      description: description.text,
      coverUrl: imageUrl.value,
      fileurl: pdfUrl.value,
      pages: int.parse(pages.text),
      language: language.text,
    );

    await db.collection('File').add(newfile.toJson());
    addFileInUserDb(newfile);
    isPostUploading.value = false;
    title.clear();
    description.clear();
    pages.clear();
    language.clear();
    aduioLen.clear();
    imageUrl.value = '';
    pdfUrl.value = '';
    Get.snackbar(
      'Success',
      "File added Successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppConstant.appMainColor,
      colorText: AppConstant.appTextColor,
    );
    getAllFiles();
    getUserFile();
  }

  // Add file to the user's collection in Firestore
  void addFileInUserDb(FileModel file) async {
    await db
        .collection('userFile')
        .doc(fAuth.currentUser!.uid)
        .collection('Files')
        .add(file.toJson());
  }

  // Pick a PDF file and upload it to Firebase Storage
  void pickPDF() async {
    try {
      isPdfUploading.value = true;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File file = File(result.files.first.path!);

        if (file.existsSync()) {
          Uint8List fileBytes = await file.readAsBytes();
          String fileName = result.files.first.name;

          var storageRef = storage.ref().child('Pdf/$fileName');
          await storageRef.putData(fileBytes);
          String downloadURL = await storageRef.getDownloadURL();
          pdfUrl.value = downloadURL;
        }
      }
    } catch (e) {
      print("Error uploading PDF: $e");
      Get.snackbar("Error", "Failed to upload PDF. Please try again.");
    } finally {
      isPdfUploading.value = false; // Ensure it's set to false
    }
  }
}