// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:zfffft/GeminiModelSummarizer/Api/summary_service.dart';
import 'package:zfffft/utils/app-constant.dart';

class Summarytext extends StatelessWidget {
  const Summarytext(
      {super.key,
      required this.summary,
      required this.fileName,
      this.isHistory = false});
  final String summary;
  final String fileName;
  final bool isHistory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Summary"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                summary,
                style: TextStyle(fontSize: 16),
              ),
              if (!isHistory) ...[
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final summaryService = SummaryService();
                      await summaryService.storSummary(summary, fileName);
                    },
                    child: Text('Save Summary')),
              ]
            ],
          ),
        ),
      ),
    );
  }
}