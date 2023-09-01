// import 'package:krush_e_marg/app/colors/colors_const.dart';
// import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
// import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class DeliveryInstruction extends StatefulWidget {
//   const DeliveryInstruction({Key? key}) : super(key: key);
//
//   @override
//   State<DeliveryInstruction> createState() => _DeliveryInstructionState();
// }
//
// class _DeliveryInstructionState extends State<DeliveryInstruction> {
//
//  final List<String> title = ["No Contact \n Delivery","Beware of\n pets",'Do Not Ring\n The Bell'];
//  final List<String> img = ["assets/images/nocontact.png","assets/images/dog.png","assets/images/donotring.png"];
//  List<bool> selectedItems = List<bool>.generate(10, (index) => false);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ContainerWidget(
//         width: size.width,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Delivery Instruction',
//                 style: AppTextStyles.kBody17SemiboldTextStyle,
//               ),
//               Text(
//                 'Delivery partner will be notified ',
//                 style: AppTextStyles.kCaption12RegularTextStyle
//                     .copyWith(color: AppColors.white60),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                     itemCount: title.length,
//                     itemBuilder: (BuildContext contex,index){
//                   return GestureDetector(
//                     onTap: (){
//                       setState(() {
//                         selectedItems[index] = !selectedItems[index];
//                       });
//                       if (kDebugMode) {
//                         print(index);
//                       }
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 12),
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: selectedItems[index] ? AppColors.success10 : null,
//                         border: Border.all(color: AppColors.white30, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Image.asset(
//                               img[index],
//                               height: 50,
//                               width: 50,
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               alignment: Alignment.center,
//                               width: size.width,
//                               decoration: BoxDecoration(
//                                   color: selectedItems[index] ? AppColors.success20 :AppColors.white30,
//                                   borderRadius: const BorderRadius.only(
//                                       bottomLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15))),
//                               child:Text(
//                                 textAlign: TextAlign.center,
//                               title[index],
//                                 style: AppTextStyles.kBody15SemiboldTextStyle,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ));
//   }
// }
