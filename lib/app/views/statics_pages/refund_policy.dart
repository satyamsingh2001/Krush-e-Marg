import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 1.5,
        titleTextStyle: AppTextStyles.kHeading3TextStyle.copyWith(color: AppColors.white90),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        backgroundColor: AppColors.white10,
        centerTitle: true,
        title: const Text("Refund Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "We want you to be completely satisfied with what you order! If youâ€™re not, let us know and weâ€™ll do our best to make it right.",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "Returns/Cancellations Please note all complaints for fresh, perishable items must bemade at the time of delivery or within the same day of delivery with sufficient images for the same",
                style: AppTextStyles.kBody17SemiboldTextStyle.copyWith(
                  color: AppColors.white100,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "we are happy to help you immediately and adjust/refund the amount or replace the respective item(s) in your next order. With perishable organic items (fruits and veggies) it is difficult to replace indefinitely. We are always here to help and want you to be 100% happy with your order and appreciate your understanding!",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  textAlign: TextAlign.justify,
                  "If there are complaints with our packaged, non-perishable items",
                  style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                    color: AppColors.white100,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "we are happy to help you immediately and adjust/refund the amount or replace the respective item(s) in your next order. With perishable organic items (fruits and veggies) it is difficult to replace indefinitely. We are always here to help and want you to be 100% happy with your order and appreciate your understanding!",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Delivery",
                  style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                    color: AppColors.white100,
                  )),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.justify,
                "items in your Package against the final bill -- any discrepancies should be notified to the delivery personnel immediately. If the delivery is accepted by a staff member or the guard/watchman - please ask them to follow the same process while receiving the order. Once accepted, it will be considered fully delivered against the final bill.",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
