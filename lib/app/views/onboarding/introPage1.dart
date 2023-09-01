import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/welcomeScreen.dart';
import '../../colors/colors_const.dart';
import '../../textstyles/textstyle_const.dart';

class IntroPage1 extends StatefulWidget {
  final PageController controller;
  const IntroPage1({super.key, required this.controller});

  @override
  State<IntroPage1> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: size.height * 0.12,
            right: 0,
            left: 0,
            child: Image.asset('assets/images/boy.png')),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: size.width,
            height: size.height * 0.36,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Grocery',
                  style: AppTextStyles.kHeading2TextStyle
                      .copyWith(color: AppColors.white, fontSize: 28),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Effortlessly shop for all your grocery needs with our user-friendly app. Everything you need in one place.',
                    style: AppTextStyles.kBody20RegularTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 35),
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
