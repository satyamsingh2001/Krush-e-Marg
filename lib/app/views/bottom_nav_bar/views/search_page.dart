// import 'package:flutter/material.dart';
// import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
// import '../../../colors/colors_const.dart';
// import '../../details_screen/explore_shop.dart';
// import '../widgets/category_widgets.dart';
//
// class SearchPage extends StatefulWidget {
//   final List<String> storeNames;
//
//   SearchPage({
//     Key? key,
//     required this.storeNames,
//   }) : super(key: key);
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchController = TextEditingController();
//   late List<String> _searchResults = [];
//
//   void _updateSearchResults(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         _searchResults = [];
//       } else {
//         final filteredStoreNames =
//             widget.storeNames.where((name) => name.contains(query)).toList();
//         _searchResults = filteredStoreNames;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(75.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           margin: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 11.0),
//               TextFormField(
//                 controller: _searchController,
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: 'Search for area, landmark',
//                   border: InputBorder.none,
//                   prefixIcon: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: const Icon(
//                       Icons.arrow_back_ios_new_outlined,
//                       color: AppColors.white60,
//                     ),
//                   ),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.cancel, color: AppColors.primary700),
//                     onPressed: () => _searchController.clear(),
//                   ),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                 ),
//                 onChanged: _updateSearchResults,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(bottom: 20.0, left: 20, right: 10),
//               child: CategoryWidgets(),
//             ),
//             SizedBox(height: 20.0),
//             _searchResults.isEmpty
//                 ? const Center(child: Text('No results found'))
//                 : Padding(
//                     padding: const EdgeInsets.only(left: 20.0, right: 20),
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: _searchResults.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ExploreShop(
//                                     itemName: _searchResults[index],
//
//                                     // Pass any other relevant data to the detail screen
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               height: 120,
//                               width: 328,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: AppColors.white20,
//                                   )),
//                               child: Row(
//                                 children: [
//                                   const SizedBox(
//                                     width: 20,
//                                   ),
//                                   ClipRect(
//                                     child:
//                                         Image.asset('assets/images/food2.png'),
//                                   ),
//                                   const SizedBox(
//                                     width: 30,
//                                   ),
//                                   Column(
//                                     children: [
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       Text(
//                                         _searchResults[index],
//                                         style: AppTextStyles
//                                             .kBody15SemiboldTextStyle,
//                                       ),
//                                       const Text(
//                                         'Fast Food, Street Food, Sandwich',
//                                         style: TextStyle(fontSize: 8),
//                                       ),
//                                       const Text(
//                                         'Paltan Bazar Kanwli Road',
//                                         style: TextStyle(fontSize: 8),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Column(
//                                             children: const [
//                                               Text(
//                                                 '4.5',
//                                                 style: AppTextStyles
//                                                     .kBody15SemiboldTextStyle,
//                                               ),
//                                               Text(
//                                                 'Reviews',
//                                                 style: TextStyle(fontSize: 8),
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 20,
//                                           ),
//                                           Column(
//                                             children: const [
//                                               Text(
//                                                 '52',
//                                                 style: AppTextStyles
//                                                     .kBody15SemiboldTextStyle,
//                                               ),
//                                               Text(
//                                                 'Products',
//                                                 style: TextStyle(fontSize: 8),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             width: 30,
//                                           ),
//                                           Column(
//                                             children: const [
//                                               Text(
//                                                 '1.2km',
//                                                 style: AppTextStyles
//                                                     .kBody15SemiboldTextStyle,
//                                               ),
//                                               Text(
//                                                 'Distance',
//                                                 style: TextStyle(fontSize: 8),
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
