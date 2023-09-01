import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

import '../../colors/colors_const.dart';

class SignInUpButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback? onpressed;
  const SignInUpButtonWidget({super.key, required this.text, this.onpressed});

  @override
  State<SignInUpButtonWidget> createState() => _SignInUpButtonWidgetState();
}

class _SignInUpButtonWidgetState extends State<SignInUpButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: SizedBox(
        height: 50,
        width: size.width * 0.85,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            onPressed: widget.onpressed,
            child: Center(
              child: widget.text == 'Get Otp'||widget.text=='Verify & Proceed'
                  ? Text(
                      widget.text,
                      style: AppTextStyles.kBody15SemiboldTextStyle
                          .copyWith(color: AppColors.white, fontSize: 15),
                    )
                  : const CircularProgressIndicator(
                      color: AppColors.white,
                    ),
            )),
      ),
    );
  }
}
