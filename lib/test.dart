// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'app/colors/colors_const.dart';
// import 'app/views/CheckoutScreen/controller/tip_controller.dart';
// import 'app/views/CheckoutScreen/widgets/tip_amount_container.dart';
//
// class TipScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select Tip Amount'),
//       ),
//       body: TipOptions(),
//     );
//   }
// }
//
// class TipOptions extends StatefulWidget {
//   @override
//   _TipOptionsState createState() => _TipOptionsState();
// }
//
// class _TipOptionsState extends State<TipOptions> {
//   TipController tipController = Get.put(TipController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<TipController>(
//       builder: (tipController) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 TipAmountContainer(
//                   amount: 5,
//                   isSelected: tipController.selectedTipIndex == 0,
//                   img: 'assets/icons/10star.png',
//                   onTap: () {
//                     if (tipController.selectedTipIndex == 0) {
//                       tipController.nonSelectedTip();
//                     } else {
//                       tipController.selectPresetTip(0, 5);
//                     }
//                   },
//                 ),
//                 TipAmountContainer(
//                   amount: 10,
//                   isSelected: tipController.selectedTipIndex == 1,
//                   img: 'assets/icons/15star.png',
//                   onTap: () {
//                     if (tipController.selectedTipIndex == 1) {
//                       tipController.nonSelectedTip();
//                     } else {
//                       tipController.selectPresetTip(1, 10);
//                     }
//                   },
//                 ),
//                 TipAmountContainer(
//                   amount: 15,
//                   isSelected: tipController.selectedTipIndex == 2,
//                   img: 'assets/icons/15star.png',
//                   onTap: () {
//                     if (tipController.selectedTipIndex == 2) {
//                       tipController.nonSelectedTip();
//                     } else {
//                       tipController.selectPresetTip(2, 15);
//                     }
//                   },
//                 ),
//                 GestureDetector(
//                   onTap: tipController.showCustomTip,
//                   child: Container(
//                     height: 30,
//                     width: 70,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(14),
//                       // color: selectedTipIndex == 3 ? Colors.blue : Colors.white,
//                       color: AppColors.white10,
//                     ),
//                     child: const Text(
//                       'Custom Tip',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             if (tipController.showCustomTipField)
//               TextFormField(
//                 controller: tipController.textEditingController..text = tipController.customTip.toString(),
//                 keyboardType: TextInputType.number,
//                 maxLength: 4,
//                 onEditingComplete: () {
//                   setState(() {
//                     tipController.showCustomTipField = !tipController.showCustomTipField;
//                     tipController.customTip = int.parse(tipController.textEditingController.text);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                   counterText: '',
//                   label: Text('Enter Tip Amount'),
//                   prefix: GestureDetector(
//                     onTap: (){
//                       setState(() {
//                         tipController.showCustomTipField = !tipController.showCustomTipField;
//                         tipController.customTip = int.parse(tipController.textEditingController.text);
//                       });
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         height: 30,
//                         width: 50,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: AppColors.success20,
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: const Text('Add',style: TextStyle(color: AppColors.white100),),
//                       ),
//                     ),
//                   ),
//                   suffix: IconButton(
//                       onPressed: () {
//                         tipController.textEditingController.clear();
//                         tipController.customTip = 0;
//                         setState(() {});
//                       },
//                       icon: Icon(
//                         Icons.cancel_outlined,
//                         color: AppColors.primary,
//                       )),
//                 ),
//               ),
//             Text('Custom Tip: ₹${tipController.customTip}'),
//           ],
//         );
//       }
//     );
//   }
// }
