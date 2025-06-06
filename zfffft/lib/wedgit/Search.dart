// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zfffft/controllers/FileController.dart';
import 'package:zfffft/utils/app-constant.dart';


class Search extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onCancel;
  const Search({super.key, required this.onSearch, required this.onCancel});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FileController fileController = Get.find<FileController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstant.appTextColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.search , color: AppConstant.appMainColor,),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  fileController.clearSearch();
                } else {
                  fileController.searchFiles(value);
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search here ...',
                 hintStyle: TextStyle(color: AppConstant.appMainColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel , color: AppConstant.appMainColor,),
            onPressed: () {
              searchController.clear();
              fileController.clearSearch();
            },
          ),
        ],
      ),
    );
  }
}