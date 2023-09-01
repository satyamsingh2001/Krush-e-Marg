import 'package:flutter/material.dart';
import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class Screen1 extends StatefulWidget {
  final PageController controller;
  const Screen1({super.key, required this.controller});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/courierimages/screen1.png',),
        const SizedBox(
          height: 18,
        ),
        Text(
          textAlign: TextAlign.center,
          'Door to Door Parcel Delivery Service',
          style: AppTextStyles.kHeading2TextStyle
              .copyWith(color: AppColors.white100),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          textAlign: TextAlign.center,
          'Your local courier for sending all kinds of parcels',
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
