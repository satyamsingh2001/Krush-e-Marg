// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:krush_e_marg/app/colors/colors_const.dart';
// import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
//
// import '../../../database/database_helper2.dart';
//
// class ShopProduct extends StatefulWidget {
//   final String? name;
//   final String? storeName;
//   final String? image;
//   final String? prise;
//   final String? quantity;
//   final int? varientLength;
//   final VoidCallback? onTap;
//   const ShopProduct(
//       {super.key,
//       this.name,
//       this.image,
//       this.prise,
//       this.quantity,
//       this.onTap,
//       this.varientLength,
//       this.storeName});
//
//   @override
//   State<ShopProduct> createState() => _ShopProductState();
// }
//
// class _ShopProductState extends State<ShopProduct> {
//   @override
//   Widget build(BuildContext context) {
//     String price = widget.prise.toString();
//     double productPrice = double.parse(price);
//     return Card(
//       elevation: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: widget.image != null
//                       ? Image.network(
//                           widget.image!,
//                           height: 70,
//                           // width: 70,
//                           fit: BoxFit.fill,
//                         )
//                       : const CircularProgressIndicator(
//                           strokeWidth: 3,
//                           color: AppColors.error20,
//                         ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: Icon(CupertinoIcons.heart),
//                 ),
//               ],
//             ),
//             Text(
//               widget.name!,
//               style: AppTextStyles.kBody15SemiboldTextStyle,
//             ),
//             GestureDetector(
//               onTap: widget.onTap!,
//               child: Row(
//                 children: [
//                   Text(
//                     widget.quantity!,
//                     style: AppTextStyles.kCaption12RegularTextStyle,
//                   ),
//                   widget.varientLength == 1
//                       ? Text('')
//                       : Icon(
//                           Icons.keyboard_arrow_down_rounded,
//                           color: AppColors.primary,
//                         )
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '₹${widget.prise!}',
//                   style: AppTextStyles.kCaption12SemiboldTextStyle,
//                 ),
//                 SizedBox(
//                   height: 40,
//                   width: 40,
//                   child: InkWell(
//                     onTap: () {
//                       fetchProducts();
//                       addProductToDatabase(
//                           widget.name.toString(),
//                           productPrice,
//                           productPrice,
//                           widget.storeName.toString(),
//                           widget.image.toString());
//                     },
//                     child: Card(
//                       elevation: 1,
//                       child: Icon(
//                         Icons.add,
//                         size: 18,
//                         color: AppColors.primary,
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
