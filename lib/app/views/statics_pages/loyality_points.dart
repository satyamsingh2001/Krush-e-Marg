import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class LoyalityPoints extends StatelessWidget {
  const LoyalityPoints({Key? key}) : super(key: key);

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
        title: const Text("Loyalty Points"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:20),
                SizedBox(
                  child: ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text("Redeem",
                                        style: AppTextStyles.kBody15SemiboldTextStyle
                                            .copyWith(color: AppColors.white100),
                                      ),
                                      Text("35 Points",
                                        style: AppTextStyles.kBody17RegularTextStyle
                                            .copyWith(color: AppColors.white100),
                                      ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.white40,
                                    child: Text("Get",style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(color: AppColors.white100),),
                                  ),
                                  Column(
                                    children: [
                                      Text("Discount",
                                        style: AppTextStyles.kBody15SemiboldTextStyle
                                            .copyWith(color: AppColors.white100),
                                      ),
                                      Text("Rs99",
                                        style: AppTextStyles.kBody17SemiboldTextStyle
                                            .copyWith(color: AppColors.white100),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(color: AppColors.neutralLight,thickness: 1,)
                            ],
                          ),
                        );
                      }),
                ), const SizedBox(height:20),


              ]
          ),
        ),
      ),
    );
  }
}
