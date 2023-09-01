// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart'as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../colors/colors_const.dart';
// import '../../../const/api_string.dart';
// import '../../../textstyles/textstyle_const.dart';
// import '../../shops/views/store_list.dart';
// class ViewAllCategories extends StatefulWidget {
//   const ViewAllCategories({Key? key}) : super(key: key);
//
//   @override
//   State<ViewAllCategories> createState() => _ViewAllCategoriesState();
// }
//
// class _ViewAllCategoriesState extends State<ViewAllCategories> {
//
//   late bool _loading;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchCategories();
//     _loading=true;
//   }
//
//   final TextEditingController _searchController = TextEditingController();
//
//   Future<List<String>> loadStrings() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? strings = prefs.getStringList('strings');
//     return strings ?? [];
//   }
//
//   List<Map<String, dynamic>> categoryNames = [];
//   Future<void> fetchCategories() async {
//     List<String> storedStrings = await loadStrings();
//     String lat = storedStrings[0].toString();
//     String long = storedStrings[1].toString();
//
//     final response = await http.get(Uri.parse('$categoryUrl+$lat,$long'));
//     if (response.statusCode == 200) {
//       setState(() {
//         categoryNames =
//         List<Map<String, dynamic>>.from(jsonDecode(response.body));
//       });
//       _loading=false;
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final imageUrl =
//     categoryNames.map((categoryNames) => categoryNames['image_url'] as String).toList();
//     return _loading
//         ? Container(
//       color: AppColors.white,
//           child:  Stack(
//             alignment: Alignment.center,
//             children: [
//               const SizedBox(
//                   height: 70,
//                   width: 70,
//                   child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2.5,)),
//               Image.asset('assets/images/applogo.png',height: 60,width: 60,),
//             ],
//           ),
//         )
//         :Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         toolbarHeight: 80,
//         automaticallyImplyLeading: false,
//         title: SizedBox(
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: size.width*0.9,
//                 child: TextFormField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                     fillColor: const Color.fromRGBO(203, 212, 225, 1),
//                     hintText: 'Search for any categories...',
//                     hintStyle: const TextStyle(fontSize: 14),
//                     prefixIcon: IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           color: AppColors.primary700,
//                         )),
//                     suffixIcon: IconButton(
//                       onPressed: (){},
//                       icon: const Icon(Icons.search,
//                           color: Color.fromRGBO(226, 62, 87, 1)),
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: AppColors.primary700,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: AppColors.primary700,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         color: AppColors.white40,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white10,
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//           child: GridView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: categoryNames.length,
//             gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               mainAxisSpacing: 6,
//               crossAxisSpacing: 6,
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: (){
//                   Get.to( StoreList(ModuleId: categoryNames[index]['module_id'].toString(),));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(6),
//                       border: Border.all(
//                         color: AppColors.white30,
//                       ),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: AppColors.white40,
//                             spreadRadius: 0.5,
//                             blurRadius: 1,
//                             offset: Offset(0, 1))
//                       ]),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Image.network(
//                        imageUrl[index].toString(),
//                         height: 50,
//                         width: 50,
//                       ),
//                       Text(
//                         categoryNames[index]['name'] ?? '',
//                         style: AppTextStyles.kSmall10RegularTextStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
