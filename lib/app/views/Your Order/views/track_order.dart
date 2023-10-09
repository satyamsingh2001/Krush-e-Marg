import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/container_widget.dart';
import '../../../textstyles/textstyle_const.dart';
import '../controller/order_api_controller.dart';
import '../widgets/order_stepper.dart';
import 'order_details.dart';

class TrackOrder extends StatefulWidget {
  final dynamic order;
  const TrackOrder({Key? key, this.order}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    orderDetails = widget.order['order_details'];
    order = widget.order;
    if (widget.order['delievry_man'] != null) {
      deliveryBoy = widget.order['delievry_man']['user'];
    }
  }

  List orderDetails = [];
  dynamic deliveryBoy;
  dynamic order;

  OrderApiController orderApiController = Get.find();

  Future<void> refreshData() async {
    // Simulate data fetching and refresh delay
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      orderApiController.fetchOrderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: AppColors.white,
        backgroundColor: AppColors.secondary500,
        centerTitle: true,
        title: const Text(
          'Track Order',
          style: AppTextStyles.kBody15SemiboldTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: AppColors.primary,
        displacement: size.height * 0.2,

        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: [
                Column(
                  children: [
                    order['order_status'] == 'Delivered' ||
                        order['order_status'] == 'Cancelled'
                        ? const SizedBox()
                        : Container(
                      color: AppColors.secondary500,
                      height: size.height * 0.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 20),
                          //   child: SizedBox(
                          //       height: size.height * 0.16,
                          //       width: size.height * 0.16,
                          //       child: const CountDownProgressIndicator(
                          //         strokeWidth: 13,
                          //         backgroundColor: AppColors.primary,
                          //         duration: 120,
                          //         valueColor: AppColors.white60,
                          //       )),
                          // ),
                          Image.asset(
                            'assets/images/rocket.png',
                            height: size.height * 0.18,
                            width: size.height * 0.18,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          order['order_status'] == 'Delivered' ||
                              order['order_status'] == 'Cancelled'
                              ? const SizedBox(
                            height: 5,
                          )
                              : SizedBox(
                            height: size.height * 0.1,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(OrderDetails(
                                order: widget.order,
                              ));
                            },
                            child: ContainerWidget(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image.asset(
                                            'assets/images/bag.png',
                                            height: 40,
                                            width: 40,
                                          )),
                                      Text('${orderDetails.length} Items'),
                                      SizedBox(
                                        width: size.width * 0.25,
                                      ),
                                      Text(
                                        'Order Details',
                                        style: AppTextStyles
                                            .kBody15SemiboldTextStyle
                                            .copyWith(color: AppColors.primary),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    OrderStepper(
                      // order: widget.order,
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                order['order_status'] == 'Delivered' ||
                    order['order_status'] == 'Cancelled'
                    ? const SizedBox()
                    : Positioned(
                    top: size.height * 0.2,
                    left: size.width * 0.025,
                    child: SizedBox(
                      // height: size.height * 0.21,
                      width: size.width * 0.950,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Your order is ${order['order_status']}',
                                  style: AppTextStyles
                                      .kCaption12SemiboldTextStyle
                                      .copyWith(color: AppColors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              deliveryBoy == null
                                  ? const Text(
                                  "Your order is waiting for a delivery boy.\nWe'll notify you once one is assigned.")
                                  : Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(5),
                                    child: Image.network(
                                      '${deliveryBoy['image_url']}',
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Delivery partner',
                                        style: AppTextStyles
                                            .kBody15RegularTextStyle
                                            .copyWith(
                                            color: AppColors
                                                .white60),
                                      ),
                                      Text(
                                        '${deliveryBoy['f_name']} ${deliveryBoy['l_name'] ?? ''}',
                                        style: AppTextStyles
                                            .kBody17SemiboldTextStyle
                                            .copyWith(
                                            color: AppColors
                                                .white100),
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color:
                                          const Color(0xffFADCE1),
                                          borderRadius:
                                          BorderRadius.circular(
                                              5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                              horizontal: 8.0,
                                              vertical: 1),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/injection.png',
                                                height: 30,
                                                width: 30,
                                              ),
                                              const Text(
                                                  'Vaccinated'),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: size.width * 0.18,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                    child: IconButton(
                                        onPressed: () {
                                          // FlutterPhoneDirectCaller
                                          //     .callNumber(
                                          //     '${deliveryBoy['phone']}');
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: AppColors.white,
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}