// import 'package:flutter/material.dart';
// import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
//
// import '../../../colors/colors_const.dart';
//
// class CategoryWidgets extends StatefulWidget {
//   const CategoryWidgets({super.key});
//
//   @override
//   State<CategoryWidgets> createState() => _CategoryWidgetsState();
// }
//
// class _CategoryWidgetsState extends State<CategoryWidgets> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SizedBox(
//         height: 50,
//         // color: Colors.red,
//         child: Row(
//           children: [
//             const SizedBox(width: 10,),
//             SizedBox(
//               height: 45,
//               width: 50,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.white,
//                   ),
//                   onPressed: () {},
//                   child: const Icon(
//                     Icons.tune,
//                     color: AppColors.primary700,
//                     size: 20,
//                   )),
//             ),
//             CategoryButtons(
//               onpressed: () {},
//               text: 'Pure Veg',
//             ),
//             CategoryButtons(
//               onpressed: () {},
//               text: 'Non Veg',
//             ),
//
//             CategoryButtons(
//               onpressed: () {},
//               text: 'Distance',
//             ),
//
//             CategoryButtons(
//               onpressed: () {},
//               text: 'New Arrivals',
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryButtons extends StatefulWidget {
//   final VoidCallback onpressed;
//   final String text;
//   const CategoryButtons(
//       {super.key, required this.onpressed, required this.text});
//
//   @override
//   State<CategoryButtons> createState() => _CategoryButtonsState();
// }
//
// class _CategoryButtonsState extends State<CategoryButtons> {
//   bool _ispressed = false;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: SizedBox(
//         height: 45,
//         width: 130,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor:
//                     _ispressed ? AppColors.primary600 : AppColors.white),
//             onPressed: () {
//               setState(() {
//                 _ispressed = !_ispressed;
//               });
//             },
//             child: _ispressed
//                 ? Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           widget.text,
//                           style: AppTextStyles.kSmall10RegularTextStyle
//                               .copyWith(color: Colors.black, fontSize: 13),
//                         ),
//                         const Icon(
//                           Icons.close,
//                           color: AppColors.primary700,
//                         )
//                       ],
//                     ),
//                   )
//                 : Center(
//                     child: Text(
//                       widget.text,
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   )),
//       ),
//     );
//   }
// }
