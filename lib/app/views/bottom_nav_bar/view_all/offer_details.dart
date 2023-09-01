// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../colors/colors_const.dart';
// import '../../../textstyles/textstyle_const.dart';
// class OffersDetails extends StatefulWidget {
//   final dynamic offer;
//   const OffersDetails({Key? key, this.offer}) : super(key: key);
//
//   @override
//   State<OffersDetails> createState() => _OffersDetailsState();
// }
//
// class _OffersDetailsState extends State<OffersDetails> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     offerDetails = widget.offer;
//   }
//
//   dynamic offerDetails;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.white10,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.white10,
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new_rounded,
//               color: AppColors.white90,
//             )),
//         title: Text(
//           'Offer Details',
//           style: AppTextStyles.kBody20SemiboldTextStyle
//               .copyWith(color: AppColors.white90),
//         ),
//       ),
//       body: ListView(
//         padding:  EdgeInsets.all(8.0),
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 300,
//             child: Card(
//               elevation: 2,
//               child: Column(
//                 children: [
//                   ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(3),
//                         topLeft: Radius.circular(3),
//                       ),
//                       child: Image.network(offerDetails['image_url'].toString(),fit: BoxFit.fill,height: 240,width: size.width,)),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             children: [
//                               Text('Code:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                               Text(offerDetails['code'].toString(),style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                             ],
//                           ),
//                           const VerticalDivider(color: AppColors.white40,thickness: 1,),
//                           Column(
//                             children: [
//                               Text('Discount upto:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                               Text(offerDetails['code'].toString(),style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                             ],
//                           ),
//                           const VerticalDivider(color: AppColors.white40,thickness: 1,),
//                           Column(
//                             children: [
//                               Text('Last Date:',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                               Text(offerDetails['code'].toString(),style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white50),),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           const Divider(),
//           const Text('Description:',style: AppTextStyles.kBody17SemiboldTextStyle,),
//           const SizedBox(height: 10,),
//           Text(offerDetails['discription'].toString()),
//
//           const Divider(color: AppColors.primary,height: 30,),
//           const Text('Terms & Condition:',style: AppTextStyles.kBody17SemiboldTextStyle,),
//           const SizedBox(height: 10,),
//           Text(offerDetails['term'].toString()),
//         ],
//       ),
//     );
//   }
// }
