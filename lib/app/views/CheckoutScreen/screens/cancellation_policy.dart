import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CancellationPolicy extends StatefulWidget {
  const CancellationPolicy({Key? key}) : super(key: key);

  @override
  State<CancellationPolicy> createState() => _CancellationPolicyState();
}

class _CancellationPolicyState extends State<CancellationPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(onPressed: () {Get.back();}, icon: const Icon(Icons.arrow_back_ios_new_rounded,color: AppColors.white100,),),
        title: Text('Cancellation Policy',style: AppTextStyles.kBody20SemiboldTextStyle.copyWith(color: AppColors.white100),),
        actions: [
          Image.asset('assets/icons/cancle.png'),
        ],
      ),
      body: const Center(
        child: Text('we are working on it'),
      ),
    );
  }
}
