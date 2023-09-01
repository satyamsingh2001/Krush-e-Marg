import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../widgets/likes_shops.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          'Likes',
          style: AppTextStyles.kBody17SemiboldTextStyle
              .copyWith(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    _currentPage = 0;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                      color: _currentPage == 0
                          ? AppColors.white40
                          : AppColors.white20),
                  child: Text(
                    'Shops',
                    style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                        color: _currentPage == 0
                            ? AppColors.white80
                            : AppColors.white50),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    _currentPage = 1;
                  });
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                      color: _currentPage == 1
                          ? AppColors.white40
                          : AppColors.white20,
                    ),
                    child: Text('Products',
                        style: AppTextStyles.kBody15SemiboldTextStyle
                            .copyWith(
                            color: _currentPage == 1
                                ? AppColors.white80
                                : AppColors.white50))),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                LikesShops(),
                LikesShops(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
