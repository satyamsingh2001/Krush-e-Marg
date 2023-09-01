import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:krush_e_marg/app/constwidgets/container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/count_down_progress_indicator.dart';
import '../widgets/order_stepper.dart';
import 'order_details.dart';

class TrackOrder extends StatefulWidget {
  final dynamic order;
  const TrackOrder({Key? key, this.order}) : super(key: key);

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {

  @override
  void initState() {
    // TODO: implement initState
    orderDetails = widget.order['order_details'];
  }
  List orderDetails=[];

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              CupertinoIcons.question_circle,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.secondary500,
                  height: size.height * 0.3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                            height: size.height * 0.16,
                            width: size.height * 0.16,
                            child: const CountDownProgressIndicator(
                              strokeWidth: 13,
                              backgroundColor: AppColors.primary,
                              duration: 120,
                              valueColor: AppColors.white60,
                            )),
                      ),
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
                      SizedBox(height: size.height*0.1,),
                      GestureDetector(
                        onTap: (){
                          Get.to(OrderDetails(order: widget.order,));
                        },
                        child: ContainerWidget(
                            child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                style: AppTextStyles.kBody15SemiboldTextStyle
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
                const OrderStepper(),
                const SizedBox(height: 20,)
              ],
            ),
            Positioned(
                top: size.height*0.2,
                left: size.width*0.025,
                child: SizedBox(
              height: size.height*0.21,
              width: size.width*0.950,
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
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Text('Your order is on the way',style: AppTextStyles.kCaption12SemiboldTextStyle.copyWith(
                          color: AppColors.white
                        ),),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbe5lVlX7uvjt0kpB7EeSfos5pZb7Vb9me7g&usqp=CAU',height: 60,width: 60,),
                          ),
                          const SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Delivery partner',style: AppTextStyles.kBody15RegularTextStyle.copyWith(
                                color: AppColors.white60
                              ),),
                              Text('Sunil Chaudary',style: AppTextStyles.kBody17SemiboldTextStyle.copyWith(
                                color: AppColors.white100
                              ),),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFADCE1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 1),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/injection.png',height: 30,width: 30,),
                                      const Text('Vaccinated'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: size.width*0.18,),
                          Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: IconButton(onPressed: (){},
                                icon: const Icon(Icons.call,color: AppColors.white,)),
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
    );
  }
}