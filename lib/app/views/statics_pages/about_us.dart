import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 1.5,
        titleTextStyle: AppTextStyles.kHeading3TextStyle.copyWith(color: AppColors.white90),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded,color: AppColors.white90,)),
        backgroundColor: AppColors.white10,
        centerTitle: true,
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/applogo.png',height: 120,width: 120,),
              ),
              const SizedBox(height: 10,),
              Text(
                textAlign: TextAlign.justify,
                "Contact Us on : +918077613894 or support@krush_e_marg.in krush_e_marg is a delivery app that delivers anything to your door in few minutes. Food, Vegetables, Grocery, Makeup, Fashion shopping, or on-demand delivery, krush_e_marg is the only delivery app in the area you will ever need.",
                style: AppTextStyles.kBody15RegularTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                textAlign: TextAlign.justify,
                "- Get Groceries from your local stores to your door.",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                "- Get Food from your Favorite vendor or restaurants to your door",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                textAlign: TextAlign.justify,
                "- Get medicines delivered from local chemists near you - Send packages anywhere within the city ",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                "Why krush_e_marg?",
                style: AppTextStyles.kBody17SemiboldTextStyle
                    .copyWith(color: AppColors.white100,decoration:TextDecoration.underline,),
              ),
              const SizedBox(height: 20,),
              Text(
                textAlign: TextAlign.justify,
                "- We're the fastest and only; get home delivery in few mins - we Deliver sb kuch; Apke door tak.",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                "- Order from anywhere; we'll deliver",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),
              Text(
                "-Make payments online for a smooth experience.",
                style: AppTextStyles.kBody15SemiboldTextStyle
                    .copyWith(color: AppColors.white100),
              ),const SizedBox(height: 20,),
              Text(
                "Order Things online",
                style: AppTextStyles.kBody17SemiboldTextStyle
                    .copyWith(color: AppColors.white100,decoration:TextDecoration.underline,),
              ),
              const SizedBox(height: 20,),
              Text(
                textAlign: TextAlign.justify,
                "With online delivery system across your city, you can get your favorites delivered at your doorstep within few minutes. Track your order",
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
