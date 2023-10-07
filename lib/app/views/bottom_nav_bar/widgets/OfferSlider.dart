// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../const/api_string.dart';
// import '../../../controller/api_controller.dart';
//
// class OfferSlider extends StatefulWidget {
//   const OfferSlider({super.key});
//
//   @override
//   _OfferSliderState createState() => _OfferSliderState();
// }
//
// class _OfferSliderState extends State<OfferSlider> {
//   @override
//   void initState() {
//     super.initState();
//     // adminOffer();
//     // adminOfferController.adminOffer();
//   }
//
//   // AdminOfferController adminOfferController = Get.find();
//
//   // Future<List<String>> loadStrings() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   List<String>? strings = prefs.getStringList('strings');
//   //   return strings ?? [];
//   // }
//   // List fetchAdminOffer = [];
//   // Future<void> adminOffer() async {
//   //   List<String> storedStrings = await loadStrings();
//   //   String lat = storedStrings[0].toString();
//   //   String long = storedStrings[1].toString();
//   //
//   //   final response = await http.get(Uri.parse('$offerUrl+location/+$lat,$long'));
//   //   var offerData = jsonDecode(response.body);
//   //   print(offerData);
//   //   print('hoja');
//   //   if (offerData['status'] == 1) {
//   //     setState(() {
//   //       fetchAdminOffer = offerData['offers'];
//   //     });
//   //   } else {
//   //     throw Exception('Failed to load');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GetBuilder<AdminOfferController>(
//       builder: (adminOfferController) {
//         return SizedBox(
//           height: size.height * 0.375,
//           child: CarouselSlider.builder(
//             options: CarouselOptions(
//               height: size.height * 0.375,
//               enlargeCenterPage: true,
//               autoPlay: true,
//               aspectRatio: 16 / 9,
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: const Duration(milliseconds: 500),
//               viewportFraction: 0.75,
//             ),
//             itemCount: adminOfferController.fetchAdminOffer.length,
//             itemBuilder: (BuildContext context, int index, int realIndex) {
//               return Container(
//                 // margin: EdgeInsets.all(6.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   image: DecorationImage(
//                     image: NetworkImage(
//                         adminOfferController.fetchAdminOffer.isNotEmpty?
//                         adminOfferController.fetchAdminOffer[index]['image_url']??"":""
//                     ),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       }
//     );
//   }
// }
