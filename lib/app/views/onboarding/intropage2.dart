import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../auth/welcomeScreen.dart';

class IntroPage2 extends StatefulWidget {
  final PageController controller;
  const IntroPage2({super.key, required this.controller});

  @override
  State<IntroPage2> createState() => _IntroPage2State();
}

class _IntroPage2State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0, child: Image.asset('assets/images/lady.png')),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: size.width,
            height: size.height * 0.36,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Medicine',
                  style: AppTextStyles.kHeading2TextStyle
                      .copyWith(color: AppColors.white, fontSize: 28),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: size.width*0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Stay healthy with easy access to a wide range of medicine options, including prescription and over the counter options.',
                    style: AppTextStyles.kBody20RegularTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const WelcomeScreen());
                        },
                        child: Text(
                          'Skip',
                          style: AppTextStyles.kBody15SemiboldTextStyle
                              .copyWith(color: AppColors.white, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 88,
                        height: 44,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor: AppColors.white,
                            ),
                            onPressed: () {
                              widget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Center(
                              child: Text(
                                'Next',
                                style: AppTextStyles.kBody15SemiboldTextStyle
                                    .copyWith(
                                        color: AppColors.primary700,
                                        fontSize: 15),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
