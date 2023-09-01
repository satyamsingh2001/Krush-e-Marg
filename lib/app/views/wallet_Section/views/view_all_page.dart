import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import 'all _transaction/Debits.dart';
import 'all _transaction/all.dart';
import 'all _transaction/credits.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
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
          'Activity',
          style: AppTextStyles.kBody17SemiboldTextStyle
              .copyWith(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      border: Border.all(
                          color: _currentPage == 0
                              ? AppColors.primary700
                              : AppColors.white50),
                      borderRadius: BorderRadius.circular(50),
                      color: _currentPage == 0
                          ? AppColors.primary700
                          : AppColors.white),
                  child: Text(
                    'All',
                    style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                        color: _currentPage == 0
                            ? AppColors.white
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
                      border: Border.all(
                          color: _currentPage == 1
                              ? AppColors.primary700
                              : AppColors.white50),
                      borderRadius: BorderRadius.circular(50),
                      color: _currentPage == 1
                          ? AppColors.primary700
                          : AppColors.white,
                    ),
                    child: Text('Debits',
                        style: AppTextStyles.kBody15SemiboldTextStyle
                            .copyWith(
                                color: _currentPage == 1
                                    ? AppColors.white
                                    : AppColors.white50))),
              ),
              GestureDetector(
                onTap: () {
                  _pageController.animateToPage(2,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                  setState(() {
                    _currentPage = 2;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _currentPage == 2
                              ? AppColors.primary700
                              : AppColors.white50),
                      borderRadius: BorderRadius.circular(50),
                      color: _currentPage == 2
                          ? AppColors.primary700
                          : AppColors.white),
                  child: Text(
                    'Credits',
                    style: AppTextStyles.kBody15SemiboldTextStyle.copyWith(
                        color: _currentPage == 2
                            ? AppColors.white
                            : AppColors.white50),
                  ),
                ),
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
                AllTransaction(),
                DebitsTransaction(),
                CreditsTransaction(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
