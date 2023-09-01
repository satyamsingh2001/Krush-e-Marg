// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart'as http;
// import 'package:krush_e_marg/app/colors/colors_const.dart';
// import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:krush_e_marg/app/views/bottom_nav_bar/view_all/offer_details.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../const/api_string.dart';
// import '../../../controller/api_controller.dart';
//
// class ViewAllOffers extends StatefulWidget {
//   const ViewAllOffers({Key? key}) : super(key: key);
//
//   @override
//   State<ViewAllOffers> createState() => _ViewAllOffersState();
// }
//
// class _ViewAllOffersState extends State<ViewAllOffers> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // adminOffer();
//     adminOfferController.adminOffer();
//   }
//
//   AdminOfferController adminOfferController = Get.find();
//
//   // List fetchOffer = [];
//   // Future<void> adminOffer() async {
//   //   List<String> storedStrings = await loadStrings();
//   //   String lat = storedStrings[0].toString();
//   //   String long = storedStrings[1].toString();
//   //
//   //   final response = await http.get(Uri.parse('$offerUrl+$lat,$long'));
//   //   var offerData = jsonDecode(response.body);
//   //   if (offerData['status'] == 1) {
//   //     setState(() {
//   //       fetchOffer = offerData['offers'];
//   //     });
//   //     _loading= false;
//   //   } else {
//   //     throw Exception('Failed to load');
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return adminOfferController.loading.value?Container(
//       alignment: Alignment.center,
//       color: AppColors.white,
//       child:  Stack(
//         alignment: Alignment.center,
//         children: [
//           const SizedBox(
//               height: 70,
//               width: 70,
//               child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2.5,)),
//           Image.asset('assets/images/applogo.png',height: 60,width: 60,),
//         ],
//       ),
//     ):Scaffold(
//       backgroundColor: AppColors.white10,
//       appBar: AppBar(
//         iconTheme:const IconThemeData(
//           color: AppColors.white100
//         ),
//         elevation: 0,
//         backgroundColor: AppColors.white10,
//         centerTitle: true,
//         title: Text(
//           'All Offers',
//           style: AppTextStyles.kBody20RegularTextStyle
//               .copyWith(color: AppColors.white90),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: ListView(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Stores with offers',
//               style: AppTextStyles.kBody15SemiboldTextStyle,
//             ),
//             Text(
//               'All Offers and Deals,From Stores Near You',
//               style: AppTextStyles.kCaption12RegularTextStyle
//                   .copyWith(color: AppColors.white60),
//             ),
//             GetBuilder<AdminOfferController>(
//               builder: (adminOfferController) {
//                 return ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                     itemCount: adminOfferController.fetchAdminOffer.length,
//                     itemBuilder: (BuildContext context,index){
//                     final offer = adminOfferController.fetchAdminOffer[index];
//                     var date = offer['endDate'].toString();
//                     String lastDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: (){
//                           Get.to(OffersDetails(
//                             offer: offer,
//                           ));
//                         },
//                         child: SizedBox(
//                           height: 300,
//                           child: Card(
//                             elevation: 2,
//                             child: Column(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(3),
//                                     topLeft: Radius.circular(3),
//                                   ),
//                                     child: Image.network(offer['image_url'].toString(),fit: BoxFit.fill,height: 240,width: size.width,)),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         Column(
//                                           children: [
//                                             Text('Code:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                                             Text(offer['code'].toString(),style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                                           ],
//                                         ),
//                                         const VerticalDivider(color: AppColors.white40,thickness: 1,),
//                                         Column(
//                                           children: [
//                                             Text('Discount upto:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                                             Text('₹${offer['discount']}',style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                                           ],
//                                         ),
//                                         const VerticalDivider(color: AppColors.white40,thickness: 1,),
//                                         Column(
//                                           children: [
//                                             Text('Last Date:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                                             Text(lastDate,style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 15,),
//                     ],
//                   );
//                 });
//               }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
