import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:krush_e_marg/app/controller/product_db_controller.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../../../colors/colors_const.dart';
import '../../../../constwidgets/const_container.dart';
import '../../../../constwidgets/const_textfield.dart';
import '../../../../constwidgets/counter_widgets.dart';
import '../../../../database/database_helper2.dart';
import '../../../CheckoutScreen/views/checkout_screen.dart';

class ProductList extends StatefulWidget {
  final String catId;

  const ProductList({Key? key, required this.catId}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList>
    with SingleTickerProviderStateMixin {
  // Add SingleTickerProviderStateMixin
  final SubCatController subCatController = Get.find();
  final ProductController productController = Get.find();
  final TextEditingController searchController = TextEditingController();
  String catId = '';
  // String storeID = "";
  String storeName = "";

  late TabController _tabController; // Define TabController

  @override
  void initState() {
    super.initState();
    catId = widget.catId;
    subCatController.fetchSubCat(
      catId.toString(),
    );
    // fetchProductList = subCatController.subCatList[0]['product'];
    _tabController = TabController(
      length: subCatController.subCatList.length, // Set the number of tabs
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // List fetchProductList = [];
  List quant = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        toolbarHeight: 70,
        title: ConstTextField(
          controller: searchController,
          hintText: 'Search here...',
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      body: GetBuilder<SubCatController>(builder: (subCatController) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 0.2,
                  indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6)),
                  isScrollable: true,
                  unselectedLabelColor: AppColors.white100,
                  unselectedLabelStyle: AppTextStyles.kBody15SemiboldTextStyle,
                  // Use the TabController
                  tabs: subCatController.subCatList
                      .map(
                        (subCat) => ConstantContainer(
                          height: Get.height * .03,
                          borderWidth: 1,
                          borderColor: AppColors.primary,
                          radiusBorder: 6,
                          child: Center(
                            child: Tab(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 0),
                                child: Text(
                                  '${subCat['name']}',
                                  style:
                                      AppTextStyles.kCaption12SemiboldTextStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                GetBuilder<ProductController>(builder: (productController) {
                  return Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController, // Use the TabController
                      children: subCatController.subCatList.map((subCat) {
                        // final products = subCat['product'];
                     List   fetchProductList = subCat['product'];

                        if (fetchProductList.isEmpty) {
                          return const Center(
                            child: Text('No Product Found'),
                          );
                        }
                        return GridView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: fetchProductList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (BuildContext context, index1) {
                              if (index1 >= 0 &&
                                  index1 < fetchProductList.length) {
                                final product = fetchProductList[index1];
                                final String storeID = "${product['store_id']}";
                                final String storeName =
                                    "${product['store']['name']}";
                                var variantsDetails =
                                    product['variantDetails'].toString();
                                var output = jsonDecode(variantsDetails);
                                var type = output[0]["type"].toString();
                                var mrp =
                                    double.parse(output[0]["price"].toString());
                                var discountType =
                                    output[0]["discountType"].toString();
                                var discount = double.parse(
                                    output[0]["discount"].toString());
                                var price = discountType == 'amount'
                                    ? mrp - discount
                                    : mrp - ((mrp * discount) / 100);
                                var unit = output[0]["unit"].toString();
                                var productName = product['name'].toString();
                                var productId = product['id'].toString();
                                var productimg = product['image'].toString();
                                var productAttributes =
                                    product['attribute']['name'].toString();

                                bool show = false;
                                if (productController.productList.isNotEmpty) {
                                  for (var i = 0;
                                      i < productController.productList.length;
                                      i++) {
                                    var databasePID = productController
                                        .productList[i].productId;
                                    quant = List.generate(
                                        fetchProductList.length,
                                        (index) => productController
                                            .productList[i].quantity);
                                    var databasePsize =
                                        productController.productList[i].size;
                                    if (databasePID ==
                                            product['id'].toString() &&
                                        databasePsize == int.parse(type)) {
                                      // print(databasePID);
                                      // print("databasePID");
                                      show = true;
                                      break;
                                    }
                                  }
                                }
                                return SizedBox(
                                  // width: 125,
                                  child: Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: CachedNetworkImage(
                                                  imageUrl: product['image']
                                                      .toString(),
                                                  // placeholder: (context, url) => CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                  width:
                                                      60, // Specify the desired width
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            product['name']
                                                .toString()
                                                .capitalizeFirst!,
                                            style: AppTextStyles
                                                .kBody15SemiboldTextStyle,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                type + unit,
                                                style: AppTextStyles
                                                    .kCaption12RegularTextStyle,
                                              ),
                                              output.length == 1
                                                  ? const Text('')
                                                  : const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: AppColors.primary,
                                                    )
                                            ],
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
                                                      style: AppTextStyles
                                                          .kCaption12SemiboldTextStyle,
                                                    ),
                                                    Text(
                                                      '₹${mrp.toInt()}',
                                                      style: AppTextStyles
                                                          .kSmall10RegularTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white60,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              !show
                                                  ? SizedBox(
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
                                                          productController
                                                              .fetchProducts();
                                                        },
                                                        child: const Card(
                                                          elevation: 1,
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 18,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : CounterWidget(
                                                      height:
                                                          Get.height * 0.032,
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
                                                                  .productList[
                                                                      i]
                                                                  .productId;
                                                          var productSize =
                                                              productController
                                                                  .productList[
                                                                      i]
                                                                  .size;
                                                          var productStoreID =
                                                              productController
                                                                  .productList[
                                                                      i]
                                                                  .storeId;

                                                          if (
                                                              productId ==
                                                                      product['id']
                                                                          .toString() &&
                                                                  productSize ==
                                                                      int.parse(
                                                                          type) &&
                                                                  productStoreID ==
                                                                      storeID
                                                              ) {
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
                                                                  .productList[
                                                                      j]
                                                                  .productId;
                                                          var productSize =
                                                              productController
                                                                  .productList[
                                                                      j]
                                                                  .size;
                                                          var productStoreID =
                                                              productController
                                                                  .productList[
                                                                      j]
                                                                  .storeId;

                                                          if (productId ==
                                                                  product['id']
                                                                      .toString() &&
                                                              productSize ==
                                                                  int.parse(
                                                                      type) &&
                                                              productStoreID ==
                                                                  storeID) {
                                                            if (productController
                                                                    .productList[
                                                                        j]
                                                                    .quantity!
                                                                    .toInt() >
                                                                1) {
                                                              updateProduct(
                                                                  product['id']
                                                                      .toString(),
                                                                  int.parse(
                                                                      type),
                                                                  productController
                                                                          .productList[
                                                                              j]
                                                                          .quantity!
                                                                          .toInt() -
                                                                      1);
                                                            } else {
                                                              removeProduct(
                                                                  productController
                                                                      .productList[
                                                                          j]
                                                                      .id!
                                                                      .toInt());
                                                            }
                                                            productController
                                                                .fetchProducts();
                                                          }
                                                        }
                                                      },
                                                      // counterValue:productList[index2].quantity,
                                                      counterValue:
                                                          quant[index1],
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return null;
                            });
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
      floatingActionButton:
          GetBuilder<ProductController>(builder: (productController) {
        double calculatePrice = 0;
        if (productController.productList.isNotEmpty) {
          for (var i = 0; i < productController.productList.length; i++) {
            var price = productController.productList[i].price! *
                productController.productList[i].quantity!.toInt();
            calculatePrice += price;
          }
        }
        return productController.productList.isNotEmpty
            ? InkWell(
                onTap: () {
                  Get.to(const CheckoutScreeen());
                },
                child: Container(
                  height: 45,
                  width: Get.width * 0.91,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GetBuilder<ProductController>(
                        builder: (productController) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${productController.productList.length.toString()}Item',
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white),
                          ),
                          Container(
                            height: 15,
                            width: 2,
                            color: Colors.white,
                          ),
                          Text(
                            '₹${calculatePrice.toInt()}',
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white),
                          ),
                          SizedBox(
                            width: Get.width * 0.45,
                          ),
                          Text(
                            'Next',
                            style: AppTextStyles.kBody15SemiboldTextStyle
                                .copyWith(color: AppColors.white),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: AppColors.white,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              )
            : const SizedBox();
      }),
    );
  }
}
