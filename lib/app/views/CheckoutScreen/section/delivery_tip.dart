import 'package:flutter/material.dart';

import '../../../colors/colors_const.dart';
import '../../../textstyles/textstyle_const.dart';

class TipContainer extends StatefulWidget {
  final String img;
  final String text;
  VoidCallback? onTap;
  TipContainer({Key? key, required this.img, required this.text, this.onTap}) : super(key: key);

  @override
  State<TipContainer> createState() => _TipContainerState();
}

class _TipContainerState extends State<TipContainer> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.white40)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(widget.img,height: 20,width: 20,),
            Text(widget.text,style: AppTextStyles.kCaption12SemiboldTextStyle,),
          ],
        ),
      ),
    );
  }
}

