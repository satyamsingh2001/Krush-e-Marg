import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../constwidgets/container_widget.dart';
import '../../../textstyles/textstyle_const.dart';


class BillSummary extends StatefulWidget {

  final dynamic order;
  const BillSummary({Key? key, this.order}) : super(key: key);

  @override
  State<BillSummary> createState() => _BillSummaryState();
}

class _BillSummaryState extends State<BillSummary> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderData = widget.order;
    orderDetails = orderData['order_details'];
  }

  late dynamic orderData;
  List orderDetails=[];

  @override
  Widget build(BuildContext context) {
    double price = 0;
    for(int i=0;i<orderDetails.length;i++){
      var orderList = orderDetails[i];
      String totalPrice = '${orderList['price']*orderList['quantity']}';
      price += double.parse(totalPrice);
    }

    Size size = MediaQuery.of(context).size;
    return ContainerWidget(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bill Summary',
                style: AppTextStyles.kBody17RegularTextStyle,
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children:[
                  const Text(
                    'Total',
                    style:
                    AppTextStyles.kBody15SemiboldTextStyle,
                  ),
                  const Spacer(),
                  Text(
                    '₹${price.toStringAsFixed(2)}',
                    style:
                    AppTextStyles.kBody15RegularTextStyle,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment:
              //   MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Handling Charge',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white60),
              //     ),
              //
              //    const Spacer(),
              //     const SizedBox(width: 5,),
              //     Text(
              //       '₹${orderData['package_fees']}',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white100),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 3,),
              // Row(
              //   mainAxisAlignment:
              //   MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Delivery fee',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white60),
              //     ),
              //
              //    const Spacer(),
              //     Text(
              //       '₹${orderData['shipping_charges']}',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white100),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 3,),
              // Row(
              //   children: [
              //     Text(
              //       'Delivery Partner Tip',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white60),
              //     ),
              //   const Spacer(),
              //     Text(
              //       '₹${orderData['delivery_tip']}',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.white60),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 5,),
              //
              // const Divider(),
              // Row(
              //   children: [
              //     Text(
              //       'Offer Discount',
              //       style: AppTextStyles.kCaption12RegularTextStyle
              //           .copyWith(color: AppColors.success40),
              //     ),
              //     const Spacer(),
              //     Text(
              //       '- ₹${orderData['coupon_discount']}',
              //       style: AppTextStyles.kCaption12SemiboldTextStyle,
              //     ),
              //   ],
              // ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Grand Total',
                    style:
                    AppTextStyles.kBody15SemiboldTextStyle,
                  ),
                  Text(
                    '₹${orderData['total_amount']}',
                    style:
                    AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
