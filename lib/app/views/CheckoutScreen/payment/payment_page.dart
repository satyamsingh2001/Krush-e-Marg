// import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../colors/colors_const.dart';
// import '../../../textstyles/textstyle_const.dart';
// import '../../profile_screen/Your Order/views/track_order.dart';
// import '../../wallet_Section/views/wallet_page.dart';
// class PaymentPage extends StatefulWidget {
//   const PaymentPage({Key? key}) : super(key: key);
//
//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.white,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: AppColors.white100,
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//          'Payment Options',
//           style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(
//             color: AppColors.white100,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: ListView(children: [
//           Row(
//            children: [
//              Text('To pay - ',style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white60),),
//              Text('₹195',style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.primary),),
//            ],
//           ),
//           const SizedBox(height: 10,),
//           ContainerWidget(
//               child: Container(
//                   color: AppColors.white20,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.white,
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset('assets/icons/wallet.png',height: 50,width: 50,),
//                             )),
//                         const SizedBox(width: 10,),
//                         Column(
//                           children: [
//                             Text('Total Balance',style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white50),),
//                             Text('₹5000',style: AppTextStyles.kHeading2TextStyle.copyWith(color: AppColors.primary),),
//                           ],
//                         ),
//                         const Spacer(),
//                         Column(
//                           children: [
//                             ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary), // Background color
//                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5), // Border radius
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: (){}, child: const Text('Pay Now')),
//                             ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor: MaterialStateProperty.all<Color>(AppColors.primary), // Background color
//                                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5), // Border radius
//                                     ),
//                                   ),
//                                 ),
//                                 onPressed: (){
//                                   Get.to(const WalletPageScreen());
//                                 }, child: const Text('Add Balance')),
//                           ],
//                         )
//                       ],
//                     ),
//                   ))),
//           const SizedBox(height: 10,),
//
//           GestureDetector(
//             onTap: (){
//               Get.to(const TrackOrder());
//             },
//             child: ContainerWidget(
//                 child: Container(
//                     color: AppColors.white20,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: AppColors.white,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset('assets/icons/cash.png',height: 50,width: 50,),
//                               )),
//                           const SizedBox(width: 10,),
//                           Column(
//                             children: [
//                               Text('Cash On Delivery',style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white50),),
//                               Text('Pay in Cash',style: AppTextStyles.kBody17SemiboldTextStyle.copyWith(color: AppColors.white90),),
//                             ],
//                           ),
//                           const Spacer(),
//                           const CircleAvatar(
//                             backgroundColor: AppColors.white30,
//                             radius: 20,
//                             child: Icon(Icons.arrow_forward_ios_rounded,size: 30,color: AppColors.primary,),
//                           )
//                         ],
//                       ),
//                     ))),
//           ),
//         ],),
//       ),
//     );
//   }
// }
