import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:krush_e_marg/app/views/onboarding/introPage1.dart';
import 'package:krush_e_marg/app/views/onboarding/introPage3.dart';
import 'package:krush_e_marg/app/views/onboarding/introPage4.dart';
import 'package:krush_e_marg/app/views/onboarding/intropage2.dart';

import '../../colors/colors_const.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.height*0.390,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: AppColors.white50.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 2))
                ],
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: PageView(
              controller: controller,
              children: [
                IntroPage1(controller: controller),
                IntroPage2(
                  controller: controller,
                ),
                IntroPage3(
                  controller: controller,
                ),
                const Intro4()
              ],
            ),
          ),
          Positioned(
            bottom: size.height*0.14,
            child: SmoothPageIndicator(
                controller: controller,
                count: 4,
                effect: const ExpandingDotsEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppColors.primary600,
                  dotColor: AppColors.white,
                )),
          ),
        ],
      ),
    );
  }
}
