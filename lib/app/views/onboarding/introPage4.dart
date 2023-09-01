import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../auth/welcomeScreen.dart';

class Intro4 extends StatefulWidget {
  const Intro4({super.key});

  @override
  State<Intro4> createState() => _Intro4State();
}

class _Intro4State extends State<Intro4> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: size.height * 0.2,
            right: 0,
            left: 0,
            child: Image.asset('assets/images/delivery_boy.png')),
        Positioned(
          bottom: 0,
          child: SizedBox(
            width: size.width,
            height: size.height * 0.36,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'On Demand',
                  style: AppTextStyles.kHeading2TextStyle
                      .copyWith(color: AppColors.white, fontSize: 28),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: size.width*0.75,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Get your packages delivered on-demand with our fast and reliable courier service, now available at your fingertips.',
                    style: AppTextStyles.kBody20RegularTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 139,
                  height: 44,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        Get.to(const WelcomeScreen());
                      },
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: AppTextStyles.kBody15SemiboldTextStyle
                              .copyWith(
                                  color: AppColors.primary700, fontSize: 15),
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
