import 'package:flutter/material.dart';
import 'package:krush_e_marg/app/colors/colors_const.dart';
import 'package:krush_e_marg/app/textstyles/textstyle_const.dart';

class ProfileOptionWidgets extends StatefulWidget {
  final String image;
  final String title;
  final VoidCallback? isPressed;
  const ProfileOptionWidgets(
      {super.key, required this.image, required this.title, this.isPressed});

  @override
  State<ProfileOptionWidgets> createState() => _ProfileOptionWidgetsState();
}

class _ProfileOptionWidgetsState extends State<ProfileOptionWidgets> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isPressed,
      child: Container(
        height: 80,
        width: 97,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.white30,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.image,height: 50,width: 45,),
            Text(
              widget.title,
              style: AppTextStyles.kCaption12RegularTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
