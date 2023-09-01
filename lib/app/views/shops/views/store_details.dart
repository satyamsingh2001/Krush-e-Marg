import 'dart:convert';
import 'package:krush_e_marg/app/controller/api_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/shops/views/store_offer.dart';
import 'package:get/get.dart';
import '../../../colors/colors_const.dart';
import '../../../const/api_string.dart';
import '../../../constwidgets/counter_widgets.dart';
import '../../../database/database_helper2.dart';
import '../../CheckoutScreen/views/checkout_screen.dart';
import '../screens/varient_bottom_sheet.dart';
import '../widgets/constalert.dart';

class StoreDetails extends StatefulWidget {
  final String storeID;
  const StoreDetails({
    super.key,
    required this.storeID,
  });

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  final TextEditingController _searchController = TextEditingController();

  late bool _loading = true;
  @override
  void initState() {
    super.initState();
    storeID = widget.storeID;
    categoryWithStore();
    // fetchProducts();
    productController.fetchProducts();
  }

  ProductController productController = Get.find();

  String storeID = "";
  var fetchProductList = [];
  List storeCategory = [];
  Future<void> categoryWithStore() async {
    final response =
        await http.get(Uri.parse('$category_with_storeid+$storeID'));
    storeCategory = jsonDecode(response.body)['data'];

    if (response.statusCode == 200) {
      fetchProductList = storeCategory[0]['products'];
      filterProduct = fetchProductList;
      StoreName = storeCategory[0]['products'][0]['store']['name'].toString();
      _selectedCategoryIndex =
          List.generate(storeCategory.length, (index) => false);

      _loading = false;
      _selectedCategoryIndex[0] = true;

      setState(() {});
    } else {
      throw Exception('Failed to load categories');
    }
  }

  List filterProduct = [];
  void filterProductByName(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, show all modules
        filterProduct = List.from(fetchProductList);
      } else {
        // Filter modules based on the search query
        filterProduct = fetchProductList
            .where((product) => product['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  String categoryId = "";
  String StoreName = "";
  String categoryName = "";
  List quant = [];
  List varientQuant = [];

  List<bool> _selectedCategoryIndex = [];

  @override
  Widget build(BuildContext context) {
    categoryName == ""
        ? storeCategory.isEmpty
            ? ""
            : categoryName = storeCategory[0]['name'].toString()
        : categoryName;
    categoryId == ""
        ? storeCategory.isEmpty
            ? ""
            : categoryId = storeCategory[0]['id'].toString()
        : categoryId;

    final String allcategory = storeCategory.isNotEmpty
        ? storeCategory.length == 1
            ? storeCategory[0]['name'].toString()
            : "${storeCategory[0]['name']},${storeCategory[1]['name']}"
        : "";

    Size size = MediaQuery.of(context).size;

    return _loading
        ? Container(
            color: AppColors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.5,
                    )),
                Image.asset(
                  'assets/images/applogo.png',
                  height: 60,
                  width: 60,
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Get.to(const CheckoutScreeen());
                      },
                      child: Stack(
                        children: [
                          const CircleAvatar(
                              backgroundColor: AppColors.white30,
                              radius: 20,
                              child: Icon(
                                Icons.shopping_cart_rounded,
                                color: AppColors.primary,
                              )),
                          GetBuilder<ProductController>(
                              builder: (productController) {
                                return Positioned(
                                    top: 0,
                                    right: 0,
                                    child: productController.productList.isEmpty
                                        ? const SizedBox()
                                        : CircleAvatar(
                                        backgroundColor:
                                        AppColors.primary,
                                        radius: 7,
                                        child: Text(
                                          productController.productList.length.toString(),
                                          style: AppTextStyles
                                              .kSmall10SemiboldTextStyle
                                              .copyWith(
                                              color:
                                              AppColors.white),
                                        )));
                              }
                          ),
                        ],
                      )),
                ),
              ],
              elevation: 0,
              backgroundColor: AppColors.white10,
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height,
                  width: size.width * 0.20,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: AppColors.white30),
                          right: BorderSide(color: AppColors.white30))),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: storeCategory.length,
                          itemBuilder: (BuildContext contex, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoryId =
                                      storeCategory[index]['id'].toString();
                                  categoryName =
                                      storeCategory[index]['name'].toString();
                                  filterProduct =
                                      storeCategory[index]['products'];
                                  _selectedCategoryIndex = List.generate(
                                      storeCategory.length, (i) => i == index);
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * 0.02,
                                    height: size.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: _selectedCategoryIndex[index]
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(size.width * 0.05),
                                        bottomRight:
                                            Radius.circular(size.width * 0.05),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.all(size.width * 0.01),
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: AppColors.error20,
                                          backgroundImage: NetworkImage(
                                            storeCategory[index]['image_url']
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        storeCategory[index]['name'].toString(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _selectedCategoryIndex[index]
                                              ? AppColors.primary
                                              : AppColors.white100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(top: BorderSide(color: AppColors.white30))),
                  height: size.height,
                  width: size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        notification.disallowIndicator();
                        return true;
                      },
                      child: ListView(
                        children: [
                          // StoerOffer(
                          //   category: allcategory,
                          //   storeId: widget.storeID,
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     SizedBox(
                          //       width: size.width * 0.77,
                          //       height: 50,
                          //       child: TextFormField(
                          //         onChanged: filterProductByName,
                          //         controller: _searchController,
                          //         decoration: InputDecoration(
                          //           contentPadding: const EdgeInsets.all(0),
                          //           hintText: 'Search for items in shop',
                          //           hintStyle: const TextStyle(fontSize: 12),
                          //           prefixIcon: const Icon(
                          //             Icons.search,
                          //             // size: 20,
                          //             color: AppColors.primary700,
                          //           ),
                          //           border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10),
                          //             borderSide: const BorderSide(
                          //               color: AppColors.primary700,
                          //             ),
                          //           ),
                          //           focusedBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10),
                          //             borderSide: const BorderSide(
                          //               color: AppColors.primary700,
                          //             ),
                          //           ),
                          //           enabledBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10),
                          //             borderSide: const BorderSide(
                          //               color: AppColors.white30,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            categoryName,
                            style: AppTextStyles.kBody15SemiboldTextStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(child: GetBuilder<ProductController>(
                              builder: (productController) {
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filterProduct.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (BuildContext context, index2) {
                                final product = filterProduct[index2];
                                var varientsDetails =
                                    product['variantDetails'].toString();
                                var output = jsonDecode(varientsDetails);
                                var productName = product['name'].toString();
                                var productId = product['id'].toString();
                                var productimg =
                                    product['image_url'].toString();
                                var productAttributes =
                                    product['attribute']['name'].toString();

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
                                      show = true;
                                      break;
                                    }
                                  }
                                }

                                return Card(
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
                                                child: Image.network(
                                                  product['image_url']
                                                      .toString(),
                                                  height: 70,
                                                  // width: 70,
                                                  fit: BoxFit.fill,
                                                )),
                                          ],
                                        ),
                                        Text(
                                          product['name'].toString(),
                                          style: AppTextStyles
                                              .kBody15SemiboldTextStyle,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.bottomSheet(
                                              SingleChildScrollView(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                child: VarientBottmSheet(
                                                  StoreName: StoreName,
                                                  pId: productId,
                                                  storeId: storeID,
                                                  pAttributes:
                                                      productAttributes,
                                                  varientsDetails: output,
                                                  productImg: productimg,
                                                  productName: productName,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
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
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
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
                                                          color:
                                                              AppColors.white60,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                ),
                                              ],
                                            ),
                                            !show
                                                ? SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: InkWell(
                                                        onTap: () {
                                                          if (productController
                                                                  .productList
                                                                  .isEmpty ||
                                                              productController
                                                                      .productList[
                                                                          0]
                                                                      .storeId ==
                                                                  storeID) {
                                                            addProductToDatabase(
                                                                productName,
                                                                price,
                                                                mrp,
                                                                StoreName,
                                                                productimg,
                                                                int.parse(type),
                                                                productId,
                                                                storeID,
                                                                unit,
                                                                1,
                                                                productAttributes);
                                                            productController
                                                                .fetchProducts();
                                                          } else {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return ConstAlert(
                                                                  addedStore: productController
                                                                      .productList[
                                                                          0]
                                                                      .storeName
                                                                      .toString(),
                                                                  toAddStore:
                                                                      StoreName,
                                                                  replaceOntap:
                                                                      () {
                                                                    deleteProduct();
                                                                    addProductToDatabase(
                                                                        productName,
                                                                        price,
                                                                        mrp,
                                                                        StoreName,
                                                                        productimg,
                                                                        int.parse(
                                                                            type),
                                                                        productId,
                                                                        storeID,
                                                                        unit,
                                                                        1,
                                                                        productAttributes);
                                                                    Get.back();
                                                                    productController
                                                                        .fetchProducts();
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                        child: const Card(
                                                          elevation: 1,
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 18,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        )),
                                                  )
                                                : CounterWidget(
                                                    height: size.height * 0.032,
                                                    width: size.width * 0.18,
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
                                                                int.parse(
                                                                    type)) {
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
                                                                int.parse(
                                                                    type)) {
                                                          if (productController
                                                                  .productList[
                                                                      j]
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
                                                              print(productController
                                                                  .productList[
                                                                      j]
                                                                  .quantity!
                                                                  .toInt());
                                                            }
                                                          } else {
                                                            removeProduct(
                                                                productController
                                                                    .productList[
                                                                        j]
                                                                    .id!
                                                                    .toInt());
                                                          }
                                                        }
                                                        productController
                                                            .fetchProducts();
                                                      }
                                                    },
                                                    // counterValue:productList[index2].quantity,
                                                    counterValue: quant[index2],
                                                  ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          })),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: GetBuilder<ProductController>(
              builder: (productController) {
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
                          // Get.to(const CheckoutScreeen());
                        },
                        child: Container(
                          height: 45,
                          width: size.width * 0.91,
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
                                    width: size.width * 0.45,
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
              }
            ),
          );
  }
}
