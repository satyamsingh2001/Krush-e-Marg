import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../colors/colors_const.dart';
import '../../../../database/database_helper2.dart';
import '../../../../textstyles/textstyle_const.dart';
import '../../../CheckoutScreen/views/checkout_screen.dart';



class CheckoutFloatingButton extends StatefulWidget {
  const CheckoutFloatingButton({Key? key}) : super(key: key);

  @override
  State<CheckoutFloatingButton> createState() => _CheckoutFloatingButtonState();
}

class _CheckoutFloatingButtonState extends State<CheckoutFloatingButton> {

  // @override
  // void initState() {
  //   super.initState();
  //   fetchProducts();
  // }
  //
  // List<Product> productList = [];
  // void fetchProducts() async {
  //   final dbHelper = DatabaseHelper.instance;
  //   final products = await dbHelper.getProducts();
  //   setState(() {
  //     productList = products;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  List<Product> productList = [];
  void fetchProducts() async {
    final products = await ProductDatabase.instance.fetchProducts();
    setState(() {
      productList = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return productList.isNotEmpty
        ? InkWell(
            onTap: () {
              Get.to(const CheckoutScreeen());
            },
            child: Container(
              height: 45,
              width: size.width * 0.91,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${productList.length} Item',
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white),
                    ),
                    Container(
                      height: 15,
                      width: 2,
                      color: Colors.white,
                    ),
                    Text(
                      '₹400',
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white),
                    ),
                    SizedBox(
                      width: size.width * 0.45,
                    ),
                    Text(
                      'Next',
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
