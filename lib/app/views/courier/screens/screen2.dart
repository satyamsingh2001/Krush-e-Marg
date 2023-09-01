import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

class Screen2 extends StatefulWidget {
  final PageController controller;
  const Screen2({super.key, required this.controller});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/courierimages/screen2.png',),
        const SizedBox(
          height: 18,
        ),
        Text(
          textAlign: TextAlign.center,
          'Delivering Your Package Carefully',
          style: AppTextStyles.kHeading2TextStyle
              .copyWith(color: AppColors.white100,),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          textAlign: TextAlign.center,
          'We care about your package as you do & ensure to delivery it sefely',
          style: AppTextStyles.kBody20RegularTextStyle.copyWith(
            color: AppColors.white70,
          ),
        ),
        SizedBox(height: size.height*0.12,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Text(
                  'Skip',
                  style: AppTextStyles.kBody15SemiboldTextStyle
                      .copyWith(color: AppColors.white100, fontSize: 15),
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
                      backgroundColor: AppColors.primary,
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
                            .copyWith(color: AppColors.white, fontSize: 15),
                      ),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
