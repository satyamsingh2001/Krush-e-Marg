import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/views/bottom_nav_bar/widgets/category_list.dart';
import '../../../colors/colors_const.dart';
import '../../../controller/api_controller.dart';
import '../../drawer/drawer.dart';
import '../../story/stories_store.dart';
import '../widgets/banner_pageview.dart';
import '../bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadStrings();
      controller.fetchBanner();
      adminOfferController.adminOffer();
      categoriesController.fetchCategories();
      productController.fetchProducts();
      addressController.fetchSavedAddress();
      storyController.fetchStore();
      moduleController.fetchModules();
    });
    setState(() {});
  }

  BannerController controller = Get.put(BannerController());
  AdminOfferController adminOfferController = Get.put(AdminOfferController());
  CategoriesController categoriesController = Get.put(CategoriesController());
  ProductController productController = Get.put(ProductController());
  AddressController addressController = Get.put(AddressController());
  StoryController storyController = Get.put(StoryController());
  ModuleController moduleController = Get.put(ModuleController());

  List test_img = [
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
      drawer: const ConstDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Krush e Marge'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashBoardScreenMain(
                              currentIndex: 1,
                            )));
              },
              child: const Icon(Icons.search)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.notifications)),
          const SizedBox(
            width: 10,
          ),
          InkWell(onTap: () {}, child: const Icon(Icons.shopping_cart)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body:
          // addressController.isLoading.value
          //     ? Container(
          //         color: AppColors.white,
          //         alignment: Alignment.center,
          //         child: Stack(
          //           alignment: Alignment.center,
          //           children: [
          //             const SizedBox(
          //                 height: 70,
          //                 width: 70,
          //                 child: CircularProgressIndicator(
          //                   color: AppColors.primary,
          //                   strokeWidth: 2.5,
          //                 )),
          //             Image.asset(
          //               'assets/images/applogo.png',
          //               height: 60,
          //               width: 60,
          //             ),
          //           ],
          //         ),
          //       )
          //     :
          Stack(
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  const StoriesStore(),

                  const Divider(
                    color: AppColors.white30,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const BannerPageView(),
                  const SizedBox(
                    height: 15,
                  ),

                  //categories
                  title('Categories', () {}),
                  const CategoryList(),
                  const SizedBox(
                    height: 10,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      style: AppTextStyles
                                          .kBody15SemiboldTextStyle,
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
                                                      decoration: TextDecoration
                                                          .lineThrough),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      style: AppTextStyles
                                          .kBody15SemiboldTextStyle,
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
                                                      decoration: TextDecoration
                                                          .lineThrough),
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

                  // manufacturers
                  title('Manufacturers', () {}),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 0.9),
                    itemCount: test_img.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.white20,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 0.5, color: AppColors.primary)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  test_img[index],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                'suraj',
                                style: AppTextStyles.kBody17SemiboldTextStyle
                                    .copyWith(color: AppColors.white100),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const BannerPageView(),

                  const SizedBox(
                    height: 50,
                  ),
                  // const OfferSlider(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const StoreModule(),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // const InviteAndShare(),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SuggestWidget(),
                ],
              ),
            ),
          ),
          // Positioned(
          //     top: 0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 5),
          //       color: AppColors.white10,
          //       height: size.height * 0.085,
          //       width: size.width,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           GestureDetector(
          //             onTap: () {
          //               Get.to(const NewHomePageAddress());
          //             },
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 const CircleAvatar(
          //                     backgroundColor: AppColors.white30,
          //                     radius: 20,
          //                     child: Icon(
          //                       Icons.location_on,
          //                       color: AppColors.primary,
          //                     )),
          //                 SizedBox(
          //                     width: size.width * 0.13,
          //                     child: Text(
          //                       textAlign: TextAlign.center,
          //                       "Add-",
          //                       style: AppTextStyles
          //                           .kBody15SemiboldTextStyle
          //                           .copyWith(color: AppColors.white90),
          //                     )),
          //                 SizedBox(
          //                     width: size.width * 0.5,
          //                     child: GetBuilder<AddressController>(
          //                         builder: (addressController) {
          //                       return Text(
          //                         textAlign: TextAlign.start,
          //                         addressController.address.trimLeft(),
          //                         style: AppTextStyles
          //                             .kCaption12RegularTextStyle,
          //                       );
          //                     })),
          //                 const Icon(
          //                   Icons.arrow_drop_down_sharp,
          //                   size: 30,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           InkWell(
          //               onTap: () {
          //                 Get.to(const CheckoutScreeen());
          //               },
          //               child: Stack(
          //                 children: [
          //                   const CircleAvatar(
          //                       backgroundColor: AppColors.white30,
          //                       radius: 20,
          //                       child: Icon(
          //                         Icons.shopping_cart_rounded,
          //                         color: AppColors.primary,
          //                       )),
          //                   GetBuilder<ProductController>(
          //                       builder: (productController) {
          //                     return Positioned(
          //                         top: 0,
          //                         right: 0,
          //                         child: productController
          //                                 .productList.isEmpty
          //                             ? const SizedBox()
          //                             : CircleAvatar(
          //                                 backgroundColor:
          //                                     AppColors.primary,
          //                                 radius: 7,
          //                                 child: Text(
          //                                   productController
          //                                       .productList.length
          //                                       .toString(),
          //                                   style: AppTextStyles
          //                                       .kSmall10SemiboldTextStyle
          //                                       .copyWith(
          //                                           color:
          //                                               AppColors.white),
          //                                 )));
          //                   }),
          //                 ],
          //               )),
          //           // Icon(Icons.notifications,color: AppColors.primary,size: 30,)
          //         ],
          //       ),
          //     )),
        ],
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
