import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/container_widget.dart';
import '../../../constwidgets/counter_widgets.dart';
import '../../../controller/api_controller.dart';
import '../../../database/database_helper2.dart';
import '../../../textstyles/textstyle_const.dart';
import '../api/checkout_api.dart';
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
      productListForApi =
          products.map((product) => product.toMapForApi()).toList();
    });
  }

  void fetchProducts() async {
    final products = await ProductDatabase.instance.fetchProducts();
    setState(() {
      productList = products;
      productListForApi =
          products.map((product) => product.toMapForApi()).toList();
    });
  }





  List<bool> items=[];

  var map;
  var partnerTip=0;
  bool tipSelected=false;
  String couponTitle = 'Apply Coupons';
  String couponCode = "";
  double offerDiscount = 0;
  int requiredPurchase = 0;
  int? maxDiscount;
  String selectedOption = 'cod';
  bool showCharge = false;
  List quant = [];
  String couponType = '';
  String discountTyp = '';
  String dis = '';
  String? message;

  @override
  Widget build(BuildContext context) {

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
                            // print(productList[index].storeId);
                            // print("productList");
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
                                                    counterValue:
                                                        productList[index]
                                                            .quantity,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                        const SizedBox(height: 15),
                        const SizedBox(
                          height: 15,
                        ),
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
                                                                    addressController.deleteAddress(add['id']);
                                                                    addressController.fetchAddress;
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
                            // PopupMenuItem<String>(
                            //   value: 'online',
                            //   child: RadioListTile(
                            //     activeColor: AppColors.primary,
                            //     contentPadding: EdgeInsets.zero,
                            //     title: const Text('Online'),
                            //     subtitle: const Text(
                            //       'Online/Card/UPI',
                            //       style: AppTextStyles.kSmall10RegularTextStyle,
                            //     ),
                            //     value: 'online',
                            //     groupValue: selectedOption,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         // selectedOption = value!;
                            //       });
                            //       Navigator.pop(context, value);
                            //     },
                            //   ),
                            // ),
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
                                      productListForApi,
                                      '${grandTotal + tipController.customTip.toInt()}',
                                      "cod",
                                      addressController.address
                                  );
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
