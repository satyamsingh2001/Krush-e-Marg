import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

class Screen3 extends StatefulWidget {
  final PageController controller;
  const Screen3({super.key, required this.controller, });

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Image.asset('assets/courierimages/screen3.png',),
        const SizedBox(
          height: 18,
        ),
        Text(
          textAlign: TextAlign.center,
          'Shipment Rate Calcutator',
          style: AppTextStyles.kHeading2TextStyle
              .copyWith(color: AppColors.white100,),
        ),
        const SizedBox(
          height: 18,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Easy to use ',
            style: AppTextStyles.kBody20RegularTextStyle.copyWith(
              color: AppColors.white70,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Calculator', style: AppTextStyles.kBody20RegularTextStyle.copyWith(
                color: AppColors.primary,fontWeight: FontWeight.bold
              ),),
              const TextSpan(text: ' to get an estimate of shipping cost'),
            ],
          ),
        ),
        SizedBox(height: size.height*0.12,),
        SizedBox(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/package.png'),
                  Text(
                    'Send package',
                    style: AppTextStyles.kBody15SemiboldTextStyle
                        .copyWith(color: AppColors.white, fontSize: 15),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
