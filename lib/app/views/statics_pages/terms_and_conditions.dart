import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class TermsandConditions extends StatelessWidget {
  const TermsandConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> name =[
      " We offer shipping for all orders over â,¹ 59 with Shipping Charges, which varies depending upon location.",
      " Order confirmations will include a tracking number. If you do not receive this confirmation email, please check your spam or junk folder. If you still have not received it, please email customer service (support@krush_e_marg.in) or call us at +91-8077613894 and we will send it to you shortly.",
      " Please note that orders containing multiple items may arrive in separate packages. Products on our site may be shipped directly from the vendor.",
      " Most of our partners ship between 30 Min to 60 Min. Some Crucial Items may be subject to longer shipping times. If you need an item to arrive at a certain time, please email us at customer service.",

    ];
    return Scaffold(
      backgroundColor: AppColors.white10,
      appBar: AppBar(
        elevation: 1.5,
        titleTextStyle: AppTextStyles.kHeading3TextStyle.copyWith(color: AppColors.white90),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        backgroundColor: AppColors.white10,
        centerTitle: true,
        title: const Text("Terms and Conditions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.justify,
                "krush_e_marg agrees to ship orders on behalf of All Marchents Present on Its Plateform (APP/Website) to customers Registred with it. When an order is placed on Marchent Name for AAGYOâ€™s products, the order information will be communicated within 24 hours to the Customer and Marchent as well as the Success Manager or customer database via Conviction. krush_e_marg Agrees to ship in-stock products within 24 business hours after the order has been communicated. Please refer to below for more information on Shipping Policy:-",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ), const SizedBox(height:20),
              SizedBox(
                child: ListView.builder(
                    itemCount: name.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ",style: TextStyle(fontSize: 35),),
                      Expanded(child: Text(
                        textAlign: TextAlign.justify,
                        name[index], style: AppTextStyles.kBody15RegularTextStyle
                          .copyWith(color: AppColors.white100),))
                    ],
                  );
                }),
              ), const SizedBox(height:20),
              Text(textAlign: TextAlign.justify,
                "All rights are Reserved with krush_e_marg (FSTMD Private Limited). The company can Change Its policies from time to time Depending on the Situation. For any Quarry Contact us at support@krush_e_marg.in or +91-8077613894.",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),

            ]
          ),
        ),
      ),
    );
  }
}
