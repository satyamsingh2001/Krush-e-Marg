// import 'package:flutter/material.dart';
// import '../../../colors/colors_const.dart';
// import '../../../constwidgets/const_container.dart';
//
//
// class ConstPageView extends StatelessWidget {
//   final int pageCount;
//
//   const ConstPageView({super.key, required this.pageCount});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return PageView.builder(
//       itemCount: pageCount,
//       itemBuilder: (context, index) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ConstantContainer(
//                 child:Image.network("https://imgs.search.brave.com/YuURFlMn0gTr-E7cpdpEyBrycdj6Q0ZzgF2bKZoKDBY/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5zcHJvdXRzb2Np/YWwuY29tL3VwbG9h/ZHMvMjAyMi8wNi9w/cm9maWxlLXBpY3R1/cmUuanBlZw",fit: BoxFit.cover,width: size.width,),
//               ),
//             ),
//             // Background container with radius border
//             Positioned(
//               bottom: 10,
//               right: 10,
//               child: ConstantContainer(
//                 radiusBorder: 40,
//                 color: AppColors.white50,
//                 child: Center(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       "${index + 1}/$pageCount", // Page number
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }