// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../colors/colors_const.dart';
// import '../../../constwidgets/container_widget.dart';
// import '../../../textstyles/textstyle_const.dart';
//
// class AddMoreItems extends StatefulWidget {
//   const AddMoreItems({Key? key}) : super(key: key);
//
//   @override
//   State<AddMoreItems> createState() => _AddMoreItemsState();
// }
//
// class _AddMoreItemsState extends State<AddMoreItems> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ContainerWidget(child: Column(
//       children: [
//         const ListTile(
//           leading: Icon(
//             Icons.add,
//             color: AppColors.primary,
//           ),
//           title: Text('Add more item to this order'),
//           trailing: Icon(
//             Icons.arrow_forward_ios,
//             color: AppColors.white100,
//             size: 20,
//           ),
//         ),
//
//         Container(
//           height: size.height * 0.2,
//           decoration: const BoxDecoration(
//             border: Border(
//               top: BorderSide(color: AppColors.white30),
//               bottom: BorderSide(color: AppColors.white30),
//             )
//           ),
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 10,
//               itemBuilder: (BuildContext context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 1,vertical: 5),
//                   child: Card(
//                     elevation: 2,
//                     child: Container(
//                       width: size.width * 0.32,
//                       decoration: BoxDecoration(
//                         color: AppColors.white,
//                         border: Border.all(
//                             color: AppColors.white30,
//                             width: 0.5),
//                         borderRadius:
//                         BorderRadius.circular(5),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Stack(
//                           children: [
//                             Column(
//                               mainAxisAlignment:
//                               MainAxisAlignment
//                                   .spaceBetween,
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 Align(
//                                   child: Image.network(
//                                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNp1KUaU59BuDJdcUkX_Zw6zxOZ0yxSScvzQ&usqp=CAU',
//                                     height:
//                                     size.height * 0.07,
//                                   ),
//                                 ),
//                                 const Text(
//                                   'Leaves & flowers',
//                                   style: AppTextStyles
//                                       .kCaption12SemiboldTextStyle,
//                                 ),
//                                 Text(
//                                   '500g',
//                                   style: AppTextStyles
//                                       .kSmall10RegularTextStyle
//                                       .copyWith(
//                                     color:
//                                     AppColors.white60,
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment
//                                       .spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: const [
//                                     Text(
//                                       '₹30',
//                                       style: AppTextStyles
//                                           .kBody15SemiboldTextStyle,
//                                     ),
//                                     Card(
//                                       child: Icon(
//                                         Icons.add,
//                                         color: AppColors
//                                             .primary,
//                                         size: 25,
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                             const Positioned(
//                                 right: 0,
//                                 top: 0,
//                                 child: Icon(
//                                   CupertinoIcons.heart,
//                                   color: AppColors.white50,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//         ),
//       ],
//     ));
//   }
// }
