import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../controller/api_controller.dart';
import '../../shops/views/store_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    fetchCategories();
    // categoriesController.fetchCategories();
  }

  List<Map<String, dynamic>> categoryNames = [];
  Future<void> fetchCategories() async {
    List<String> storedStrings = await loadStrings();
    // String lat = storedStrings[0].toString();
    // String long = storedStrings[1].toString();
    String lat = '26.8467';
    String long = '80.9462';

    final response = await http.get(Uri.parse('$categoryUrl+$lat,$long'));
    categoryNames = List<Map<String, dynamic>>.from(jsonDecode(response.body));
    setState(() {});
  }

  // CategoriesController categoriesController = Get.find();
  // CategoriesController categoriesController = Get.put(CategoriesController());
  // Future<List<String>> loadStrings() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? strings = prefs.getStringList('strings');
  //   return strings ?? [];
  // }

  // List<Map<String, dynamic>> categoryNames = [];
  // Future<void> fetchCategories() async {
  //   List<String> storedStrings = await loadStrings();
  //   String lat = storedStrings[0].toString();
  //   String long = storedStrings[1].toString();
  //
  //   final response = await http.get(Uri.parse('$categoryUrl+$lat,$long'));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       categoryNames =
  //           List<Map<String, dynamic>>.from(jsonDecode(response.body));
  //     });
  //   } else {
  //     throw Exception('Failed to load categories');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final imageUrl = categoryNames
        .map((categoryNames) => categoryNames['image_url'] as String)
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoryNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return index < 8
              ? GestureDetector(
                  onTap: () {
                    Get.to(StoreList(
                      ModuleId: categoryNames[index]['module_id'].toString(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.white30,
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.white40,
                              spreadRadius: 0.5,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          imageUrl[index],
                          height: 50,
                          width: 50,
                        ),
                        Text(
                          categoryNames[index]['name'] ?? '',
                          style: AppTextStyles.kSmall10RegularTextStyle,
                        ),
                      ],
                    ),
                  ),
                )
              : null;
        },
      ),
    );
  }
}
