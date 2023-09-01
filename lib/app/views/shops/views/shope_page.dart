import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../bottom_nav_bar/widgets/banner_pageview.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List testImg = [
    'assets/test_img/img.png',
    'assets/test_img/img_1.png',
    'assets/test_img/img_2.png',
    'assets/test_img/img_3.png',
    'assets/test_img/img_4.png',
    'assets/test_img/img_5.png',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 80,
        title: SizedBox(
          height: 50,
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.7,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    fillColor: const Color.fromRGBO(203, 212, 225, 1),
                    hintText: 'Search for any categories',
                    hintStyle: const TextStyle(fontSize: 14),
                    suffixIcon:
                        const Icon(Icons.search, color: AppColors.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: AppColors.white40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
              onTap: () {},
              child: const Icon(
                Icons.notifications,
                color: AppColors.primary,
              )),
          const SizedBox(
            width: 12,
          ),
          InkWell(
              onTap: () {},
              child: const Icon(
                Icons.shopping_cart,
                color: AppColors.primary,
              )),
          const SizedBox(
            width: 12,
          )
        ],
        elevation: 0,
        backgroundColor: AppColors.white10,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: testImg.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.white30,
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: AppColors.white40,
                                spreadRadius: 0.5,
                                blurRadius: 1,
                                offset: Offset(1, 1))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              testImg[index],
                              height: 60,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Text(
                            'category',
                            style: AppTextStyles.kCaption12RegularTextStyle,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            //recommended product
            title('Recommended Products', () {}),
            SizedBox(
              height: size.height * 0.25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: additionalProduct.length,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, index) {
                    // final product = additionalProduct[index];
                    // var varientsDetails =
                    // product['variantDetails'].toString();
                    // var output = jsonDecode(varientsDetails);
                    // var productName =
                    // product['name'].toString();
                    // var productId = product['id'].toString();
                    // var productimg =
                    // product['image_url'].toString();
                    // var productAttributes =
                    // product['attribute']['name']
                    //     .toString();
                    //
                    // var type = output[0]["type"].toString();
                    // var mrp = double.parse(
                    //     output[0]["price"].toString());
                    // var discountType =
                    // output[0]["discountType"].toString();
                    // var discount = double.parse(
                    //     output[0]["discount"].toString());
                    // var price = discountType == 'amount'
                    //     ? mrp - discount
                    //     : mrp - ((mrp * discount) / 100);
                    // var unit = output[0]["unit"].toString();
                    //
                    // bool show = false;
                    // if (productList.isNotEmpty) {
                    //   for (var i = 0;
                    //   i < productList.length;
                    //   i++) {
                    //     var databasePID =
                    //         productList[i].productId;
                    //     quant = List.generate(
                    //         additionalProduct.length,
                    //             (index) =>
                    //         productList[i].quantity);
                    //     var databasePsize =
                    //         productList[i].size;
                    //     if (databasePID ==
                    //         product['id'].toString() &&
                    //         databasePsize ==
                    //             int.parse(type)) {
                    //       show = true;
                    //       break;
                    //     }
                    //   }
                    // }

                    return SizedBox(
                      width: 125,
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child:
                                        // Image.network(
                                        //   product['image_url']
                                        //       .toString(),
                                        //   height: 70,
                                        //   // width: 70,
                                        //   fit: BoxFit.fill,
                                        // )
                                        Image.asset(
                                            'assets/images/applogo.png'),
                                  ),
                                ],
                              ),
                              const Text(
                                // product['name'].toString(),
                                "Product Name",
                                style: AppTextStyles.kBody15SemiboldTextStyle,
                              ),
                              GestureDetector(
                                // onTap: () {
                                //   Get.bottomSheet(
                                //     SingleChildScrollView(
                                //       physics:
                                //       const NeverScrollableScrollPhysics(),
                                //       child:
                                //       VarientBottmSheet(
                                //         StoreName:
                                //         productList[0]
                                //             .storeName
                                //             .toString(),
                                //         pId: productId,
                                //         storeId: storeID,
                                //         pAttributes:
                                //         productAttributes,
                                //         varientsDetails:
                                //         output,
                                //         productImg:
                                //         productimg,
                                //         productName:
                                //         productName,
                                //       ),
                                //     ),
                                //   );
                                // },
                                child: Row(
                                  children: [
                                    const Text(
                                      // type + unit,
                                      "1 Pic",
                                      style: AppTextStyles
                                          .kCaption12RegularTextStyle,
                                    ),
                                    // output.length == 1
                                    //     ? const Text('')
                                    //     : const Icon(
                                    //   Icons
                                    //       .keyboard_arrow_down_rounded,
                                    //   color: AppColors
                                    //       .primary,
                                    // )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        // '₹${price.toInt()}',
                                        "99",
                                        style: AppTextStyles
                                            .kCaption12SemiboldTextStyle,
                                      ),
                                      Text(
                                        // '₹${mrp.toInt()}',
                                        "100",
                                        style: AppTextStyles
                                            .kSmall10RegularTextStyle
                                            .copyWith(
                                                color: AppColors.white60,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                  // !show
                                  //     ?
                                  const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                        // onTap: () {
                                        //   if (productList
                                        //       .isEmpty ||
                                        //       productList[0]
                                        //           .storeId ==
                                        //           storeID) {
                                        //     addProductToDatabase(
                                        //         productName,
                                        //         price,
                                        //         mrp,
                                        //         productList[0]
                                        //             .storeName
                                        //             .toString(),
                                        //         productimg,
                                        //         int.parse(
                                        //             type),
                                        //         productId,
                                        //         storeID,
                                        //         unit,
                                        //         1,
                                        //         productAttributes);
                                        //   } else {
                                        //     showDialog(
                                        //       context:
                                        //       context,
                                        //       builder:
                                        //           (BuildContext
                                        //       context) {
                                        //         return ConstAlert(
                                        //           addedStore: productList[0]
                                        //               .storeName
                                        //               .toString(),
                                        //           toAddStore: productList[0]
                                        //               .storeName
                                        //               .toString(),
                                        //           replaceOntap:
                                        //               () {
                                        //             deleteProduct();
                                        //             addProductToDatabase(
                                        //                 productName,
                                        //                 price,
                                        //                 mrp,
                                        //                 productList[0].storeName.toString(),
                                        //                 productimg,
                                        //                 int.parse(type),
                                        //                 productId,
                                        //                 storeID,
                                        //                 unit,
                                        //                 1,
                                        //                 productAttributes);
                                        //             Get.back();
                                        //             setState(() {
                                        //               fetchProducts();
                                        //             });
                                        //           },
                                        //         );
                                        //       },
                                        //     );
                                        //   }
                                        //   fetchProducts();
                                        //   setState(
                                        //           () {});
                                        // },
                                        child: Card(
                                      elevation: 1,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: AppColors.primary,
                                      ),
                                    )),
                                  )
                                  //     : CounterWidget(
                                  //   height:
                                  //   size.height *
                                  //       0.032,
                                  //   width: size.width *
                                  //       0.18,
                                  //   plusOntap: () {
                                  //     for (var i = 0;
                                  //     i <
                                  //         productList
                                  //             .length;
                                  //     i++) {
                                  //       var productId =
                                  //           productList[
                                  //           i]
                                  //               .productId;
                                  //       var productSize =
                                  //           productList[
                                  //           i]
                                  //               .size;
                                  //       if (productId ==
                                  //           product['id']
                                  //               .toString() &&
                                  //           productSize ==
                                  //               int.parse(
                                  //                   type)) {
                                  //         updateProduct(
                                  //             product['id']
                                  //                 .toString(),
                                  //             int.parse(
                                  //                 type),
                                  //             productList[i]
                                  //                 .quantity!
                                  //                 .toInt() +
                                  //                 1);
                                  //         fetchProducts();
                                  //         // print(productList[i].id!.toInt());
                                  //       }
                                  //     }
                                  //   },
                                  //   minusOntap: () {
                                  //     for (var j = 0;
                                  //     j <
                                  //         productList
                                  //             .length;
                                  //     j++) {
                                  //       var productId =
                                  //           productList[
                                  //           j]
                                  //               .productId;
                                  //       var productSize =
                                  //           productList[
                                  //           j]
                                  //               .size;
                                  //       if (productId ==
                                  //           product['id']
                                  //               .toString() &&
                                  //           productSize ==
                                  //               int.parse(
                                  //                   type)) {
                                  //         if (productList[
                                  //         j]
                                  //             .quantity!
                                  //             .toInt() >
                                  //             1) {
                                  //           updateProduct(
                                  //               product['id']
                                  //                   .toString(),
                                  //               int.parse(
                                  //                   type),
                                  //               productList[j].quantity!.toInt() -
                                  //                   1);
                                  //           fetchProducts();
                                  //           if (kDebugMode) {
                                  //             print(productList[
                                  //             j]
                                  //                 .quantity!
                                  //                 .toInt());
                                  //           }
                                  //         } else {
                                  //           removeProduct(
                                  //               productList[j]
                                  //                   .id!
                                  //                   .toInt());
                                  //           fetchProducts();
                                  //         }
                                  //       }
                                  //     }
                                  //   },
                                  //   // counterValue:productList[index2].quantity,
                                  //   counterValue:
                                  //   quant[index],
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            //Top selling product
            title('Top Selling Products', () {}),
            SizedBox(
              height: size.height * 0.25,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: additionalProduct.length,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, index) {
                    // final product = additionalProduct[index];
                    // var varientsDetails =
                    // product['variantDetails'].toString();
                    // var output = jsonDecode(varientsDetails);
                    // var productName =
                    // product['name'].toString();
                    // var productId = product['id'].toString();
                    // var productimg =
                    // product['image_url'].toString();
                    // var productAttributes =
                    // product['attribute']['name']
                    //     .toString();
                    //
                    // var type = output[0]["type"].toString();
                    // var mrp = double.parse(
                    //     output[0]["price"].toString());
                    // var discountType =
                    // output[0]["discountType"].toString();
                    // var discount = double.parse(
                    //     output[0]["discount"].toString());
                    // var price = discountType == 'amount'
                    //     ? mrp - discount
                    //     : mrp - ((mrp * discount) / 100);
                    // var unit = output[0]["unit"].toString();
                    //
                    // bool show = false;
                    // if (productList.isNotEmpty) {
                    //   for (var i = 0;
                    //   i < productList.length;
                    //   i++) {
                    //     var databasePID =
                    //         productList[i].productId;
                    //     quant = List.generate(
                    //         additionalProduct.length,
                    //             (index) =>
                    //         productList[i].quantity);
                    //     var databasePsize =
                    //         productList[i].size;
                    //     if (databasePID ==
                    //         product['id'].toString() &&
                    //         databasePsize ==
                    //             int.parse(type)) {
                    //       show = true;
                    //       break;
                    //     }
                    //   }
                    // }

                    return SizedBox(
                      width: 125,
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child:
                                        // Image.network(
                                        //   product['image_url']
                                        //       .toString(),
                                        //   height: 70,
                                        //   // width: 70,
                                        //   fit: BoxFit.fill,
                                        // )
                                        Image.asset(
                                            'assets/test_img/img_2.png'),
                                  ),
                                ],
                              ),
                              const Text(
                                // product['name'].toString(),
                                "Product Name",
                                style: AppTextStyles.kBody15SemiboldTextStyle,
                              ),
                              GestureDetector(
                                // onTap: () {
                                //   Get.bottomSheet(
                                //     SingleChildScrollView(
                                //       physics:
                                //       const NeverScrollableScrollPhysics(),
                                //       child:
                                //       VarientBottmSheet(
                                //         StoreName:
                                //         productList[0]
                                //             .storeName
                                //             .toString(),
                                //         pId: productId,
                                //         storeId: storeID,
                                //         pAttributes:
                                //         productAttributes,
                                //         varientsDetails:
                                //         output,
                                //         productImg:
                                //         productimg,
                                //         productName:
                                //         productName,
                                //       ),
                                //     ),
                                //   );
                                // },
                                child: Row(
                                  children: [
                                    const Text(
                                      // type + unit,
                                      "1 Pic",
                                      style: AppTextStyles
                                          .kCaption12RegularTextStyle,
                                    ),
                                    // output.length == 1
                                    //     ? const Text('')
                                    //     : const Icon(
                                    //   Icons
                                    //       .keyboard_arrow_down_rounded,
                                    //   color: AppColors
                                    //       .primary,
                                    // )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        // '₹${price.toInt()}',
                                        "99",
                                        style: AppTextStyles
                                            .kCaption12SemiboldTextStyle,
                                      ),
                                      Text(
                                        // '₹${mrp.toInt()}',
                                        "100",
                                        style: AppTextStyles
                                            .kSmall10RegularTextStyle
                                            .copyWith(
                                                color: AppColors.white60,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                  // !show
                                  //     ?
                                  const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                        // onTap: () {
                                        //   if (productList
                                        //       .isEmpty ||
                                        //       productList[0]
                                        //           .storeId ==
                                        //           storeID) {
                                        //     addProductToDatabase(
                                        //         productName,
                                        //         price,
                                        //         mrp,
                                        //         productList[0]
                                        //             .storeName
                                        //             .toString(),
                                        //         productimg,
                                        //         int.parse(
                                        //             type),
                                        //         productId,
                                        //         storeID,
                                        //         unit,
                                        //         1,
                                        //         productAttributes);
                                        //   } else {
                                        //     showDialog(
                                        //       context:
                                        //       context,
                                        //       builder:
                                        //           (BuildContext
                                        //       context) {
                                        //         return ConstAlert(
                                        //           addedStore: productList[0]
                                        //               .storeName
                                        //               .toString(),
                                        //           toAddStore: productList[0]
                                        //               .storeName
                                        //               .toString(),
                                        //           replaceOntap:
                                        //               () {
                                        //             deleteProduct();
                                        //             addProductToDatabase(
                                        //                 productName,
                                        //                 price,
                                        //                 mrp,
                                        //                 productList[0].storeName.toString(),
                                        //                 productimg,
                                        //                 int.parse(type),
                                        //                 productId,
                                        //                 storeID,
                                        //                 unit,
                                        //                 1,
                                        //                 productAttributes);
                                        //             Get.back();
                                        //             setState(() {
                                        //               fetchProducts();
                                        //             });
                                        //           },
                                        //         );
                                        //       },
                                        //     );
                                        //   }
                                        //   fetchProducts();
                                        //   setState(
                                        //           () {});
                                        // },
                                        child: Card(
                                      elevation: 1,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: AppColors.primary,
                                      ),
                                    )),
                                  )
                                  //     : CounterWidget(
                                  //   height:
                                  //   size.height *
                                  //       0.032,
                                  //   width: size.width *
                                  //       0.18,
                                  //   plusOntap: () {
                                  //     for (var i = 0;
                                  //     i <
                                  //         productList
                                  //             .length;
                                  //     i++) {
                                  //       var productId =
                                  //           productList[
                                  //           i]
                                  //               .productId;
                                  //       var productSize =
                                  //           productList[
                                  //           i]
                                  //               .size;
                                  //       if (productId ==
                                  //           product['id']
                                  //               .toString() &&
                                  //           productSize ==
                                  //               int.parse(
                                  //                   type)) {
                                  //         updateProduct(
                                  //             product['id']
                                  //                 .toString(),
                                  //             int.parse(
                                  //                 type),
                                  //             productList[i]
                                  //                 .quantity!
                                  //                 .toInt() +
                                  //                 1);
                                  //         fetchProducts();
                                  //         // print(productList[i].id!.toInt());
                                  //       }
                                  //     }
                                  //   },
                                  //   minusOntap: () {
                                  //     for (var j = 0;
                                  //     j <
                                  //         productList
                                  //             .length;
                                  //     j++) {
                                  //       var productId =
                                  //           productList[
                                  //           j]
                                  //               .productId;
                                  //       var productSize =
                                  //           productList[
                                  //           j]
                                  //               .size;
                                  //       if (productId ==
                                  //           product['id']
                                  //               .toString() &&
                                  //           productSize ==
                                  //               int.parse(
                                  //                   type)) {
                                  //         if (productList[
                                  //         j]
                                  //             .quantity!
                                  //             .toInt() >
                                  //             1) {
                                  //           updateProduct(
                                  //               product['id']
                                  //                   .toString(),
                                  //               int.parse(
                                  //                   type),
                                  //               productList[j].quantity!.toInt() -
                                  //                   1);
                                  //           fetchProducts();
                                  //           if (kDebugMode) {
                                  //             print(productList[
                                  //             j]
                                  //                 .quantity!
                                  //                 .toInt());
                                  //           }
                                  //         } else {
                                  //           removeProduct(
                                  //               productList[j]
                                  //                   .id!
                                  //                   .toInt());
                                  //           fetchProducts();
                                  //         }
                                  //       }
                                  //     }
                                  //   },
                                  //   // counterValue:productList[index2].quantity,
                                  //   counterValue:
                                  //   quant[index],
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            const Divider(
              thickness: 1,
            ),
            const BannerPageView(),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget title(String title, VoidCallback onTap) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.kBody15SemiboldTextStyle,
              ),
              TextButton(
                  onPressed: onTap,
                  child: Text(
                    'View All',
                    style: AppTextStyles.kCaption12RegularTextStyle
                        .copyWith(color: AppColors.primary),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:krush_e_marg/app/views/shops/views/store_list.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../colors/colors_const.dart';
// import '../../../const/api_string.dart';
// import '../../../controller/api_controller.dart';
// import '../../../textstyles/textstyle_const.dart';
//
// class ShopPage extends StatefulWidget {
//   const ShopPage({super.key});
//
//   @override
//   State<ShopPage> createState() => _ShopePageState();
// }
//
// class _ShopePageState extends State<ShopPage> {
//   @override
//   void initState() {
//     super.initState();
//     fetchModules();
//     // searchController.fetchModules();
//   }
//
//   // SearchController searchController = Get.put(SearchController());
//
//   List modulesName = [];
//   bool loading = true;
//   Future<void> fetchModules() async {
//     loading = false;
//     List<String> storedStrings = await loadStrings();
//     // String lat = storedStrings[0].toString();
//     // String long = storedStrings[1].toString();
//     String lat = '26.8467';
//     String long = '80.9462';
//
//     final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
//     var data = jsonDecode(response.body);
//
//     if (data['status'] == 1) {
//       modulesName = data['data'];
//       filteredModulesName = List.from(modulesName); // Initialize filteredModulesName with the same data
//       setState(() {});
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }
//
//   List filteredModulesName = [];
//   void filterModules(String query) {
//     if (query.isEmpty) {
//       // If the search query is empty, show all modules
//       filteredModulesName = List.from(modulesName);
//     } else {
//       // Filter modules based on the search query
//       filteredModulesName = modulesName
//           .where((module) => module['name']
//               .toString()
//               .toLowerCase()
//               .contains(query.toLowerCase()))
//           .toList();
//     }
//   }
//
//   // List modulesName = [];
//   // Future<void> fetchModules() async {
//   //   List<String> storedStrings = await loadStrings();
//   //   String lat = storedStrings[0].toString();
//   //   String long = storedStrings[1].toString();
//   //
//   //   final response = await http.get(Uri.parse('$moduleUrl+$lat,$long'));
//   //   List modules = jsonDecode(response.body)['data'];
//   //
//   //   if (response.statusCode == 200) {
//   //     setState(() {
//   //       modulesName = modules;
//   //       filteredModulesName = List.from(
//   //           modules); // Initialize filteredModulesName with the same data
//   //       _loading = false;
//   //     });
//   //   } else {
//   //     throw Exception('Failed to load categories');
//   //   }
//   // }
//   //
//   // List filteredModulesName = [];
//   // void filterModules(String query) {
//   //   setState(() {
//   //     if (query.isEmpty) {
//   //       // If the search query is empty, show all modules
//   //       filteredModulesName = List.from(modulesName);
//   //     } else {
//   //       // Filter modules based on the search query
//   //       filteredModulesName = modulesName
//   //           .where((module) => module['name']
//   //               .toString()
//   //               .toLowerCase()
//   //               .contains(query.toLowerCase()))
//   //           .toList();
//   //     }
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return loading
//         ? Container(
//             color: AppColors.white,
//             child: Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   const SizedBox(
//                       height: 70,
//                       width: 70,
//                       child: CircularProgressIndicator(
//                         color: AppColors.primary,
//                         strokeWidth: 2.5,
//                       )),
//                   Image.asset(
//                     'assets/images/applogo.png',
//                     height: 60,
//                     width: 60,
//                   ),
//                 ],
//               ),
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               centerTitle: true,
//               toolbarHeight: 80,
//               title: SizedBox(
//                 height: 50,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: size.width * 0.9,
//                       child: TextFormField(
//                         onChanged:
//                             filterModules, // Call the filterModules method on text change
//                         decoration: InputDecoration(
//                           contentPadding: const EdgeInsets.symmetric(
//                               vertical: 0, horizontal: 10),
//                           fillColor: const Color.fromRGBO(203, 212, 225, 1),
//                           hintText: 'Search for any categories',
//                           hintStyle: const TextStyle(fontSize: 14),
//                           suffixIcon: const Icon(Icons.search,
//                               color: AppColors.primary),
//                           // prefixIcon: IconButton(
//                           //     onPressed: () {
//                           //       Get.back();
//                           //     },
//                           //     icon: const Icon(
//                           //       Icons.arrow_back_ios_new_rounded,
//                           //       color: AppColors.white100,
//                           //     )),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(
//                               color: AppColors.white40,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               elevation: 0,
//               backgroundColor: Colors.white10,
//             ),
//             body: NotificationListener<OverscrollIndicatorNotification>(
//               onNotification: (notification) {
//                 notification.disallowIndicator();
//                 return true;
//               },
//               child: Container(
//                 margin: const EdgeInsets.all(15),
//                 child: GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 5,
//                       crossAxisSpacing: 5,
//                       childAspectRatio: 0.9),
//                   itemCount:
//                       filteredModulesName.length, // Use the filtered list
//                   itemBuilder: (BuildContext context, int index) {
//                     final module = filteredModulesName[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(StoreList(ModuleId: module['id'].toString()));
//                       },
//                       child: Card(
//                         color: AppColors.white10,
//                         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         elevation: 1,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             CircleAvatar(
//                               radius: 35,
//                               backgroundColor: AppColors.white20,
//                               backgroundImage:
//                                   NetworkImage(module['icon_url'].toString()),
//                             ),
//                             Text(
//                               module['name'].toString(),
//                               style: AppTextStyles.kBody15RegularTextStyle,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           );
//   }
// }
