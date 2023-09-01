import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';
import '../../CheckoutScreen/section/bill_summary.dart';

class OrderDetails extends StatefulWidget {

  final dynamic order;
  const OrderDetails({Key? key, this.order}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderData = widget.order;
    orderDetails = orderData['order_details'];
    userDetails = orderData['user_details'];
  }
   late dynamic orderData;
   List orderDetails=[];
   late dynamic userDetails;

  @override
  Widget build(BuildContext context) {

    final String order_date = orderData['order_date'].toString();
    DateTime parsedDateTime = DateTime.parse(order_date);
    String formattedDateTime = DateFormat("dd MMM yyyy 'at' hh:mm a").format(parsedDateTime);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // shadowColor: AppColors.white,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.white100,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Order Details',
          style: AppTextStyles.kBody15SemiboldTextStyle
              .copyWith(color: AppColors.white100),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              CupertinoIcons.question_circle,
              color: AppColors.white100,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ContainerWidget(
                  width: size.width,
                  // height: size.height*0.4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        lightText('Order ID'),
                        darkText(orderData['id'].toString()),

                        lightText('Order from'),
                        darkText(orderData['store']['name'].toString(),),

                        lightText('Order status'),
                        darkText(orderData['order_status'].toString()),

                        lightText('Delivering at'),
                        darkText(orderData['address'].toString()),

                        lightText('Delivery Instructions'),
                        darkText(orderData['instruction'].toString()),

                        lightText('Date & Time'),
                        darkText(formattedDateTime),
                      ],
                    ),
                  )),
              const SizedBox(height: 15,),
              BillSummary(order: widget.order,),
              const SizedBox(height: 15,),
              ContainerWidget(child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Total Items : ${orderDetails.length}",style: AppTextStyles.kBody15SemiboldTextStyle,)),
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: orderDetails.length,
                      itemBuilder: (BuildContext contex,index){
                      final orderList = orderDetails[index];
                      String quantity = orderList['size'].toString()+orderList['unit'].toString();
                      String price = '${orderList['price']*orderList['quantity']}';
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          orderList['product']['image'].toString(),
                          height: 80,
                          width: 70,
                           fit: BoxFit.fill),
                      ),
                      title: Text(orderList['product_name'].toString()),
                      subtitle:  Text(quantity),
                      trailing: Text('₹$price',style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.primary),),
                    );
                  }),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget lightText(final String text,)
  {
    return Text(
      text,
      style: AppTextStyles.kCaption12RegularTextStyle
          .copyWith(color: AppColors.white60),
    );
  }
  Widget darkText( String text){
    return Column(
      children: [
        Text(
          text,
          style: AppTextStyles.kBody15SemiboldTextStyle
              .copyWith(color: AppColors.white100),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}
