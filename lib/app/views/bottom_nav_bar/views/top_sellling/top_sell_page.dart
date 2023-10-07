import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/views/top_sellling/controller/top_selling_controller.dart';

import '../../../../colors/colors_const.dart';
import '../../../../constwidgets/counter_widgets.dart';
import '../../../../controller/product_db_controller.dart';
import '../../../../database/database_helper2.dart';
import '../../../../textstyles/textstyle_const.dart';
import '../../shops/screens/varient_bottom_sheet.dart';
import '../../shops/widgets/constalert.dart';

class TopSellingPage extends StatefulWidget {
  const TopSellingPage({Key? key}) : super(key: key);

  @override
  State<TopSellingPage> createState() => _TopSellingPageState();
}

class _TopSellingPageState extends State<TopSellingPage> {
  final TopSellingController topSellingController = Get.find();
  final ProductController productController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // topSellingController.fetchTopSell();
  }
  // String storeID = "";
  // String storeName = "";
  List quant = [];
  @override
  Widget build(BuildContext context) {
    return   GetBuilder<TopSellingController>(
      builder: (topSellingController) {
        return SizedBox(
          height: Get.height * 0.25,
          child: GetBuilder<ProductController>(
            builder: (productController) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // itemCount: additionalProduct.length,
                  itemCount: topSellingController.topSellList.length,
                  itemBuilder: (BuildContext context, index) {

                    final toSell = topSellingController.topSellList[index];
                    final product = toSell;
                    final String storeID = product['store_id'].toString();
                    final String storeName =
                        "${product['store']['name']}";
                    // final product = additionalProduct[index];
                    var varientsDetails =
                    toSell['variantDetails'].toString();
                    var output = jsonDecode(varientsDetails);
                    var productName =
                    toSell['name'].toString();
                    var productId = toSell['id'].toString();
                    var productimg =
                    toSell['image'].toString();
                    var productAttributes =
                    toSell['attribute']['name']
                        .toString();
                    var storeId = toSell['store_id'].toString();
                    var type = output[0]["type"].toString();
                    var mrp = double.parse(
                        output[0]["price"].toString());
                    var discountType =
                    output[0]["discountType"].toString();
                    var discount = double.parse(
                        output[0]["discount"].toString());
                    var price = discountType == 'amount'
                        ? mrp - discount
                        : mrp - ((mrp * discount) / 100);
                    var unit = output[0]["unit"].toString();


                    bool show = false;
                    if (productController.productList.isNotEmpty) {
                      for (var i = 0;
                      i < productController.productList.length;
                      i++) {
                        var databasePID =
                            productController.productList[i].productId;
                        quant = List.generate(
                            toSell.length,
                                (index) => productController
                                .productList[i].quantity);
                        var databasePsize =
                            productController.productList[i].size;
                        if (databasePID == product['id'].toString() &&
                            databasePsize == int.parse(type)) {
                          show = true;
                          break;
                        }
                      }
                    }

                    return SizedBox(
                      width: 125,
                      child: Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child:

                                    CachedNetworkImage(
                                      imageUrl:    toSell['image']
                                          .toString(),
                                      // placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      // width: 60, // Specify the desired width
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                               Text(
                                toSell['name'].toString().capitalizeFirst!,
                                // "Product Name",
                                style: AppTextStyles
                                    .kBody15SemiboldTextStyle,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    SingleChildScrollView(
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      child:
                                      VarientBottmSheet(
                                        storeName:
                                        toSell[0]
                                            .storeName
                                            .toString(),
                                        pId: productId,
                                        storeId: storeId,
                                        pAttributes:
                                        productAttributes,
                                        varientsDetails:
                                        output,
                                        productImg:
                                        productimg,
                                        productName:
                                        productName,
                                      ),
                                    ),
                                  );
                                },
                                child:  Row(
                                  children: [
                                    Text(
                                      type + unit,
                                      // "1 Pic",
                                      style: AppTextStyles
                                          .kCaption12RegularTextStyle,
                                    ),
                                    output.length == 1
                                        ? const Text('')
                                        : const Icon(
                                      Icons
                                          .keyboard_arrow_down_rounded,
                                      color: AppColors
                                          .primary,
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                         Text(
                                          '₹${price.toInt()}',
                                          // "99",
                                          style: AppTextStyles
                                              .kCaption12SemiboldTextStyle,
                                        ),
                                        Text(
                                          '₹${mrp.toInt()}',
                                          // "100",
                                          style: AppTextStyles
                                              .kSmall10RegularTextStyle
                                              .copyWith(
                                              color: AppColors.white60,
                                              decoration: TextDecoration
                                                  .lineThrough),
                                        ),
                                      ],
                                    ),
                                  ),
                                  !show
                                      ?
                                   SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: InkWell(
                                        onTap: () {
                                          addProductToDatabase(
                                              productName,
                                              price,
                                              mrp,
                                              storeName,
                                              productimg,
                                              int.parse(type),
                                              productId,
                                              storeID,
                                              unit,
                                              1,
                                              productAttributes);
                                        },
                                        child: const Card(
                                          elevation: 1,
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                            color: AppColors.primary,
                                          ),
                                        )),
                                  )
                                      : CounterWidget(
                                    height: Get.height * 0.032,
                                    width: Get.width * 0.18,
                                    plusOntap: () {
                                      for (var i = 0;
                                      i <
                                          productController
                                              .productList
                                              .length;
                                      i++) {
                                        var productId =
                                            productController
                                                .productList[i]
                                                .productId;
                                        var productSize =
                                            productController
                                                .productList[i]
                                                .size;
                                        if (productId ==
                                            product['id']
                                                .toString() &&
                                            productSize ==
                                                int.parse(type)) {
                                          updateProduct(
                                              product['id']
                                                  .toString(),
                                              int.parse(type),
                                              productController
                                                  .productList[
                                              i]
                                                  .quantity!
                                                  .toInt() +
                                                  1);
                                          productController
                                              .fetchProducts();
                                          // print(productList[i].id!.toInt());
                                        }
                                      }
                                    },
                                    minusOntap: () {
                                      for (var j = 0;
                                      j <
                                          productController
                                              .productList
                                              .length;
                                      j++) {
                                        var productId =
                                            productController
                                                .productList[j]
                                                .productId;
                                        var productSize =
                                            productController
                                                .productList[j]
                                                .size;
                                        if (productId ==
                                            product['id']
                                                .toString() &&
                                            productSize ==
                                                int.parse(type)) {
                                          if (productController
                                              .productList[j]
                                              .quantity!
                                              .toInt() >
                                              1) {
                                            updateProduct(
                                                product['id']
                                                    .toString(),
                                                int.parse(type),
                                                productController
                                                    .productList[
                                                j]
                                                    .quantity!
                                                    .toInt() -
                                                    1);
                                            if (kDebugMode) {
                                              print(
                                                  productController
                                                      .productList[
                                                  j]
                                                      .quantity!
                                                      .toInt());
                                            }
                                          } else {
                                            removeProduct(
                                                productController
                                                    .productList[j]
                                                    .id!
                                                    .toInt());
                                          }
                                        }
                                        productController
                                            .fetchProducts();
                                      }
                                    },
                                    // counterValue:productList[index2].quantity,
                                    counterValue: quant[index],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          ),
        );
      }
    );
  }
}
