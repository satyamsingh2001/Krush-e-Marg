import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../bottom_nav_bar/bottom_nav_bar.dart';
import '../../shops/widgets/constalert.dart';

class SuccessAlert extends StatelessWidget {
  const SuccessAlert({super.key});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/gif/success.gif'),
            const SizedBox(height: 10,),
           const Text('Your Order placed successfully!'),
           const Text('We will confirm your order soon.'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomBtn(btnTitle: 'Go to Home', onTap: () {Get.offAll(const DashBoardScreenMain()); }, btnColor: AppColors.primary600,),
                CustomBtn(btnTitle: 'Track Order', onTap: (){ Get.offAll(const DashBoardScreenMain(currentIndex: 3,));}, btnColor: AppColors.success20,)
              ],
            )
          ],
        ),
      ),
    );
  }
}