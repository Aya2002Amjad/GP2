// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zfffft/controllers/PdfController.dart';
import 'package:zfffft/utils/app-constant.dart';

class FilePage extends StatelessWidget {
  const FilePage({super.key});

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppConstant.appTextColor,
        ),
        backgroundColor: AppConstant.appMainColor,
        title: Text('File Title',
        style: TextStyle(
          color: AppConstant.appTextColor,
        ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        pdfController.pdfViewerKey.currentState?.openBookmarkView();
      },
      child: Icon(Icons.bookmark),
      ),
      body: SfPdfViewer.network(
        'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
        key: pdfController.pdfViewerKey,
      ),
      );
  }
}
