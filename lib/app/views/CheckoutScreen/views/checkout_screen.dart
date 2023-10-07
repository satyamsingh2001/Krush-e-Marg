import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krush_e_marg/app/const/api_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/container_widget.dart';
import '../../../constwidgets/counter_widgets.dart';
import '../../../controller/api_controller.dart';
import '../../../database/database_helper2.dart';
import '../../../textstyles/textstyle_const.dart';
import '../controller/tip_controller.dart';
import '../screens/addnewaddress.dart';
import '../widgets/cart_empty.dart';

class CheckoutScreeen extends StatefulWidget {
  const CheckoutScreeen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutScreeen> createState() => _CheckoutScreeenState();
}

class _CheckoutScreeenState extends State<CheckoutScreeen> {

  @override
  void initState() {
    super.initState();
    addressController.fetchSavedAddress();
    fetchProductsInit();
    // paymentController.razorInit();
  }
  List<Map<String, dynamic>> productListForApi=[];

  TextEditingController msgController = TextEditingController();
  AddressController addressController = Get.find();
  // InstructionController instructionController =
  //     Get.put(InstructionController());
  // PaymentController paymentController = Get.put(PaymentController());
  TipController tipController = Get.put(TipController());

  List<Product> productList = [];
  // String storeID = "";
  void fetchProductsInit() async {
    final products = await ProductDatabase.instance.fetchProducts();
    setState(() {
      productList = products;
      // storeID = productList[0].storeId.toString();
      // fetchCoupons(storeID);
      // storeWithId(storeID);
      // fetchAdditionalProduct(storeID);
      // adminOffer(storeID);
      productListForApi =
          products.map((product) => product.toMapForApi()).toList();
    });
  }

  void fetchProducts() async {
    var products = await ProductDatabase.instance.fetchProducts();

    // Create a map to group products by store_id
    Map<String, List<Product>> productsByStore = {};

    for (var product in products) {
      String storeId = product.storeId ?? "";

      if (!productsByStore.containsKey(storeId)) {
        productsByStore[storeId] = [];
      }

      productsByStore[storeId]?.add(product);
    }

    // Convert the grouped products into the desired format for productListForApi
    productListForApi = productsByStore.values.map((storeProducts) {
      return storeProducts.map((product) => product.toMapForApi()).toList();
    }).cast<Map<String, dynamic>>().toList(); // Removed the cast here


    setState(() {
      productList = products;
    });
  }

  // Define the function to group products by storeId
  Map<String, List<Product>> groupProductsByStore(List<Product> productList) {
    Map<String, List<Product>> productsByStore = {};

    for (Product product in productList) {
      String storeId = product.storeId ?? "";
      if (!productsByStore.containsKey(storeId)) {
        productsByStore[storeId] = [];
      }
      productsByStore[storeId]?.add(product);
    }

    return productsByStore;
  }

//   Future<void> sendCartToApi(
//       List<Map<String, dynamic>> productList,
//       String totalAmount,
//       String paymentMethod,
//       // String instruction,
//       String address,
//       ) async {
//     const apiUrl = checkoutUrl;
//
//     final prefs = await SharedPreferences.getInstance();
//     final userId = prefs.getString("userId");
//
//     List<Map<String, dynamic>> cartItems = [];
//
// // Iterate over productList and create cart items
//     for (var product in productList) {
//       Map<String, dynamic> cartItem = {
//         "product_name": {
//           "product_name": product["product_name"],
//           "product_id": product["product_id"],
//           "price": product["price"], // Add the price field here
//         },
//         "price": {
//           "product_name": product["product_name"],
//           "product_id": product["product_id"],
//           "price": product["price"], // Add the price field here
//         },
//         "quantity": {
//           "product_name": product["product_name"],
//           "product_id": product["product_id"],
//           "price": product["price"], // Add the price field here
//         },
//         "attribute": {
//           "product_name": product["product_name"],
//           "product_id": product["product_id"],
//           "price": product["price"], // Add the price field here
//         },
//         // Add other required fields here with the appropriate structure
//       };
//       cartItems.add(cartItem);
//     }
//
//
//     // Create the dataMap with cart items and other data
//     Map<String, dynamic> dataMap = {
//       "user_id": userId,
//       "address": address,
//       "city": "Bulandshahr",
//       "state": "UP",
//       "pincode": "245412",
//       "landmark": "This is my landmark",
//       "payment_method": paymentMethod,
//       "total_amount": totalAmount,
//       "tax": 0,
//       "order_by":"user", // user, deliveryMan
//       // "instruction": instruction,
//     };
//
//     // Create the request payload
//     Map<String, dynamic> requestPayload = {
//       'cart': cartItems,
//       'data': dataMap,
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestPayload),
//       );
//
//       var data = jsonDecode(response.body);
//
//       if (data['status'] == 1) {
//         if (paymentMethod == 'online') {
//           // Handle online payment logic here
//           // paymentController.openPaymentPortal(data['paymentOption']);
//         } else {
//           // Handle success dialog or deletion logic here
//           // paymentController.showSuccessDialog();
//           // deleteProduct();
//         }
//
//         if (kDebugMode) {
//           print('Cart sent successfully.');
//           print(data);
//         }
//       } else {
//         if (kDebugMode) {
//           print('Error sending cart. Status code: ${response.statusCode}');
//        print(data);
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error sending cart: $e');
//       }
//     }
//   }
//
  Future<void> sendCartToApi(
      List<List<Map<String, dynamic>>> productListForApi,
      String totalAmount,
      String paymentMethod,
      String address,
      ) async {
    const apiUrl = checkoutUrl;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");

    List<Map<String, dynamic>> cartItems = [];

    List<List<Map<String, dynamic>>> shoppingCart = [];

    for (int i = 0; i < productListForApi.length; i++) {
      var storeProducts = productListForApi[i];
      List<Map<String, dynamic>> storeCartItems = [];

      for (var product in storeProducts) {
        Map<String, dynamic> cartItem = {
          "product_name": product["product_name"],
          "product_id": product["product_id"],
          "price": product["price"],
          "quantity": product["quantity"],
          "attribute": product["attribute"],
          "unit": product["unit"],
          "size": product["size"],
          "store_id": product["store_id"],
          "product_amount": product["price"] * product["quantity"],
          // Add other required fields here with the appropriate structure
        };
        storeCartItems.add(cartItem);
      }

      shoppingCart.add(storeCartItems);
      cartItems.addAll(storeCartItems);
    }

    // Create the dataMap with cart items and other data
    Map<String, dynamic> dataMap = {
      "user_id": userId,
      "address": address,
      "city": "Bulandshahr",
      "state": "UP",
      "pincode": "245412",
      "landmark": "This is my landmark",
      "payment_method": paymentMethod,
      "total_amount": totalAmount,
      "tax": 0,
      "order_by": "user",
      // "instruction": instruction,
    };

    // Create the request payload
    Map<String, dynamic> requestPayload = {
      'cart': cartItems,
      'data': dataMap,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload),
      );

      var data = jsonDecode(response.body);

      if (data['status'] == 1) {
        if (paymentMethod == 'online') {
          // Handle online payment logic here
          // paymentController.openPaymentPortal(data['paymentOption']);
        } else {
          // Handle success dialog or deletion logic here
          // paymentController.showSuccessDialog();
          // deleteProduct();
        }

        if (kDebugMode) {
          print('Cart sent successfully.');
          print(data);
        }
      } else {
        if (kDebugMode) {
          print('Error sending cart. Status code: ${response.statusCode}');
          print(data);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sending cart: $e');
      }
    }
  }



  List<bool> items=[];
  // List<bool> item1=[];

  // List<dynamic> storeCoupon = [];
  // Future<void> fetchCoupons() async {
  //   final response = await http.get(Uri.parse(
  //       '$fetchCoupon+$storeID'));
  //     var couponData = jsonDecode(response.body);
  //
  // if(response.statusCode==200){
  //   setState(() {
  //     storeCoupon.addAll(couponData);
  //     items = List.generate(storeCoupon.length, (index1) => false);
  //   });
  // }
  // }

  // List<dynamic> fetchOffer = [];
  // Future<void> adminOffer() async {
  //   final response = await http.get(Uri.parse('$offerWithStoreUrl+$storeID'));
  //   var offerData = jsonDecode(response.body);
  //   if (offerData['status'] == 1) {
  //     setState(() {
  //       fetchOffer = offerData['offers'];
  //       item1 = List.generate(fetchOffer.length, (index) => false);
  //     });
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  // List additionalProduct = [];
  // Future<void> fetchAdditionalProduct() async {
  //   final response = await http.get(
  //       Uri.parse('$additionProduct+$storeID'));
  //
  //   var productData = jsonDecode(response.body);
  //   if (productData['status'] == 1) {
  //     setState(() {
  //       additionalProduct = productData['data'];
  //     });
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  var map;
  // Future storeWithId() async {
  //   final response = await http.get(
  //     Uri.parse("$store_with_id+$storeID"),
  //   );
  //   var data = jsonDecode(response.body);
  //   if (data['status']==1) {
  //     setState(() {
  //     map = data['data'];
  //     });
  //   }
  // }

  var partnerTip=0;

  bool tipSelected=false;
  String couponTitle = 'Apply Coupons';
  String couponCode = "";
  double offerDiscount = 0;
  int requiredPurchase = 0;
  int? maxDiscount;
  String selectedOption = 'online';
  bool showCharge = false;
  List quant = [];
  String couponType = '';
  String discountTyp = '';
  String dis = '';
  String? message;

  @override
  Widget build(BuildContext context) {
    // String concatenatedString = instructionController.selectedInst.join(", ");
    // concatenatedString = concatenatedString.replaceAll('\n', '');

    String expectedTime =
        map == null ? '' : map['minTime'] + '-' + map['maxTime'];
    String timeType = map == null
        ? ''
        : map['timeType'] == 'minutes'
            ? 'min'
            : "hr";
    double calculatePrice = 0;
    double calculateMRP = 0;
    for (var i = 0; i < productList.length; i++) {
      var price = productList[i].price! * productList[i].quantity!.toDouble();
      var mrp = productList[i].mrp! * productList[i].quantity!.toDouble();
      calculatePrice += price;
      calculateMRP += mrp;
    }

    if (calculatePrice.toInt() < requiredPurchase) {
      for (int i = 0; i < items.length; i++) {
        items[i] = false; // Set all items to false
      }
      // for (int i = 0; i < item1.length; i++) {
      //   item1[i] = false; // Set all item1 to false
      // }
      couponCode = '';
      maxDiscount = null;
      offerDiscount = 0;
    }

    double savedPrice = calculateMRP - calculatePrice + offerDiscount;
    int handlingCharge = map == null ? 0 : map['package_fees'];
    var deliveryFee = 5;
    var grandTotal =
        calculatePrice + handlingCharge + deliveryFee - offerDiscount;

    Size size = MediaQuery.of(context).size;

    return productList.isEmpty
        ? const CartEmpty()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white100,
                ),
              ),
              centerTitle: true,
              title: Text(
                "My Cart",
                // productList[0].storeName.toString(),
                style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(
                  color: AppColors.white100,
                ),
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.white10,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ContainerWidget(
                            height: 45,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.access_alarm_rounded,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Expected delivery $expectedTime $timeType'),
                              ],
                            )),
                        const SizedBox(height: 10),
                        // const AddedItem(),
                        ContainerWidget(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8.0, right: 8.0,bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${productList.length} Items added',
                                  style: AppTextStyles.kBody15SemiboldTextStyle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.separated(
                                  reverse: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: productList.length,

                                    itemBuilder: (BuildContext context, index) {
                                      var price = productList[index].price! *
                                          productList[index].quantity!.toInt();
                                      var mrp = productList[index].mrp! *
                                          productList[index].quantity!.toInt();
                                      var Size = productList[index]
                                              .size
                                              .toString() +
                                          productList[index].unit.toString();

                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  width: 65,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                    child: CachedNetworkImage(
                                                        imageUrl: productList[index]
                                                          .imageUrl
                                                          .toString(),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 8.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    productList[index]
                                                        .name
                                                        .toString().capitalizeFirst!,
                                                    style: AppTextStyles
                                                        .kBody15SemiboldTextStyle,
                                                  ),
                                                  Text(
                                                      productList[index]
                                                          .storeName
                                                          .toString(),
                                                      style: AppTextStyles
                                                          .kCaption12SemiboldTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white60)),
                                                  Text(Size,
                                                      style: AppTextStyles
                                                          .kSmall10RegularTextStyle
                                                          .copyWith(
                                                              color: AppColors
                                                                  .white60)),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '₹$price',
                                                        style: AppTextStyles
                                                            .kCaption12SemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .primary),
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        '₹$mrp',
                                                        style: AppTextStyles
                                                            .kSmall10RegularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white60,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  CounterWidget(
                                                    height: size.height * 0.032,
                                                    width: size.width * 0.18,
                                                    plusOntap: () {
                                                      for (var i = 0;
                                                          i <
                                                              productList
                                                                  .length;
                                                          i++) {
                                                        var productId =
                                                            productList[i]
                                                                .productId;
                                                        var productSize =
                                                            productList[i].size;
                                                        if (productId ==
                                                                productList[
                                                                        index]
                                                                    .productId
                                                                    .toString() &&
                                                            productSize ==
                                                                productList[
                                                                        index]
                                                                    .size!
                                                                    .toInt()) {
                                                          updateProduct(
                                                              productList[index]
                                                                  .productId
                                                                  .toString(),
                                                              productList[index]
                                                                  .size!
                                                                  .toInt(),
                                                              productList[i]
                                                                      .quantity!
                                                                      .toInt() +
                                                                  1);
                                                          fetchProducts();
                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                    minusOntap: () {
                                                      for (var j = 0;
                                                          j <
                                                              productList
                                                                  .length;
                                                          j++) {
                                                        var productId =
                                                            productList[j]
                                                                .productId;
                                                        var productSize =
                                                            productList[j].size;

                                                        if (productId ==
                                                                productList[
                                                                        index]
                                                                    .productId
                                                                    .toString() &&
                                                            productSize ==
                                                                productList[
                                                                        index]
                                                                    .size!
                                                                    .toInt()) {
                                                          if (productList[j]
                                                                  .quantity!
                                                                  .toInt() >
                                                              1) {
                                                            updateProduct(
                                                                productList[
                                                                        index]
                                                                    .productId
                                                                    .toString(),
                                                                productList[
                                                                        index]
                                                                    .size!
                                                                    .toInt(),
                                                                productList[j]
                                                                        .quantity!
                                                                        .toInt() -
                                                                    1);
                                                            fetchProducts();
                                                          } else {
                                                            removeProduct(
                                                                productList[j]
                                                                    .id!
                                                                    .toInt());
                                                            fetchProducts();
                                                          }
                                                        }
                                                      }
                                                    },
                                                    // counterValue:productList[index2].quantity,
                                                    counterValue:
                                                        productList[index]
                                                            .quantity,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          // index != productList.length - 1
                                          //     ? const Divider(
                                          //         color: AppColors.white40,
                                          //         thickness: 1,
                                          //       )
                                          //     : const SizedBox(
                                          //         height: 10,
                                          //       ),
                                        ],
                                      );
                                    }, separatorBuilder: (BuildContext context, int index) {return  const Divider(
                                  color: AppColors.white40,
                                  thickness: 1,
                                ) ;},),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Stack(
                        //   children: [
                        //     TextFormField(
                        //       controller: msgController,
                        //       maxLines: null,
                        //       maxLength: 150,
                        //       cursorColor: AppColors.primary,
                        //       keyboardType: TextInputType.text,
                        //       onEditingComplete: () {
                        //         FocusScope.of(context)
                        //             .unfocus(); // Dismiss the keyboard
                        //         setState(() {
                        //           message = msgController.text.toString();
                        //         });
                        //       },
                        //       decoration: const InputDecoration(
                        //         enabledBorder: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(10.0)),
                        //           borderSide: BorderSide(
                        //               color: AppColors.white30, width: 1.5),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(10.0)),
                        //           borderSide: BorderSide(
                        //               color: AppColors.white40, width: 1.5),
                        //         ),
                        //         hintText: 'Start typing...',
                        //         labelStyle: TextStyle(color: AppColors.primary),
                        //         labelText: 'Add cooking instructions',
                        //         contentPadding: EdgeInsets.all(10),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       bottom: 20,
                        //       right: 0,
                        //       child: IconButton(
                        //         onPressed: () {
                        //           FocusScope.of(context)
                        //               .unfocus(); // Dismiss the keyboard
                        //           setState(() {
                        //             message = msgController.text.toString();
                        //           });
                        //         },
                        //         icon: const Icon(
                        //           Icons.send_rounded,
                        //           color: AppColors.primary,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 15),
                        // const AddMoreItems(),
                        // ContainerWidget(
                        //     child: Column(
                        //   children: [
                        //     ListTile(
                        //       onTap: () {
                        //         // Get.to(StoreDetails(
                        //         //   storeID: storeID,
                        //         // ));
                        //       },
                        //       leading: const Icon(
                        //         Icons.add,
                        //         color: AppColors.primary,
                        //       ),
                        //       title: const Text('Add more item to this order'),
                        //       trailing: const Icon(
                        //         Icons.arrow_forward_ios,
                        //         color: AppColors.white100,
                        //         size: 20,
                        //       ),
                        //     ),
                        //     Container(
                        //       height: 180,
                        //       decoration: const BoxDecoration(
                        //           border: Border(
                        //         top: BorderSide(color: AppColors.white30),
                        //         bottom: BorderSide(color: AppColors.white30),
                        //       )),
                        //       child: Obx(() {
                        //         return ListView.builder(
                        //             scrollDirection: Axis.horizontal,
                        //             itemCount: additionalProduct.length,
                        //             itemBuilder: (BuildContext context, index) {
                        //               final product = additionalProduct[index];
                        //               var varientsDetails =
                        //                   product['variantDetails'].toString();
                        //               var output = jsonDecode(varientsDetails);
                        //               var productName =
                        //                   product['name'].toString();
                        //               var productId = product['id'].toString();
                        //               var productimg =
                        //                   product['image_url'].toString();
                        //               var productAttributes =
                        //                   product['attribute']['name']
                        //                       .toString();
                        //
                        //               var type = output[0]["type"].toString();
                        //               var mrp = double.parse(
                        //                   output[0]["price"].toString());
                        //               var discountType =
                        //                   output[0]["discountType"].toString();
                        //               var discount = double.parse(
                        //                   output[0]["discount"].toString());
                        //               var price = discountType == 'amount'
                        //                   ? mrp - discount
                        //                   : mrp - ((mrp * discount) / 100);
                        //               var unit = output[0]["unit"].toString();
                        //
                        //               bool show = false;
                        //               if (productList.isNotEmpty) {
                        //                 for (var i = 0;
                        //                     i < productList.length;
                        //                     i++) {
                        //                   var databasePID =
                        //                       productList[i].productId;
                        //                   quant = List.generate(
                        //                       additionalProduct.length,
                        //                       (index) =>
                        //                           productList[i].quantity);
                        //                   var databasePsize =
                        //                       productList[i].size;
                        //                   if (databasePID ==
                        //                           product['id'].toString() &&
                        //                       databasePsize ==
                        //                           int.parse(type)) {
                        //                     show = true;
                        //                     break;
                        //                   }
                        //                 }
                        //               }
                        //
                        //               return SizedBox(
                        //                 width: 120,
                        //                 child: Card(
                        //                   elevation: 1,
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(5),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Stack(
                        //                           children: [
                        //                             Align(
                        //                                 alignment:
                        //                                     Alignment.topCenter,
                        //                                 child: Image.network(
                        //                                   product['image_url']
                        //                                       .toString(),
                        //                                   height: 70,
                        //                                   // width: 70,
                        //                                   fit: BoxFit.fill,
                        //                                 )),
                        //                           ],
                        //                         ),
                        //                         Text(
                        //                           product['name'].toString(),
                        //                           style: AppTextStyles
                        //                               .kBody15SemiboldTextStyle,
                        //                         ),
                        //                         GestureDetector(
                        //                           onTap: () {
                        //                             Get.bottomSheet(
                        //                               SingleChildScrollView(
                        //                                 physics:
                        //                                     const NeverScrollableScrollPhysics(),
                        //                                 child:
                        //                                     VarientBottmSheet(
                        //                                   storeName:
                        //                                       productList[0]
                        //                                           .storeName
                        //                                           .toString(),
                        //                                   pId: productId,
                        //                                   storeId: storeID,
                        //                                   pAttributes:
                        //                                       productAttributes,
                        //                                   varientsDetails:
                        //                                       output,
                        //                                   productImg:
                        //                                       productimg,
                        //                                   productName:
                        //                                       productName,
                        //                                 ),
                        //                               ),
                        //                             );
                        //                           },
                        //                           child: Row(
                        //                             children: [
                        //                               Text(
                        //                                 type + unit,
                        //                                 style: AppTextStyles
                        //                                     .kCaption12RegularTextStyle,
                        //                               ),
                        //                               output.length == 1
                        //                                   ? const Text('')
                        //                                   : const Icon(
                        //                                       Icons
                        //                                           .keyboard_arrow_down_rounded,
                        //                                       color: AppColors
                        //                                           .primary,
                        //                                     )
                        //                             ],
                        //                           ),
                        //                         ),
                        //                         Row(
                        //                           mainAxisAlignment:
                        //                               MainAxisAlignment
                        //                                   .spaceBetween,
                        //                           children: [
                        //                             Column(
                        //                               children: [
                        //                                 Text(
                        //                                   '₹${price.toInt()}',
                        //                                   style: AppTextStyles
                        //                                       .kCaption12SemiboldTextStyle,
                        //                                 ),
                        //                                 Text(
                        //                                   '₹${mrp.toInt()}',
                        //                                   style: AppTextStyles
                        //                                       .kSmall10RegularTextStyle
                        //                                       .copyWith(
                        //                                           color: AppColors
                        //                                               .white60,
                        //                                           decoration:
                        //                                               TextDecoration
                        //                                                   .lineThrough),
                        //                                 ),
                        //                               ],
                        //                             ),
                        //                             !show
                        //                                 ? SizedBox(
                        //                                     height: 40,
                        //                                     width: 40,
                        //                                     child: InkWell(
                        //                                         onTap: () {
                        //                                           if (productList
                        //                                                   .isEmpty ||
                        //                                               productList[0]
                        //                                                       .storeId ==
                        //                                                   storeID) {
                        //                                             addProductToDatabase(
                        //                                                 productName,
                        //                                                 price,
                        //                                                 mrp,
                        //                                                 productList[0]
                        //                                                     .storeName
                        //                                                     .toString(),
                        //                                                 productimg,
                        //                                                 int.parse(
                        //                                                     type),
                        //                                                 productId,
                        //                                                 storeID,
                        //                                                 unit,
                        //                                                 1,
                        //                                                 productAttributes);
                        //                                           } else {
                        //                                             showDialog(
                        //                                               context:
                        //                                                   context,
                        //                                               builder:
                        //                                                   (BuildContext
                        //                                                       context) {
                        //                                                 return ConstAlert(
                        //                                                   addedStore: productList[0]
                        //                                                       .storeName
                        //                                                       .toString(),
                        //                                                   toAddStore: productList[0]
                        //                                                       .storeName
                        //                                                       .toString(),
                        //                                                   replaceOntap:
                        //                                                       () {
                        //                                                     deleteProduct();
                        //                                                     addProductToDatabase(
                        //                                                         productName,
                        //                                                         price,
                        //                                                         mrp,
                        //                                                         productList[0].storeName.toString(),
                        //                                                         productimg,
                        //                                                         int.parse(type),
                        //                                                         productId,
                        //                                                         storeID,
                        //                                                         unit,
                        //                                                         1,
                        //                                                         productAttributes);
                        //                                                     Get.back();
                        //                                                     setState(() {
                        //                                                       fetchProducts();
                        //                                                     });
                        //                                                   },
                        //                                                 );
                        //                                               },
                        //                                             );
                        //                                           }
                        //                                           fetchProducts();
                        //                                           setState(
                        //                                               () {});
                        //                                         },
                        //                                         child:
                        //                                             const Card(
                        //                                           elevation: 1,
                        //                                           child: Icon(
                        //                                             Icons.add,
                        //                                             size: 18,
                        //                                             color: AppColors
                        //                                                 .primary,
                        //                                           ),
                        //                                         )),
                        //                                   )
                        //                                 : CounterWidget(
                        //                                     height:
                        //                                         size.height *
                        //                                             0.032,
                        //                                     width: size.width *
                        //                                         0.18,
                        //                                     plusOntap: () {
                        //                                       for (var i = 0;
                        //                                           i <
                        //                                               productList
                        //                                                   .length;
                        //                                           i++) {
                        //                                         var productId =
                        //                                             productList[
                        //                                                     i]
                        //                                                 .productId;
                        //                                         var productSize =
                        //                                             productList[
                        //                                                     i]
                        //                                                 .size;
                        //                                         if (productId ==
                        //                                                 product['id']
                        //                                                     .toString() &&
                        //                                             productSize ==
                        //                                                 int.parse(
                        //                                                     type)) {
                        //                                           updateProduct(
                        //                                               product['id']
                        //                                                   .toString(),
                        //                                               int.parse(
                        //                                                   type),
                        //                                               productList[i]
                        //                                                       .quantity!
                        //                                                       .toInt() +
                        //                                                   1);
                        //                                           fetchProducts();
                        //                                           // print(productList[i].id!.toInt());
                        //                                         }
                        //                                       }
                        //                                     },
                        //                                     minusOntap: () {
                        //                                       for (var j = 0;
                        //                                           j <
                        //                                               productList
                        //                                                   .length;
                        //                                           j++) {
                        //                                         var productId =
                        //                                             productList[
                        //                                                     j]
                        //                                                 .productId;
                        //                                         var productSize =
                        //                                             productList[
                        //                                                     j]
                        //                                                 .size;
                        //                                         if (productId ==
                        //                                                 product['id']
                        //                                                     .toString() &&
                        //                                             productSize ==
                        //                                                 int.parse(
                        //                                                     type)) {
                        //                                           if (productList[
                        //                                                       j]
                        //                                                   .quantity!
                        //                                                   .toInt() >
                        //                                               1) {
                        //                                             updateProduct(
                        //                                                 product['id']
                        //                                                     .toString(),
                        //                                                 int.parse(
                        //                                                     type),
                        //                                                 productList[j].quantity!.toInt() -
                        //                                                     1);
                        //                                             fetchProducts();
                        //                                             if (kDebugMode) {
                        //                                               print(productList[
                        //                                                       j]
                        //                                                   .quantity!
                        //                                                   .toInt());
                        //                                             }
                        //                                           } else {
                        //                                             removeProduct(
                        //                                                 productList[j]
                        //                                                     .id!
                        //                                                     .toInt());
                        //                                             fetchProducts();
                        //                                           }
                        //                                         }
                        //                                       }
                        //                                     },
                        //                                     // counterValue:productList[index2].quantity,
                        //                                     counterValue:
                        //                                         quant[index],
                        //                                   ),
                        //                           ],
                        //                         )
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               );
                        //             });
                        //       }),
                        //     ),
                        //   ],
                        // )),
                        const SizedBox(height: 15),
                        // const BillSummary(),
                        ContainerWidget(
                            width: size.width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Bill Summary',
                                        style: AppTextStyles
                                            .kBody17RegularTextStyle,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Subtotal',
                                            style: AppTextStyles
                                                .kBody15SemiboldTextStyle,
                                          ),
                                          const Spacer(),
                                          Text(
                                            '₹$calculateMRP',
                                            style: AppTextStyles
                                                .kSmall10RegularTextStyle
                                                .copyWith(
                                                    color: AppColors.white60,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '₹${calculatePrice.toStringAsFixed(1)}',
                                            style: AppTextStyles
                                                .kCaption12SemiboldTextStyle,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Obx(() => tipController.customTip.value != 0
                                          ? Row(
                                              children: [
                                                Text(
                                                  'Delivery Partner Tip',
                                                  style: AppTextStyles
                                                      .kCaption12RegularTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .white60),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '₹${tipController.customTip}',
                                                  style: AppTextStyles
                                                      .kCaption12SemiboldTextStyle,
                                                ),
                                              ],
                                            )
                                          : const SizedBox()),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showCharge = !showCharge;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            const Text(
                                              'Charges & Taxes',
                                              style: AppTextStyles
                                                  .kBody15SemiboldTextStyle,
                                            ),
                                            const Spacer(),
                                            Icon(!showCharge
                                                ? Icons.arrow_drop_down
                                                : Icons.arrow_drop_up),
                                          ],
                                        ),
                                      ),
                                      showCharge
                                          ? ContainerWidget(
                                              child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  map != null
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Handling Charge',
                                                              style: AppTextStyles
                                                                  .kCaption12RegularTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .white60),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              '₹$handlingCharge',
                                                              style: AppTextStyles
                                                                  .kCaption12SemiboldTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .white100),
                                                            ),
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Delivery fee',
                                                        style: AppTextStyles
                                                            .kCaption12RegularTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white60),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '₹$deliveryFee',
                                                        style: AppTextStyles
                                                            .kCaption12SemiboldTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .white100),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ))
                                          : const SizedBox(),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                      offerDiscount != 0
                                          ? Row(
                                              children: [
                                                Text(
                                                  'Offer Discount',
                                                  style: AppTextStyles
                                                      .kCaption12RegularTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .success40),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '- ₹$offerDiscount',
                                                  style: AppTextStyles
                                                      .kCaption12SemiboldTextStyle,
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Grand Total',
                                            style: AppTextStyles
                                                .kBody15SemiboldTextStyle,
                                          ),
                                          Obx(
                                            () =>
                                                Text('₹${(grandTotal + tipController.customTip.toInt()).toStringAsFixed(2)}', style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.primary)),

                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.success10,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/congrets.png',
                                        height: 35,
                                        width: 35,
                                      ),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: 'You saved',
                                          style: AppTextStyles
                                              .kBody15RegularTextStyle
                                              .copyWith(
                                            color: AppColors.success60,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ' ₹${savedPrice.toStringAsFixed(2)} ',
                                              style: AppTextStyles
                                                  .kBody15RegularTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.success60,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            const TextSpan(
                                                text: 'on this order'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        //apply coupons
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.bottomSheet(
                        //       Container(
                        //         decoration: const BoxDecoration(
                        //             color: AppColors.white,
                        //             borderRadius: BorderRadius.only(
                        //               topRight: Radius.circular(20),
                        //               topLeft: Radius.circular(20),
                        //             )),
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: NotificationListener<
                        //             OverscrollIndicatorNotification>(
                        //           onNotification: (notification) {
                        //             notification.disallowIndicator();
                        //             return true;
                        //           },
                        //           child: ListView(
                        //             scrollDirection: Axis.vertical,
                        //             children: [
                        //               const SizedBox(
                        //                 height: 10,
                        //               ),
                        //               Text(
                        //                 'Apply Coupons',
                        //                 style: AppTextStyles
                        //                     .kBody15SemiboldTextStyle
                        //                     .copyWith(color: AppColors.primary),
                        //               ),
                        //               const SizedBox(
                        //                 height: 10,
                        //               ),
                        //               storeCoupon.isEmpty && fetchOffer.isEmpty
                        //                   ? const SizedBox(
                        //                       child:
                        //                           Text('No Coupons available'),
                        //                     )
                        //                   : SizedBox(
                        //                       child: Column(
                        //                         children: [
                        //                           storeCoupon.isEmpty
                        //                               ? const SizedBox()
                        //                               : SizedBox(
                        //                                   child:
                        //                                       ListView.builder(
                        //                                           physics:
                        //                                               const NeverScrollableScrollPhysics(),
                        //                                           shrinkWrap:
                        //                                               true,
                        //                                           itemCount:
                        //                                               storeCoupon
                        //                                                   .length,
                        //                                           itemBuilder:
                        //                                               (BuildContext
                        //                                                       context,
                        //                                                   index1) {
                        //                                             final coupon =
                        //                                                 storeCoupon[
                        //                                                     index1];
                        //                                             String
                        //                                                 discount =
                        //                                                 coupon['discount']
                        //                                                     .toString();
                        //                                             int maximumDis =
                        //                                                 int.parse(
                        //                                                     coupon['maxDiscount'].toString());
                        //                                             String
                        //                                                 discountType =
                        //                                                 coupon[
                        //                                                     'discountType'];
                        //                                             String
                        //                                                 discountCode =
                        //                                                 coupon['code']
                        //                                                     .toString();
                        //                                             String
                        //                                                 validTill =
                        //                                                 coupon['endDate']
                        //                                                     .toString();
                        //                                             int minPurchase =
                        //                                                 int.parse(
                        //                                                     coupon['minPurchase'].toString());
                        //                                             int maxDis = discountType ==
                        //                                                     'percent'
                        //                                                 ? maximumDis
                        //                                                 : int.parse(
                        //                                                     discount);
                        //                                             double
                        //                                                 calculatePerDis =
                        //                                                 (calculatePrice *
                        //                                                         int.parse(discount)) /
                        //                                                     100;
                        //                                             double?
                        //                                                 setPerDis;
                        //                                             if (discountType ==
                        //                                                     'percent' &&
                        //                                                 calculatePerDis <
                        //                                                     maximumDis) {
                        //                                               setPerDis =
                        //                                                   calculatePerDis;
                        //                                             } else {
                        //                                               setPerDis =
                        //                                                   maximumDis
                        //                                                       .toDouble();
                        //                                             }
                        //                                             return Container(
                        //                                               margin:
                        //                                                   const EdgeInsets.all(
                        //                                                       4),
                        //                                               padding:
                        //                                                   const EdgeInsets.all(
                        //                                                       4),
                        //                                               alignment:
                        //                                                   Alignment
                        //                                                       .center,
                        //                                               decoration: BoxDecoration(
                        //                                                   borderRadius: BorderRadius.circular(
                        //                                                       15),
                        //                                                   border: Border.all(
                        //                                                       color: AppColors.white30,
                        //                                                       width: 1.5),
                        //                                                   color: AppColors.white10),
                        //                                               child:
                        //                                                   Row(
                        //                                                 mainAxisAlignment:
                        //                                                     MainAxisAlignment.spaceBetween,
                        //                                                 children: [
                        //                                                   const SizedBox(
                        //                                                     width:
                        //                                                         0,
                        //                                                   ),
                        //                                                   Image
                        //                                                       .asset(
                        //                                                     'assets/icons/storeoffer.png',
                        //                                                     height:
                        //                                                         35,
                        //                                                     width:
                        //                                                         35,
                        //                                                   ),
                        //                                                   Container(
                        //                                                     width:
                        //                                                         size.width * 0.5,
                        //                                                     decoration:
                        //                                                         BoxDecoration(
                        //                                                       color: AppColors.white,
                        //                                                       borderRadius: BorderRadius.circular(10),
                        //                                                     ),
                        //                                                     child:
                        //                                                         Padding(
                        //                                                       padding: const EdgeInsets.only(left: 10.0),
                        //                                                       child: Column(
                        //                                                         mainAxisAlignment: MainAxisAlignment.center,
                        //                                                         crossAxisAlignment: CrossAxisAlignment.start,
                        //                                                         children: [
                        //                                                           Text(
                        //                                                             discountType == 'amount' ? '₹$discount OFF' : '$discount% OFF',
                        //                                                             style: AppTextStyles.kBody15SemiboldTextStyle,
                        //                                                           ),
                        //                                                           RichText(
                        //                                                             text: TextSpan(
                        //                                                               text: 'use code ',
                        //                                                               style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70),
                        //                                                               children: <TextSpan>[
                        //                                                                 TextSpan(text: discountCode, style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white90)),
                        //                                                               ],
                        //                                                             ),
                        //                                                           ),
                        //                                                           Text('Min Order - ₹$minPurchase', style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70)),
                        //                                                           Text('Valid Till - ${validTill.substring(0, 10)}', style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70)),
                        //                                                         ],
                        //                                                       ),
                        //                                                     ),
                        //                                                   ),
                        //                                                   SizedBox(
                        //                                                       height: 30,
                        //                                                       width: 70,
                        //                                                       child: CustomBtn(
                        //                                                         btnTitle: items[index1] == false ? 'Apply' : 'Applied',
                        //                                                         onTap: () {
                        //                                                           if (calculatePrice.toInt() >= minPurchase) {
                        //                                                             if (couponType == 'admin') {
                        //                                                               for (int i = 0; i < item1.length; i++) {
                        //                                                                 item1[i] = false; // Set all items to false
                        //                                                               }
                        //                                                             }
                        //                                                             for (int i = 0; i < items.length; i++) {
                        //                                                               items[i] = i == index1;
                        //                                                             }
                        //                                                             setState(() {
                        //                                                               couponCode = discountCode.toString();
                        //                                                               offerDiscount = (discountType == 'percent' ? setPerDis : double.parse(discount))!;
                        //                                                               requiredPurchase = minPurchase;
                        //                                                               maxDiscount = maxDis;
                        //                                                               couponType = 'store';
                        //                                                               discountTyp = discountType;
                        //                                                               dis = discount;
                        //                                                               Get.back();
                        //                                                             });
                        //                                                           } else {
                        //                                                             Fluttertoast.showToast(
                        //                                                               msg: 'Order value should be greater than $minPurchase to avail this offer',
                        //                                                               toastLength: Toast.LENGTH_SHORT,
                        //                                                               gravity: ToastGravity.BOTTOM,
                        //                                                               fontSize: 15.0,
                        //                                                             );
                        //                                                           }
                        //                                                         },
                        //                                                         btnColor: items[index1] == false ? AppColors.primary400 : AppColors.success20,
                        //                                                       )),
                        //                                                 ],
                        //                                               ),
                        //                                             );
                        //                                           }),
                        //                                 ),
                        //                           fetchOffer.isEmpty
                        //                               ? const SizedBox()
                        //                               : SizedBox(
                        //                                   child:
                        //                                       ListView.builder(
                        //                                           physics:
                        //                                               const NeverScrollableScrollPhysics(),
                        //                                           shrinkWrap:
                        //                                               true,
                        //                                           itemCount:
                        //                                               fetchOffer
                        //                                                   .length,
                        //                                           itemBuilder:
                        //                                               (BuildContext
                        //                                                       context,
                        //                                                   index) {
                        //                                             final offer =
                        //                                                 fetchOffer[
                        //                                                     index];
                        //                                             String
                        //                                                 discount =
                        //                                                 offer['discount']
                        //                                                     .toString();
                        //                                             double?
                        //                                                 maximumDis =
                        //                                                 double.tryParse(
                        //                                                     offer['maxDiscount'].toString());
                        //                                             String
                        //                                                 discountType =
                        //                                                 offer['coupon_type']
                        //                                                     .toString();
                        //                                             String
                        //                                                 discountCode =
                        //                                                 offer['code']
                        //                                                     .toString();
                        //                                             String
                        //                                                 validTill =
                        //                                                 offer['endDate']
                        //                                                     .toString();
                        //                                             int minPurchase =
                        //                                                 int.parse(
                        //                                                     offer['minPurchase'].toString());
                        //                                             int maxDis = discountType ==
                        //                                                     'percentage'
                        //                                                 ? maximumDis!
                        //                                                     .toInt()
                        //                                                 : int.parse(
                        //                                                     discount);
                        //                                             double
                        //                                                 calculatePerDis =
                        //                                                 (calculatePrice *
                        //                                                         int.parse(discount)) /
                        //                                                     100;
                        //                                             double?
                        //                                                 setPerDis;
                        //                                             if (discountType ==
                        //                                                     'percentage' &&
                        //                                                 calculatePerDis <
                        //                                                     maximumDis!) {
                        //                                               setPerDis =
                        //                                                   calculatePerDis;
                        //                                             } else {
                        //                                               setPerDis =
                        //                                                   maximumDis;
                        //                                             }
                        //                                             return Container(
                        //                                               margin:
                        //                                                   const EdgeInsets.all(
                        //                                                       4),
                        //                                               padding:
                        //                                                   const EdgeInsets.all(
                        //                                                       4),
                        //                                               alignment:
                        //                                                   Alignment
                        //                                                       .center,
                        //                                               decoration: BoxDecoration(
                        //                                                   borderRadius: BorderRadius.circular(
                        //                                                       15),
                        //                                                   border: Border.all(
                        //                                                       color: AppColors.white30,
                        //                                                       width: 1.5),
                        //                                                   color: AppColors.white10),
                        //                                               child:
                        //                                                   Row(
                        //                                                 mainAxisAlignment:
                        //                                                     MainAxisAlignment.spaceBetween,
                        //                                                 children: [
                        //                                                   const SizedBox(
                        //                                                     width:
                        //                                                         0,
                        //                                                   ),
                        //                                                   Image
                        //                                                       .asset(
                        //                                                     'assets/icons/storeoffer.png',
                        //                                                     height:
                        //                                                         35,
                        //                                                     width:
                        //                                                         35,
                        //                                                   ),
                        //                                                   Container(
                        //                                                     width:
                        //                                                         size.width * 0.5,
                        //                                                     decoration:
                        //                                                         BoxDecoration(
                        //                                                       color: AppColors.white,
                        //                                                       borderRadius: BorderRadius.circular(10),
                        //                                                     ),
                        //                                                     child:
                        //                                                         Padding(
                        //                                                       padding: const EdgeInsets.only(left: 10.0),
                        //                                                       child: Column(
                        //                                                         mainAxisAlignment: MainAxisAlignment.center,
                        //                                                         crossAxisAlignment: CrossAxisAlignment.start,
                        //                                                         children: [
                        //                                                           Text(
                        //                                                             discountType == 'flat' ? '₹$discount OFF' : '$discount% OFF',
                        //                                                             style: AppTextStyles.kBody15SemiboldTextStyle,
                        //                                                           ),
                        //                                                           RichText(
                        //                                                             text: TextSpan(
                        //                                                               text: 'use code ',
                        //                                                               style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70),
                        //                                                               children: <TextSpan>[
                        //                                                                 TextSpan(text: discountCode, style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(color: AppColors.white90)),
                        //                                                               ],
                        //                                                             ),
                        //                                                           ),
                        //                                                           Text('Min Order - ₹$minPurchase', style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70)),
                        //                                                           Text('Valid Till - ${validTill.substring(0, 10)}', style: AppTextStyles.kCaption12RegularTextStyle.copyWith(color: AppColors.white70)),
                        //                                                         ],
                        //                                                       ),
                        //                                                     ),
                        //                                                   ),
                        //                                                   SizedBox(
                        //                                                       height: 30,
                        //                                                       width: 70,
                        //                                                       child: CustomBtn(
                        //                                                         btnTitle: item1[index] == false ? 'Apply' : 'Applied',
                        //                                                         onTap: () {
                        //                                                           if (calculatePrice.toInt() >= minPurchase) {
                        //                                                             if (couponType == 'store') {
                        //                                                               for (int i = 0; i < items.length; i++) {
                        //                                                                 items[i] = false; // Set all items to false
                        //                                                               }
                        //                                                             }
                        //                                                             for (int i = 0; i < item1.length; i++) {
                        //                                                               item1[i] = i == index;
                        //                                                             }
                        //                                                             setState(() {
                        //                                                               couponCode = discountCode.toString();
                        //                                                               offerDiscount = (discountType == 'percentage' ? setPerDis! : double.parse(discount));
                        //                                                               requiredPurchase = minPurchase;
                        //                                                               maxDiscount = maxDis;
                        //                                                               couponType = 'admin';
                        //                                                               discountTyp = discountType;
                        //                                                               dis = discount;
                        //                                                               Get.back();
                        //                                                             });
                        //                                                           } else {
                        //                                                             Fluttertoast.showToast(
                        //                                                               msg: 'Order value should be greater than $minPurchase to avail this offer',
                        //                                                               toastLength: Toast.LENGTH_SHORT,
                        //                                                               gravity: ToastGravity.BOTTOM,
                        //                                                               fontSize: 15.0,
                        //                                                             );
                        //                                                           }
                        //                                                         },
                        //                                                         btnColor: item1[index] == false ? AppColors.primary400 : AppColors.success20,
                        //                                                       )),
                        //                                                 ],
                        //                                               ),
                        //                                             );
                        //                                           }),
                        //                                 ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: ContainerWidget(
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Row(
                        //         children: [
                        //           Image.asset(
                        //             'assets/icons/offer.png',
                        //             height: 35,
                        //             width: 35,
                        //           ),
                        //           const SizedBox(
                        //             width: 25,
                        //           ),
                        //           Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               couponCode == ''
                        //                   ? Text(
                        //                       couponTitle,
                        //                       style: AppTextStyles
                        //                           .kBody15SemiboldTextStyle,
                        //                     )
                        //                   : Text(
                        //                       'Code - $couponCode Applied',
                        //                       style: AppTextStyles
                        //                           .kBody15SemiboldTextStyle
                        //                           .copyWith(
                        //                               color:
                        //                                   AppColors.success40),
                        //                     ),
                        //               maxDiscount == null
                        //                   ? const SizedBox()
                        //                   : Text(
                        //                       discountTyp == 'flat' ||
                        //                               discountTyp == 'amount'
                        //                           ? 'You can save upto ₹$maxDiscount'
                        //                           : 'You can save $dis% upto ₹$maxDiscount',
                        //                       style: AppTextStyles
                        //                           .kCaption12RegularTextStyle,
                        //                     ),
                        //             ],
                        //           ),
                        //           const Spacer(),
                        //           couponCode == ''
                        //               ? const Icon(
                        //                   Icons.arrow_forward_ios,
                        //                 )
                        //               : IconButton(
                        //                   onPressed: () {
                        //                     if (couponType == 'store') {
                        //                       setState(() {
                        //                         for (int i = 0;
                        //                             i < items.length;
                        //                             i++) {
                        //                           items[i] =
                        //                               false; // Set all items to false
                        //                         }
                        //                         couponCode = '';
                        //                         maxDiscount = null;
                        //                         offerDiscount = 0;
                        //                       });
                        //                     } else {
                        //                       setState(() {
                        //                         for (int i = 0;
                        //                             i < item1.length;
                        //                             i++) {
                        //                           item1[i] =
                        //                               false; // Set all items to false
                        //                         }
                        //                         couponCode = '';
                        //                         maxDiscount = null;
                        //                         offerDiscount = 0;
                        //                       });
                        //                     }
                        //                   },
                        //                   icon: const Icon(
                        //                     CupertinoIcons.multiply_circle,
                        //                     color: AppColors.primary,
                        //                   )),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 15),
                        // const DeliveryTip(),
                        // ContainerWidget(
                        //     width: size.width,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: GetBuilder<TipController>(
                        //           builder: (tipController) {
                        //         return Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             const Text(
                        //               'Delivery Partner Tip',
                        //               style: AppTextStyles
                        //                   .kBody17SemiboldTextStyle,
                        //             ),
                        //             Text(
                        //               '100% of your tip will go directly to your delivery partner',
                        //               style: AppTextStyles
                        //                   .kCaption12RegularTextStyle
                        //                   .copyWith(color: AppColors.white60),
                        //             ),
                        //             const SizedBox(height: 10),
                        //             // Row(
                        //             //   mainAxisAlignment:
                        //             //       MainAxisAlignment.spaceAround,
                        //             //   children: [
                        //             //     TipAmountContainer(
                        //             //       amount: 5,
                        //             //       isSelected:
                        //             //           tipController.selectedTipIndex ==
                        //             //               0,
                        //             //       img: 'assets/icons/10star.png',
                        //             //       onTap: () {
                        //             //         if (tipController
                        //             //                 .selectedTipIndex ==
                        //             //             0) {
                        //             //           tipController.nonSelectedTip();
                        //             //         } else {
                        //             //           tipController.selectPresetTip(
                        //             //               0, 5);
                        //             //         }
                        //             //       },
                        //             //     ),
                        //             //     TipAmountContainer(
                        //             //       amount: 10,
                        //             //       isSelected:
                        //             //           tipController.selectedTipIndex ==
                        //             //               1,
                        //             //       img: 'assets/icons/15star.png',
                        //             //       onTap: () {
                        //             //         if (tipController
                        //             //                 .selectedTipIndex ==
                        //             //             1) {
                        //             //           tipController.nonSelectedTip();
                        //             //         } else {
                        //             //           tipController.selectPresetTip(
                        //             //               1, 10);
                        //             //         }
                        //             //       },
                        //             //     ),
                        //             //     TipAmountContainer(
                        //             //       amount: 15,
                        //             //       isSelected:
                        //             //           tipController.selectedTipIndex ==
                        //             //               2,
                        //             //       img: 'assets/icons/15star.png',
                        //             //       onTap: () {
                        //             //         if (tipController
                        //             //                 .selectedTipIndex ==
                        //             //             2) {
                        //             //           tipController.nonSelectedTip();
                        //             //         } else {
                        //             //           tipController.selectPresetTip(
                        //             //               2, 15);
                        //             //         }
                        //             //       },
                        //             //     ),
                        //             //     GestureDetector(
                        //             //       onTap: tipController.showCustomTip,
                        //             //       child: Container(
                        //             //         height: 30,
                        //             //         width: 70,
                        //             //         alignment: Alignment.center,
                        //             //         decoration: BoxDecoration(
                        //             //           border: Border.all(
                        //             //               color: Colors.grey),
                        //             //           borderRadius:
                        //             //               BorderRadius.circular(14),
                        //             //           // color: selectedTipIndex == 3 ? Colors.blue : Colors.white,
                        //             //           color: AppColors.white10,
                        //             //         ),
                        //             //         child: Row(
                        //             //           children: [
                        //             //             Image.asset(
                        //             //               'assets/icons/clap.png',
                        //             //               height: 20,
                        //             //               width: 20,
                        //             //             ),
                        //             //             const Text(
                        //             //               'Custom',
                        //             //               style:
                        //             //                   TextStyle(fontSize: 12),
                        //             //             ),
                        //             //           ],
                        //             //         ),
                        //             //       ),
                        //             //     ),
                        //             //   ],
                        //             // ),
                        //             // if (tipController.showCustomTipField)
                        //             //   TextFormField(
                        //             //     controller:
                        //             //         tipController.textEditingController
                        //             //           ..text = tipController.customTip
                        //             //               .toString(),
                        //             //     keyboardType: TextInputType.number,
                        //             //     maxLength: 4,
                        //             //     onEditingComplete: () {
                        //             //       tipController.setTipValue();
                        //             //     },
                        //             //     decoration: InputDecoration(
                        //             //       contentPadding:
                        //             //           const EdgeInsets.symmetric(
                        //             //               horizontal: 10),
                        //             //       counterText: '',
                        //             //       prefix: GestureDetector(
                        //             //         onTap: () {
                        //             //           tipController.setTipValue();
                        //             //         },
                        //             //         child: Padding(
                        //             //           padding:
                        //             //               const EdgeInsets.all(8.0),
                        //             //           child: Container(
                        //             //             height: 30,
                        //             //             width: 50,
                        //             //             alignment: Alignment.center,
                        //             //             decoration: BoxDecoration(
                        //             //                 color: AppColors.success20,
                        //             //                 borderRadius:
                        //             //                     BorderRadius.circular(
                        //             //                         15)),
                        //             //             child: const Text(
                        //             //               'Add',
                        //             //               style: TextStyle(
                        //             //                   color:
                        //             //                       AppColors.white100),
                        //             //             ),
                        //             //           ),
                        //             //         ),
                        //             //       ),
                        //             //       suffix: IconButton(
                        //             //           onPressed: () {
                        //             //             tipController.cancelTipValue();
                        //             //           },
                        //             //           icon: const Icon(
                        //             //             Icons.cancel_outlined,
                        //             //             color: AppColors.primary,
                        //             //           )),
                        //             //     ),
                        //             //   ),
                        //           ],
                        //         );
                        //       }),
                        //     )),
                        const SizedBox(height: 15),
                        // const DeliveryInstruction(),
                        // ContainerWidget(
                        //     width: size.width,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const Text(
                        //             'Delivery Instruction',
                        //             style:
                        //                 AppTextStyles.kBody17SemiboldTextStyle,
                        //           ),
                        //           Text(
                        //             'Delivery partner will be notified ',
                        //             style: AppTextStyles
                        //                 .kCaption12RegularTextStyle
                        //                 .copyWith(color: AppColors.white60),
                        //           ),
                        //           const SizedBox(
                        //             height: 10,
                        //           ),
                        //           SizedBox(
                        //             height: 100,
                        //             child: GetBuilder<InstructionController>(
                        //                 builder: (instructionController) {
                        //               return ListView.builder(
                        //                   scrollDirection: Axis.horizontal,
                        //                   itemCount: instructionController
                        //                       .title.length,
                        //                   itemBuilder:
                        //                       (BuildContext contex, index) {
                        //                     return GestureDetector(
                        //                       onTap: () {
                        //                         setState(() {
                        //                           instructionController
                        //                                       .selectedItems[
                        //                                   index] =
                        //                               !instructionController
                        //                                   .selectedItems[index];
                        //                           instructionController
                        //                               .toggleSelectedString(
                        //                                   instructionController
                        //                                       .title[index]);
                        //                         });
                        //                       },
                        //                       child: Container(
                        //                         margin: const EdgeInsets.only(
                        //                             right: 12),
                        //                         width: 120,
                        //                         decoration: BoxDecoration(
                        //                           color: instructionController
                        //                                   .selectedItems[index]
                        //                               ? AppColors.success10
                        //                               : null,
                        //                           border: Border.all(
                        //                               color: AppColors.white30,
                        //                               width: 1),
                        //                           borderRadius:
                        //                               BorderRadius.circular(15),
                        //                         ),
                        //                         child: Column(
                        //                           children: [
                        //                             Padding(
                        //                               padding:
                        //                                   const EdgeInsets.all(
                        //                                       5.0),
                        //                               child: Image.asset(
                        //                                 instructionController
                        //                                     .img[index],
                        //                                 height: 50,
                        //                                 width: 50,
                        //                               ),
                        //                             ),
                        //                             Expanded(
                        //                               child: Container(
                        //                                 alignment:
                        //                                     Alignment.center,
                        //                                 width: size.width,
                        //                                 decoration: BoxDecoration(
                        //                                     color: instructionController
                        //                                                 .selectedItems[
                        //                                             index]
                        //                                         ? AppColors
                        //                                             .success20
                        //                                         : AppColors
                        //                                             .white30,
                        //                                     borderRadius:
                        //                                         const BorderRadius
                        //                                                 .only(
                        //                                             bottomLeft:
                        //                                                 Radius.circular(
                        //                                                     15),
                        //                                             bottomRight:
                        //                                                 Radius.circular(
                        //                                                     15))),
                        //                                 child: Text(
                        //                                   textAlign:
                        //                                       TextAlign.center,
                        //                                   instructionController
                        //                                       .title[index],
                        //                                   style: AppTextStyles
                        //                                       .kBody15SemiboldTextStyle,
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     );
                        //                   });
                        //             }),
                        //           ),
                        //         ],
                        //       ),
                        //     )),
                        const SizedBox(
                          height: 15,
                        ),
                        // ContainerWidget(
                        //     child: ListTile(
                        //   onTap: () {
                        //     Get.to(const CancellationPolicy());
                        //   },
                        //   leading: Image.asset('assets/icons/cancle.png'),
                        //   title: const Text('Cancellation Policy'),
                        //   trailing: const Icon(
                        //     Icons.arrow_forward_ios_rounded,
                        //     color: AppColors.white70,
                        //   ),
                        // )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 110,
              width: size.width,
              decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.white30))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addressController.label != 'null'
                              ? "${addressController.label} - "
                              : "OTHER - ",
                          style: AppTextStyles.kCaption12SemiboldTextStyle
                              .copyWith(color: AppColors.white100),
                        ),
                        SizedBox(
                          width: size.width * 0.53,
                          child: Text(
                            addressController.address.trimLeft(),
                            textAlign: TextAlign.start,
                            style: AppTextStyles.kSmall10RegularTextStyle
                                .copyWith(color: AppColors.white80),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 14,
                        ),
                        GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  // return ChangeAddress();
                                  return Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Text(
                                            'Select an Address',
                                            style: AppTextStyles
                                                .kBody17SemiboldTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.off(const AddNewAddresMap());
                                            },
                                            child: SizedBox(
                                              height: 50,
                                              width: size.width,
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    child: Icon(
                                                      Icons
                                                          .add_circle_outline_rounded,
                                                      color: AppColors.primary,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Add Address',
                                                    style: AppTextStyles
                                                        .kBody15SemiboldTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .primary),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 1,
                                          ),
                                          const SizedBox(
                                            height: 16.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'SAVED ADDRESSES',
                                                  style: AppTextStyles
                                                      .kBody15RegularTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .white70),
                                                )),
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            height: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'You are currently near',
                                                  style: AppTextStyles
                                                      .kBody15RegularTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .success40),
                                                )),
                                          ),
                                          Expanded(
                                              child: NotificationListener<
                                                  OverscrollIndicatorNotification>(
                                            onNotification: (notification) {
                                              notification.disallowIndicator();
                                              return true;
                                            },
                                            child:
                                                GetBuilder<AddressController>(
                                                    builder:
                                                        (addressController) {
                                              return ListView.builder(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  itemCount: addressController
                                                      .fetchAddress.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          index) {
                                                    final add =
                                                        addressController
                                                                .fetchAddress[
                                                            index];
                                                    var label =
                                                        add['label'].toString();
                                                    var address =
                                                        "${add['house_floor_no'] ?? ''} ${add['name'] ?? ''} ${add['landmark'] ?? ''} ${add['map']}";
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              addressController
                                                                      .address =
                                                                  address;
                                                              addressController
                                                                  .label = add[
                                                                      'label']
                                                                  .toString();
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          leading:
                                                              const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0),
                                                            child: Icon(
                                                              Icons.location_on,
                                                              color: AppColors
                                                                  .primary600,
                                                            ),
                                                          ),
                                                          horizontalTitleGap: 0,
                                                          title: Text(
                                                            label != "null"
                                                                ? label
                                                                : "Other",
                                                            style: AppTextStyles
                                                                .kCaption12SemiboldTextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .primary),
                                                          ),
                                                          subtitle: Text(address
                                                              .trimLeft()),
                                                          trailing:
                                                              PopupMenuButton(
                                                            onOpened: () {
                                                              if (kDebugMode) {
                                                                print(add['id']
                                                                    .toString());
                                                              }
                                                            },
                                                            elevation: 1.5,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            itemBuilder:
                                                                (context) {
                                                              return [
                                                                PopupMenuItem(
                                                                  onTap: () {
                                                                    print(add['id']
                                                                        .toString());
                                                                    addressController.deleteAddress(add['id']
                                                                    );
                                                                    // print('suraj');
                                                                  },
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                          'Delete Address'),
                                                                      Icon(Icons
                                                                          .delete_forever_rounded),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ];
                                                            },
                                                          ),
                                                        ),
                                                        const Divider(
                                                          thickness: 0.8,
                                                        )
                                                      ],
                                                    );
                                                  });
                                            }),
                                          ))
                                        ],
                                      ));
                                },
                              );
                            },
                            child: Text(
                              'CHANGE ADDRESS',
                              style: AppTextStyles.kSmall10SemiboldTextStyle
                                  .copyWith(color: AppColors.primary),
                            )),
                      ],
                    ),
                    const Divider(height: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<String>(
                          initialValue: selectedOption,
                          onSelected: (value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: 'online',
                              child: RadioListTile(
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Online'),
                                subtitle: const Text(
                                  'Online/Card/UPI',
                                  style: AppTextStyles.kSmall10RegularTextStyle,
                                ),
                                value: 'online',
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    // selectedOption = value!;
                                  });
                                  Navigator.pop(context, value);
                                },
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'cod',
                              child: RadioListTile(
                                activeColor: AppColors.primary,
                                contentPadding: EdgeInsets.zero,
                                title: const Text('COD'),
                                subtitle: const Text(
                                  'Cash on delivery',
                                  style: AppTextStyles.kSmall10RegularTextStyle,
                                ),
                                value: 'cod',
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                  Navigator.pop(context, value);
                                },
                              ),
                            ),
                          ],
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '    Pay Using',
                                    style: AppTextStyles
                                        .kSmall10RegularTextStyle
                                        .copyWith(color: AppColors.white70),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.white70,
                                  ),
                                ],
                              ),
                              Text(
                                  selectedOption == 'online'
                                      ? 'Online/UPI'
                                      : 'COD',
                                  style: AppTextStyles
                                      .kCaption12SemiboldTextStyle),
                            ],
                          ),
                        ),
                        GetBuilder<TipController>(builder: (tipController) {
                          return SizedBox(
                            width: size.width * 0.7,
                            child: ElevatedButton(
                                onPressed: () {
                                  sendCartToApi(
                                      // shoppingCart ,
                                      productListForApi.cast<List<Map<String, dynamic>>>(),
                                      '${grandTotal + tipController.customTip.toInt()}',
                                      selectedOption,
                                      addressController.address);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total',
                                          style: AppTextStyles
                                              .kSmall10RegularTextStyle
                                              .copyWith(
                                            color: AppColors.white30,
                                          ),
                                        ),
                                        Obx(
                                              () =>
                                              Text('₹${(grandTotal + tipController.customTip.toInt()).toStringAsFixed(2)}', style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white)),

                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Text(
                                      'Place Order',
                                      style: AppTextStyles
                                          .kBody17SemiboldTextStyle,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 17,
                                    ),
                                  ],
                                )),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
