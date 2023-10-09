import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../controller/order_api_controller.dart';
import 'order_details.dart';

class YourOrder extends StatefulWidget {
  const YourOrder({Key? key}) : super(key: key);

  @override
  State<YourOrder> createState() => _YourOrderState();
}

class _YourOrderState extends State<YourOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchOrderList();
    // orderApiController.fetchOrderList();
  }

  OrderApiController orderApiController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: AppColors.primary,
        title: Text(
          'Your Orders',
          style: AppTextStyles.kBody20RegularTextStyle
              .copyWith(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<OrderApiController>(
        builder: (orderApiController) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
              itemCount: orderApiController.orderHistory.length,
              itemBuilder: (BuildContext context, index) {
                final order = orderApiController.orderHistory[index];
                final String orderDate = order['order_date'].toString();
                DateTime parsedDateTime = DateTime.parse(orderDate);
                String formattedDateTime = DateFormat("dd MMM yyyy 'at' hh:mm a").format(parsedDateTime);
                List orderDetails = order['order_details'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                  child: ContainerWidget(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Order ID: ${order['id']}'.toString(),
                                  style: AppTextStyles.kBody17SemiboldTextStyle,
                                ),
                                Text(
                                 // " order['store']['name'].toString()",
                                  order['store']['name'].toString(),
                                  style: AppTextStyles.kBody15RegularTextStyle,
                                ),
                                Text(
                                  // "date",
                                    formattedDateTime,
                                  style: AppTextStyles.kCaption12RegularTextStyle
                                      .copyWith(color: AppColors.white60),
                                ),
                              ],
                            ),
                            ContainerWidget(
                                height: 35,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.5,
                                    backgroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.to(OrderDetails(order: order,));

                                    // if (index == 0) {
                                    //   Get.to(TrackOrder(order: order,));
                                    // }else{
                                    //   Get.to(OrderDetails(order: order,));
                                    // }
                                  },
                                  child: Text(
                                    orderApiController.viewOrder[index],
                                    style: AppTextStyles
                                        .kCaption12SemiboldTextStyle
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColors.white20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 0, right: 15, bottom: 8),
                        child: SizedBox(
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ConstColumn(title: 'Items', subtitle: orderDetails.length.toString(),),
                              const VerticalDivider(thickness: 1,color: AppColors.white20,),
                              ConstColumn(title: 'Total', subtitle:"₹${order['total_amount']}"),
                              const VerticalDivider(thickness: 1,color: AppColors.white20,),
                              ConstColumn(title: 'Payment', subtitle:order['payment_method'].toString()),
                              const VerticalDivider(thickness: 1,color: AppColors.white20,),
                              SizedBox(
                                height: 45,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Status',
                                      style: AppTextStyles.kBody15SemiboldTextStyle,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Text(
                                            "",
                                            // order['order_status'].toString(),
                                            style: AppTextStyles
                                                .kCaption12RegularTextStyle,
                                          ),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                  ),
                );
              });
        }
      ),
    );
  }
}

class ConstColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  const ConstColumn({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.kBody15SemiboldTextStyle,
          ),
          Text(
            subtitle,
            style:
            AppTextStyles.kBody15RegularTextStyle,
          ),
        ],
      ),
    );
  }
}

