import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bottom_nav_bar/shops/views/shope_page.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_rounded)),
        elevation: 0,
        backgroundColor: AppColors.white,
       iconTheme: const IconThemeData(color: AppColors.white90),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/emptycart.png',height: 150,width: 150,),
            const SizedBox(height: 10,),
            const Text('Your cart is empty'),
            TextButton(onPressed: (){
              Get.off(const ShopPage());
            },
                child:const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }
}